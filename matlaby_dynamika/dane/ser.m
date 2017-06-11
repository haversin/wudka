function [f df ddf] = ser(t)
    f = 2.0 - 0.8*sin(8*t + 0.2);
    df = -8*cos(8*t +  0.2);
    ddf = 64*sin(8*t + 0.2);
end
