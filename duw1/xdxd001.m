function out = xdxd001( n )
    for i = 1:n
        funkcje(i).f1 = @(x) x(i)*x(1+n-i);
    out = funkcje;
end