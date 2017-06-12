function [ FI ] = gimme_fi( q, rot, tra)
    % rotational constraints
    n = 1;
    %FI = zeros(length(q),1);
    for i=1:size(rot,2)
        [ri, fi] = getbody(q, rot(1,i));
        [rj, fj] = getbody(q, rot(2,i));
        sa = ri + R(fi)*rot(3:4,i);
        sb = rj + R(fj)*rot(5:6,i);
        FI(n:n+1,1) = sa - sb;
        n = n+2;
    end
    % translational constraints
    for i=1:size(tra,2)
        [ri, fi] = getbody(q, tra(1,i));
        [rj, fj] = getbody(q, tra(2,i));
        vj = tra(7:8,i);
        sai = tra(3:4,i);
        sbj = tra(5:6,i);
        FI(n,1) = (R(fj)*vj)'*(rj-ri-R(fi)*sai) + vj'*sbj;
        FI(n+1,1) = fi - fj;
        n = n+2;
    end
end