function [ Qiu ] = gimme_qiu( q, dq, Mass, grav, forces, tra, sdtra )
    n = size(q,1)/3;
    Qiu_G = zeros(n*3, 1);
    Qiu_F = zeros(n*3, 1);
    Qiu_C = zeros(n*3, 1);
    %grav
    for i=1:n
        Qiu_G(3*i-2:3*i,1) = [Mass(3*i-2, 3*i-2)*grav;0];
    end
    
    %forces
    nforces = size(forces,2);
    for i=1:nforces
        ibody = forces{i}{1};
        s = forces{i}{2};
        %F = [1;0]; % TODO !!!!!!!!!! forces{i}{3}
        F = forces{i}{3}()
        [~, fi] = getbody(q, ibody);
        Qiu_F(3*ibody-2:3*ibody,1) = [eye(2); ([0 -1;1 0]*R(fi)*s)']*F;
    end
    
    %dampers and springs
    nsdtra = size(sdtra,2);
    for i=1:nsdtra
        b1 = tra(1,sdtra{i}{1});
        b2 = tra(2,sdtra{i}{1});
        [ri, fi] = getbody(q, b1);
        [rj, fj] = getbody(q, b2);
        sai = tra(3:4,i);
        sbj = tra(5:6,i);
        u = R(fj)*sbj-R(fi)*sai;
        u = u/norm(u);
        d0 = sdtra{i}{4};
        k = sdtra{i}{2}; % check
        c = sdtra{i}{3};
        d = norm(rj + R(fj)*sbj - ri - R(fi)*sai);
        [vi, wi] = getbody(dq, b1);
        [vj, wj] = getbody(dq, b2);
        va = vi + [0 -1;1 0]*R(fi)*sai*wi;
        vb = vj + [0 -1;1 0]*R(fj)*sbj*wj;
        dd = u'*(vb - va);
        F = k*(d-d0) + c*dd;
        
        Qiu_F(3*b1-2:3*b1,1) = [eye(2); ([0 -1;1 0]*R(fi)*sai)']*(u*F);
        Qiu_F(3*b2-2:3*b2,1) = [eye(2); ([0 -1;1 0]*R(fj)*sbj)']*(-u*F);
    end
    
    Qiu = Qiu_G + Qiu_F + Qiu_C;
end