function [ dis_point, vel_point, acc_point ] = calc_marker( s, dis, vel, acc )

omega = [0 -1; 1 0];
phi = dis(3);
dphi = vel(3);
ddphi = acc(3);
R = rotz(phi);

dis_point = dis(1:2) + R*s(1:2);
vel_point = vel(1:2) + omega*R*dphi;
acc_point = acc(1:2) + omega*omega*R*dphi*dphi*s(1:2) + omega*R*ddphi*s(1:2);

end

