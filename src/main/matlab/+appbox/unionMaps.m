function c = unionMaps(a, b)
    keys = union(a.keys, b.keys);
    
    values = cell(1, numel(keys));
    for i = 1:numel(keys)
        k = keys{i};
        if a.isKey(k) && b.isKey(k)
            if isequal(a(k), b(k))
                values{i} = a(k);
            else
                values{i} = [{} a(k) b(k)];
            end
        elseif a.isKey(k)
            values{i} = a(k);
        else
            values{i} = b(k);
        end
    end
    
    if isempty(keys)
        c = containers.Map();
    else
        c = containers.Map(keys, values);
    end
end

