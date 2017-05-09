function [ FIq ] = gimme_jacobi( q, rot, tra, drot, dtra )
    % rotational constraints
    n = 1;
    FIq = zeros(length(q), length(q));
    for i=1:size(rot,2)
        b1 = rot(1,i);
        b2 = rot(2,i);
        [~, fi] = getbody(q, b1);
        [~, fj] = getbody(q, b2);
        v1 = [0 -1;1 0]*R(fi)*rot(3:4,i);
        v2 = -[0 -1;1 0]*R(fj)*rot(5:6,i);
        if(b1 ~= 0)
            FIq(n:n+1,3*b1-2:3*b1) = [[1 0;0 1] v1];
        end
        if(b2 ~= 0)
            FIq(n:n+1,3*b2-2:3*b2) = [[-1 0;0 -1] v2];
        end
        n = n+2;
    end
    % translational constraints
    for i=1:size(tra,2)
        b1 = tra(1,i);
        b2 = tra(2,i);
        [ri, fi] = getbody(q, b1);
        [rj, fj] = getbody(q, b2);
        
        vj = tra(7:8,i);
        sai = tra(3:4,i);
        %sbj = tra(5:6,i);
        
        if(b1 ~= 0)
            FIq(n+1,3*b1) = 1;
            FIq(n,3*b1-2:3*b1) = [-(R(fj)*vj)', -(R(fj)*vj)'*[0 -1;1 0]*R(fi)*sai];
        end
        if(b2 ~= 0)
            FIq(n+1,3*b2) = -1;
            FIq(n,3*b2-2:3*b2) = [ (R(fj)*vj)', -(R(fj)*vj)'*[0 -1;1 0]*(rj-ri-R(fi)*sai)];
        end
        n = n+2;
    end
    % rotational drives
    
    for i=1:size(drot,2)
        b1 = rot(1,drot{i}{2});
        b2 = rot(2,drot{i}{2});
        if(b1~= 0)
            FIq(n,3*b1) = 1;
        end
        if(rot(2,drot{i}{2}) ~= 0)
            FIq(n,3*b2) = -1;
        end
    end
    
    % translational drives
    for i=1:size(dtra,2)
        b1 = tra(1,dtra{i}{2});
        b2 = tra(2,dtra{i}{2});
        [ri, fi] = getbody(q, b1);
        [rj, fj] = getbody(q, b2);
        sai = tra(3:4,i);
        sbj = tra(5:6,i);
        u = R(fj)*sbj-R(fi)*sai;
        u = u/norm(u);
        
        if(b1 ~= 0)
            FIq(n,3*b1-2:3*b1) = [-(R(fj)*u)', -(R(fj)*u)'*[0 -1;1 0]*R(fi)*sai];
        end
        if(b2 ~= 0)
            FIq(n,3*b2-2:3*b2) = [ (R(fj)*u)', -(R(fj)*u)'*[0 -1;1 0]*(rj-ri-R(fi)*sai)];
        end
    end 
end