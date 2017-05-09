points_in = fopen("dane/punkty.txt","r"); % [name x y]
bodies_in = fopen("dane/ciala.txt","r");  % [x y] TODO names and rotation
const_rot_in = fopen("dane/wiezy_rot.txt","r"); % [body1 body2 point_name]
const_tra_in = fopen("dane/wiezy_tra.txt","r"); % [body1 body2 body1_point_name body2_point_name]
markers_in = fopen("dane/markery.txt","r"); % [marker_name point_name body_id angle_offset]
addpath('dane');
% xdxd
rehash path

points = read_points(points_in); % key-value map
bodies = read_bodies(bodies_in); % column-vectors
markers = read_markers(markers_in, points, bodies); % key-value map

[rot, tra, drot, dtra] = read_constraints(const_rot_in, const_tra_in, points, bodies); % more to do

q0 = [];
for i=1:size(bodies,2)
    q0 = [q0; bodies(:,i); 0]; % [x y 0]
end

% closures
Fi_qt = @(q, t) gimme_fi(q, t, rot, tra, drot, dtra);
Fiq_q = @(q) gimme_jacobi(q, rot, tra, drot, dtra);
Fit_t = @(t) gimme_fit(0, t, rot, tra, drot, dtra);
Ga_qdqt = @(q, dq, t) gimme_gamma(q, dq, t, rot, tra, drot, dtra);

% solve solve
[time, dis, vel, acc] = simulate(Fi_qt, Fiq_q, Fit_t, Ga_qdqt, q0, 1.0, 100);

marker = @(name) get_marker(name, markers, dis, vel, acc);

fclose(points_in);
fclose(bodies_in);
fclose(const_rot_in);
if(const_tra_in > 0)
    fclose(const_tra_in);
end
if(markers_in > 0)
    fclose(markers_in);
end
rmpath('dane');

clear i ans bodies_in const_rot_in const_tra_in points_in markers_in;