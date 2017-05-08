function out = run_array(F, q )
    for i = 1:length(F)
        test(i) = F(i).f1(q);
    out = test';
end

