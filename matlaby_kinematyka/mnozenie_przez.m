function mnoznik = mnozenie_przez( co )
    mnoznik = @(x) arrayfun(@(y) y*x, co);
end