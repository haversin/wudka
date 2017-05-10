function [ q ] = newtonify( Fi, Fiq, q0)
    %q = fsolve(Fi,q0)
    
    dupa = ones(length(q0),1);
    q = q0;
    it = 0;
    % TODO singularity
    while it < 100 && norm(dupa) > 10e-12
        dupa = Fi(q);
        jacobi = Fiq(q);
        if rcond(jacobi) < 10e-10
            error('rcond dupa');
        end
        q = q - jacobi\dupa;
        it = it + 1;
    end
    if(it >= 100)
        error('ZBIEŻNOŚĆ CHUJ');
    end
end