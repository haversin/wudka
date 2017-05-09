points_in = fopen("dane/punkty.txt","r"); % [name x y]
bodies_in = fopen("dane/ciala.txt","r");  % [x y] TODO names and rotation
const_rot_in = fopen("dane/wiezy_rot.txt","r"); % [body1 body2 point_name]
const_tra_in = fopen("dane/wiezy_tra.txt","r"); % [body1 body2 body1_point_name body2_point_name]
addpath('dane');
% xdxd
rehash path

points = read_points(points_in); % key-value map
bodies = read_bodies(bodies_in); % column-vectors

[rot, tra, drot, dtra] = read_constraints(const_rot_in, const_tra_in, points, bodies); % more to do

q0 = [];
for i=1:size(bodies,2)
    q0 = [q0; bodies(:,i); 0]; % [x y 0]
end
q0(1) = q0(1); % shake it

Fi_qt = @(q, t) gimme_fi(q, t, rot, tra, drot, dtra); % closures
Fiq_q = @(q) gimme_jacobi(q, rot, tra, drot, dtra);
Fit_t = @(t) gimme_fit(0, t, rot, tra, drot, dtra);

% solve solve
[time, dis, vel] = simulate(Fi_qt, Fiq_q, Fit_t, q0, 1.0, 100);

fclose(points_in);
fclose(bodies_in);
fclose(const_rot_in);
if(const_tra_in > 0)
    fclose(const_tra_in);
end
rmpath('dane');