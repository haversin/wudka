function [ dis_point, vel_point, acc_point ] = calc_marker( s, dis, vel, acc )

omega = [0 -1; 1 0];
phi = dis(3);
dphi = vel(3);
ddphi = acc(3);


dis_point = dis(1:2) + R(phi)*s(1:2);
vel_point = vel(1:2) + omega*R(phi)*dphi;
acc_point = acc(1:2) + omega*omega*R(phi)*dphi*dphi*s(1:2) + omega*R(phi)*ddphi*s(1:2);

end

