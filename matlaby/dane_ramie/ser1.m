function [f df ddf] = ser1(t)

    l = sqrt(17)/5 - 0.02; 
    a = -0.3;
    omega = 0.8;
    phi = 0.1;

    f = l + a*sin(omega*t + phi);
    df = a*cos(omega*t + phi) * omega;
    ddf = -a*sin(omega*t + phi) * omega^2;    
end
