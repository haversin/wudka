function [ r, fi ] = getbody( q, i )
    if( i == 0) % zero if ground
        r = [0;0];
        fi = 0;
    else
        r = [q(3*i-2);q(3*i-1)];
        fi = q(3*i);
    end
end