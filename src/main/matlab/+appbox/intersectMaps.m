function c = intersectMaps(a, b, unionValues)
    if nargin < 3
        unionValues = false;
    end

    keys = intersect(a.keys, b.keys);

    keep = true(1, numel(keys));
    values = cell(1, numel(keys));
    for i = 1:numel(keys)
        k = keys{i};
        if isequal(a(k), b(k))
            values{i} = a(k);
        elseif unionValues
            values{i} = [{} a(k) b(k)];
        else
            keep(i) = false;
            values{i} = [];
        end
    end

    if isempty(keys(keep))
        c = containers.Map();
    else
        c = containers.Map(keys(keep), values(keep));
    end
end
