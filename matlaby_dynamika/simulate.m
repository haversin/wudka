function [ time, dis, vel, acc ] = simulate( Mass, Q_qdq, Fiq_q, Ga_qdq, q0, end_time, n_steps )
    step = end_time/n_steps;
    dis = zeros(length(q0),n_steps+1);
    vel = zeros(length(q0),n_steps+1);
    acc = zeros(length(q0),n_steps+1);
    time = [0:step:end_time];
    
    dq = q0-q0;
    m = size(Fiq_q(q0),1);
    
    L = [Mass Fiq_q(q0)'; Fiq_q(q0) zeros(m,m)];
    R = [Q_qdq(q0,dq);Ga_qdq(q0,dq)];
    
    L\R
    %{
    for i=1:(n_steps+1)
        Fi_q = @(q) Fi_qt(q,time(i));
        try
            dis(:,i) = newtonify(Fi_q, Fiq_q, q0); % do magic
        catch err
            %err.message = strcat(err.message,' step_number = ',int2str(i));
            disp(strcat('step number = ',int2str(i)));
            rethrow(err);
            %rethrow(err);
        end
        %dis(:,i) = fsolve(Fi_q, q0);
        vel(:,i) = -Fiq_q(dis(:,i))\Fit_t(time(i));
        acc(:,i) = Fiq_q(dis(:,i))\Ga_qdqt(dis(:,i), vel(:,i), time(i));
        q0 = dis(:,i) + vel(:,i)*step + acc(:,i)*0.5*step^2;
    end
    %}
end