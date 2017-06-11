function [ mdis, mvel, macc ] = get_marker( marker_name, markers, dis, vel, acc )
    marker = markers(marker_name);
    body = marker(1);
    s = marker(2:4);
    n = size(dis,2);
    mdis = zeros(3,n);
    mvel = zeros(3,n);
    macc = zeros(3,n);
    if(body == 0)
        for i=1:n
            [mdis(:,i), mvel(:,i), macc(:,i)] = calc_marker_hav(s, [0;0;0], [0;0;0], [0;0;0]);
        end
    else
        for i=1:n
            [mdis(:,i), mvel(:,i), macc(:,i)] = calc_marker_hav(s, dis(3*body-2:3*body,i), vel(3*body-2:3*body,i), acc(3*body-2:3*body,i));
        end
    end
end