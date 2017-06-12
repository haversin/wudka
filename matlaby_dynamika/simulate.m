function [ time, dis, vel, acc ] = simulate( Mass, Q_qdq, Fiq_q, Ga_qdq, q0, end_time, n_steps )
    step = end_time/n_steps;
    dis = zeros(length(q0),n_steps+1);
    vel = zeros(length(q0),n_steps+1);
    acc = zeros(length(q0),n_steps+1);
    time = [0:step:end_time];
    
    q = q0;
    dq = q0-q0;
    n = size(Mass,1);
    m = size(Fiq_q(q0),1);
    
    % euler
    for i=1:(n_steps+1)
        L = [Mass Fiq_q(q)'; Fiq_q(q) zeros(m,m)];
        R = [Q_qdq(q,dq);Ga_qdq(q,dq)];
        x = L\R;
        ddq = x(1:n,1);
        
        dis(:,i) = q;
        vel(:,i) = dq;
        acc(:,i) = ddq;
        %next step
        q = q + dq*step + 0.5*ddq*step*step;
        dq = dq + ddq*step;
    end
end