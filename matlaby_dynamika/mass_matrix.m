function [ Mass ] = mass_matrix( bodies_mass )
    n = size(bodies_mass,2);
    Mass = zeros(3*n,3*n);
    for i=1:n
        Mi = diag([bodies_mass(1,i), bodies_mass(1,i), bodies_mass(2,i)]); % diag([m, m, J])
        Mass(3*i-2:3*i,3*i-2:3*i) = Mi; % diag([M1 M2 M3 ...])
    end
end