function [ Ga ] = gimme_gamma( q, dq, rot, tra)
    % rotational constraints
    n = 1;
    %Ga = zeros(length(q),1);
    for i=1:size(rot,2)
        [~, fi] = getbody(q, rot(1,i));
        [~, fj] = getbody(q, rot(2,i));
        [~, dfi] = getbody(dq, rot(1,i));
        [~, dfj] = getbody(dq, rot(2,i));
        sai = rot(3:4,i);
        sbj = rot(5:6,i);
        Ga(n:n+1,1) = R(fi)*sai*dfi*dfi - R(fj)*sbj*dfj*dfj;
        n = n+2;
    end
    % translational constraints
    for i=1:size(tra,2)
        [ri, fi] = getbody(q, tra(1,i));
        [rj, fj] = getbody(q, tra(2,i));
        [dri, dfi] = getbody(dq, tra(1,i));
        [drj, dfj] = getbody(dq, tra(2,i));
        vj = tra(7:8,i);
        sai = tra(3:4,i);
        Ga(n,1) = (R(fj)*vj)' * (2*[0 -1; 1 0]*(drj-dri)*dfj + (rj-ri)*dfj*dfj - R(fi)*sai*(dfj-dfi).^2 );
        Ga(n+1,1) = 0;
        n = n+2;
    end
end