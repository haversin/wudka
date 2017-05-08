function [ points ] = read_points( file )
    i = 1;
    while ~feof(file)
        a(i,:) = textscan(file, "%s %f %f\n", 1);
        k(i) = a{i,1};
        v{:,i} = [a{i,2} a{i,3}]';
        i = i+1;
    end

    points = containers.Map(k,v);
end

