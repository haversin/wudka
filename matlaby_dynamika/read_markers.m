function [ markers ] = read_markers( file, points, bodies )
    n = 1;
    if(file > 0)
        while ~feof(file)
            a(:) = textscan(file, '%s %s %f %f\n', 1);
            k(n) = a{1};
            if(a{3} == 0)
                u = [0;0];
            else
                u = bodies(:,a{3});
            end
            dupa = [a{3}; points(a{2}{1}) - u; a{4}]; % [body_id; s]
            v{:,n} = dupa;
            n = n + 1;
        end
    end
    for i=1:size(bodies,2)
        k(n) = {strcat('c',int2str(i))};
        v{:,n} = [i;0;0;0];
        n = n+1;
    end
    markers = containers.Map(k,v);
end

