function [ bodies, body_mass ] = read_bodies( file )
    i = 1;
    while ~feof(file)
        a(i,:) = textscan(file, '%f %f %f %f\n', 1); % [x y m J]
        v(:,i) = [a{i,1} a{i,2}]';
        m(:,i) = [a{i,3} a{i,4}]';
        i = i+1;
    end
    bodies = v;
    body_mass = m;
end