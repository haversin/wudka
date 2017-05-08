function [ FI ] = gimme_fi( q, t, rot, tra, drot, dtra )
    % rotational constraints
    n = 1;
    for i=1:size(rot,2)
        [ri, fi] = getbody(q, rot(1,i));
        [rj, fj] = getbody(q, rot(2,i));
        v1 = ri + R(fi)*rot(3:4,i);
        v2 = rj + R(fj)*rot(5:6,i);
        FI(n:n+1,1) = v1 - v2;
        n = n+2;
    end
    % translational constraints
    for i=1:size(tra,2)
        [ri, fi] = getbody(q, tra(1,i));
        [rj, fj] = getbody(q, tra(2,i));
        vj = tra(7:8,i);
        sai = tra(3:4,i);
        sbj = tra(5:6,i);
        FI(n) = (R(fj)*vj)'*(rj-ri-R(fi)*sai) + vj'*sbj;
        FI(n+1) = fi - fj;
        n = n+2;
    end
    % rotational drives
    for i=1:size(drot,2)
        [ri, fi] = getbody(q, rot(1,drot{i}{2}));
        [rj, fj] = getbody(q, rot(2,drot{i}{2}));
        FI(n) = fi-fj + drot{i}{1}(t);
    end
    % translational drives
    for i=1:size(dtra,2)
        [ri, fi] = getbody(q, rot(1,dtra{i}{2}));
        [rj, fj] = getbody(q, rot(2,dtra{i}{2}));
        FI(n) = fi-fj + drot{i}{1}(t);
    end 
    %FI(9) = q(3)- (deg2rad(50))+(pi/4);  example 60deg -> q(8)/q(7) = tan(60) = sqrt(3)
end