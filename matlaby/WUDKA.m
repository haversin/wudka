data_dir = 'dane';
points_in = fopen(strcat(data_dir,'/punkty.txt'),'r'); % [name x y]
bodies_in = fopen(strcat(data_dir,'/ciala.txt'),'r');  % [x y] TODO names and rotation
const_rot_in = fopen(strcat(data_dir,'/wiezy_rot.txt'),'r'); % [body1 body2 point_name]
const_tra_in = fopen(strcat(data_dir,'/wiezy_tra.txt'),'r'); % [body1 body2 body1_point_name body2_point_name]
markers_in = fopen(strcat(data_dir,'/markery.txt'),'r'); % [marker_name point_name body_id angle_offset]
addpath(data_dir);
% xdxd
rehash path

points = read_points(points_in); % key-value map
bodies = read_bodies(bodies_in); % column-vectors
markers = read_markers(markers_in, points, bodies); % key-value map

[rot, tra, drot, dtra] = read_constraints(const_rot_in, const_tra_in, points, bodies); % more to do

q0 = [];
for i=1:size(bodies,2)
    q0 = [q0; bodies(:,i) + [0;0]; 0]; % [x y 0]
end

% closures
Fi_qt = @(q, t) gimme_fi(q, t, rot, tra, drot, dtra);
Fiq_q = @(q) gimme_jacobi(q, rot, tra, drot, dtra);
Fit_t = @(t) gimme_fit(0, t, rot, tra, drot, dtra);
Ga_qdqt = @(q, dq, t) gimme_gamma(q, dq, t, rot, tra, drot, dtra);

% solve solve

[time, dis, vel, acc] = simulate(Fi_qt, Fiq_q, Fit_t, Ga_qdqt, q0, 1.0, 100);
marker = @(name) get_marker(name, markers, dis, vel, acc);

%{
ntime = linspace(0,20);
yy1 = dtra{1}{1}(ntime')';
yy2 = dtra{2}{1}(ntime')';
yy = [yy1;yy2]
plot(ntime,yy);
grid on
%}

% cleanup
fclose(points_in);
fclose(bodies_in);
fclose(const_rot_in);
if(const_tra_in > 0)
    fclose(const_tra_in);
end
if(markers_in > 0)
    fclose(markers_in);
end
rmpath(data_dir);
clear i ans bodies_in const_rot_in const_tra_in points_in markers_in data_dir;

% DONE
% now do sth ...

%{
%check jacobi 
jakk = Fiq_q(q0*1.02);
normw = zeros(size(jakk,1),1);
normk = zeros(size(jakk,2),1);
for i=1:size(jakk,1)
    normw(i) = norm(jakk(i,:));
    normk(i) = norm(jakk(:,i));
end
%}

%{
m1 = marker('mP');
m2 = marker('mF');
m3 = marker('mG');
m4 = marker('c2');

plot(m1(1,:),m1(2,:), m2(1,:),m2(2,:), m3(1,:), m3(2,:), m4(1,:), m4(2,:));
axis equal
grid on
%}

%disc6 = marker('c6');

%plot(time, disc6(1,:))