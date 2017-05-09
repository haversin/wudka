function [ q ] = newtonify( Fi, Fiq, q0)
    %dupa = fsolve(Fi,q0)
    dupa = ones(length(q0),1);
    q = q0;
    it = 0;
    % TODO singularity
    while norm(dupa) > 1e-16 && it < 100
        dupa = Fi(q);
        jacobi = Fiq(q);
        q = q - jacobi\dupa;
        it = it + 1;
    end
end