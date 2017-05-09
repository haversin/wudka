function [ Fit ] = gimme_fit( q, t, rot, tra, drot, dtra )
    Fit = zeros(length(q),1);
    n = 1 + 2*size(rot,2) + 2*size(tra,2);
    for i=1:size(drot,2)
        [~,df] = drot{i}{1}(t);
        Fit(n) = -df;
        n = n + 1;
    end
    for i=1:size(dtra,2)
        [~,df] = dtra{i}{1}(t);
        Fit(n) = -df;
        n = n + 1;
    end
end