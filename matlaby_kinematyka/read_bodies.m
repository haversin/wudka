function [ bodies ] = read_bodies( file )
    i = 1;
    while ~feof(file)
        a(i,:) = textscan(file, '%f %f\n', 1);
        v(:,i) = [a{i,1} a{i,2}]';
        i = i+1;
    end
    bodies = v;
end

