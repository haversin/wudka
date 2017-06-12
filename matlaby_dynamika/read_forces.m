function [ forces ] = read_forces( file_forces, points, bodies )
    i=1;
    forces = {};
    if(file_forces > 0)
        while ~feof(file_forces)
            a(:) = textscan(file_forces, '%f %s %s\n', 1);
            
            if(regexp(a{3}{1},'^[a-z].*.m$') == 1)
                p = a{2};
                b = a{1};
                s = points(p{1}) - bodies(:,b);
                forces{i} = {b, s, str2func(a{3}{1}(1:end-2))};
                i = i+1;
            else
                error("forces error");
            end
        end
    end
end