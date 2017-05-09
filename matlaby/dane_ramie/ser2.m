function [f df ddf] = ser2(t)

    l = sqrt(26)/5 - 0.02; 
    a = -0.5;
    omega = 0.4;
    phi = 0.1;

    f = l + a*sin(omega*t + phi);
    df = a*cos(omega*t + phi) * omega;
    ddf = -a*sin(omega*t + phi) * omega^2;    
end
