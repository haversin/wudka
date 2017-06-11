function [f df ddf] = ser2(t)
    l = sqrt(17)/5 - 0.04;
    a = 0.04;
    omega = 5.4;
    phi = 1.0;

    f = l + a*sin(omega*t + phi);
    df = a*cos(omega*t + phi) * omega;
    ddf = -a*sin(omega*t + phi) * omega^2;    
end
