function [ time, dis, vel, acc ] = odesim( integralee, q0, dq0, end_time )
    n = size(q0,1);

    %{
    step = end_time/n_steps;
    dis = zeros(length(q0),n_steps+1);
    vel = zeros(length(q0),n_steps+1);
    acc = zeros(length(q0),n_steps+1);
    time = [0:step:end_time];
    %}
    n = size(q0,1);
    y0 = [q0;dq0];
    
    opts = odeset('RelTol',1e-6);
    [t,y] = ode45(integralee,[0,end_time],y0, opts);
    
    steps = size(t,1);
    time = t';
    dis = y(:,1:n)';
    vel = y(:,(n+1):2*n)';
    
    acc = zeros(n,steps);
    for i=1:steps
        a = integralee(0, [dis(:,i);vel(:,i)]);
        acc(:,i) = a((n+1):2*n,1);
    end
    
end