function c = intersect(a, b)
    keep = false(1, numel(a));
    for i = 1:numel(a)
        for k = numel(b):-1:1
            if isequal(a(i), b(k))
                keep(i) = true;
                b(k) = [];
                break;
            end
        end
    end
    c = a(keep);
end

