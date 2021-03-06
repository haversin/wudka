data_dir = 'dane_xdxdyn';
points_in = fopen(strcat(data_dir,'/punkty.txt'),'r'); % [name x y]
bodies_in = fopen(strcat(data_dir,'/ciala.txt'),'r');  % [x y] TODO names and rotation
const_rot_in = fopen(strcat(data_dir,'/wiezy_rot.txt'),'r'); % [body1 body2 point_name]
const_tra_in = fopen(strcat(data_dir,'/wiezy_tra.txt'),'r'); % [body1 body2 body1_point_name body2_point_name]
markers_in = fopen(strcat(data_dir,'/markery.txt'),'r'); % [marker_name point_name body_id angle_offset]
forces_in = fopen(strcat(data_dir,'/sily.txt'),'r'); % [point_name body_id function_file]
addpath(data_dir);
% xdxd
rehash path

points = read_points(points_in); % key-value map
[bodies, bodies_mass] = read_bodies(bodies_in); % column-vectors
markers = read_markers(markers_in, points, bodies); % key-value map

[rot, tra, sdtra] = read_constraints(const_rot_in, const_tra_in, points, bodies); % more to do
forces = read_forces(forces_in, points, bodies);

q0 = [];
for i=1:size(bodies,2)
    q0 = [q0; bodies(:,i) + [0;0]; 0]; % [x y 0]
end
dq0 = zeros(size(q0,1),1);

Mass = mass_matrix(bodies_mass);
grav = [0; -9.80665];
%grav = [10; -10]/sqrt(2);
%grav = [0;0];
Q_qdq = @(q, dq) gimme_qiu(q, dq, Mass, grav, forces, tra, sdtra);
Fi_q = @(q) gimme_fi(q, rot, tra);
Fiq_q = @(q) gimme_jacobi(q, rot, tra);
Ga_qdq = @(q, dq) gimme_gamma(q, dq, rot, tra);

integrateme = @(t, y) gimme_integralee(y, Mass, Fi_q, Fiq_q, Q_qdq, Ga_qdq);
[time, dis, vel, acc] = odesim(integrateme, q0, dq0, 5.0);
%[time, dis, vel, acc] = simulate(Mass, Q_qdq, Fiq_q, Ga_qdq, q0, 10.0, 1000);
marker = @(name) get_marker(name, markers, dis, vel, acc);

% from kinematics
%{

% closures
Fi_qt = @(q, t) gimme_fi(q, t, rot, tra, drot, dtra);
Fiq_q = @(q) gimme_jacobi(q, rot, tra, drot, dtra);
Fit_t = @(t) gimme_fit(0, t, rot, tra, drot, dtra);
Ga_qdqt = @(q, dq, t) gimme_gamma(q, dq, t, rot, tra, drot, dtra);

% solve solve

[time, dis, vel, acc] = simulate(Fi_qt, Fiq_q, Fit_t, Ga_qdqt, q0, 4.0, 400);
marker = @(name) get_marker(name, markers, dis, vel, acc);
%}

% cleanup
fclose(points_in);
fclose(bodies_in);
if(const_rot_in > 0)
    fclose(const_rot_in);
end
if(const_tra_in > 0)
    fclose(const_tra_in);
end
if(markers_in > 0)
    fclose(markers_in);
end
if(forces_in > 0)
    fclose(forces_in);
end
rmpath(data_dir);
clear i ans bodies_in const_rot_in const_tra_in points_in markers_in forces_in data_dir;

% DONE
% now do sth ...

% get info about K
% [first last]
% [x;y; dx;dy; ddx;ddy]
%[mdis, mvel, macc] = marker('mK'); infoB = [mdis(1:2,1) mdis(1:2,end); mvel(1:2,1) mvel(1:2,end); macc(1:2,1) macc(1:2,end)]

%try_anim(dis, marker, 2.0);

