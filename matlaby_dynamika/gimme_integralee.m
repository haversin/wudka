function [ dy ] = gimme_integralee(y, Mass, Fi, Jacobi, Qiu, Gamma)
    
    %baumgart
    alpha = 5.0; beta = 5.0;

    n = size(Mass,1);
    
    q = y(1:n,1);
    dq = y((n+1):2*n,1);
    
    m = size(Jacobi(q),1);
    
    Jac = Jacobi(q);
	L = [Mass Jac'; Jac zeros(m,m)];
    baum = -2*alpha*Jac*dq -beta*beta*Fi(q);
    R = [Qiu(q,dq); (Gamma(q,dq) + baum)];
    
    x = L\R;
    dy(1:n,1) = dq;
    dy((n+1):2*n,1) = x(1:n,1);
end

