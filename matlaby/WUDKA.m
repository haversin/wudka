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
q0(1) = q0(1) + 0.05; % shake it

Fit = @(q, t) gimme_fi(q, t, rot, tra, drot, dtra); % closure

% solve solve
end_time = 1.0;
n_steps = 100;
step = end_time/(n_steps);

for i=1:(n_steps+1)
    time(i) = (i-1)*step;
    Fi = @(q) Fit(q,time(i));
    answer(:,i) = fsolve(Fi,q0); % do magic
    %check = Fi(answer(:,i));
end

q8_by_q7 = answer(8)/answer(7); % example

fclose(points_in);
fclose(bodies_in);
fclose(const_rot_in);
if(const_tra_in > 0)
    fclose(const_tra_in);
end

rmpath('dane');