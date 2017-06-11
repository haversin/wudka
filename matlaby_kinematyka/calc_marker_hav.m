function [ dis_point, vel_point, acc_point ] = calc_marker_hav( s, dis, vel, acc )

omega = [0 -1; 1 0];
phi = dis(3);
dphi = vel(3);
ddphi = acc(3);

dis_n = [R(phi)*s(1:2); s(3)];
vel_n = [omega*R(phi)*dphi*s(1:2); 0];
acc_n = [omega*omega*R(phi)*dphi*dphi*s(1:2) + omega*R(phi)*ddphi*s(1:2); 0];

dis_point = dis + dis_n;
vel_point = vel + vel_n;
acc_point = acc + acc_n;
end
