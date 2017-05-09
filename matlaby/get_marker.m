function [ mdis, mvel, macc ] = get_marker( marker_name, markers, dis, vel, acc )
    marker = markers(marker_name);
    body = marker(1);
    s = marker(2:4);
    [mdis, mvel, macc] = calc_marker_hav(s, dis(3*body-2:3*body,:), vel(3*body-2:3*body,:), acc(3*body-2:3*body,:));
end