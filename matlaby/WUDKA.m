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
q0(1) = q0(1)+0.05; % shake it

%Fit = @(q, t) gimme_fi(q, t, rot, tra, drot, dtra); % closure
Fi = @(q) gimme_fi(q, 0, rot, tra, drot, dtra); % closure
Fiq = @(q) gimme_jacobi(q, rot, tra, drot, dtra);

% solve solve
end_time = 1.0;
n_steps = 100;
step = end_time/n_steps;

time = zeros(1,n_steps);
answer = zeros(9,n_steps);

%dupa = fsolve(Fi,q0)
dupa = ones(length(q0),1);
q = q0;
it = 0;
while norm(dupa) > 1e-8 && it < 50
    dupa = Fi(q);
    jacobi = Fiq(q);
    q = q - jacobi\dupa;
    it = it + 1;
end

Fi(q)

%{
for i=1:(n_steps+1)
    time(i) = (i-1)*step;
    Fi = @(q) Fit(q,time(i));
    answer(:,i) = fsolve(Fi,q0); % do magic
    %check = Fi(answer(:,i));
end
%}

fclose(points_in);
fclose(bodies_in);
fclose(const_rot_in);
if(const_tra_in > 0)
    fclose(const_tra_in);
end
rmpath('dane');