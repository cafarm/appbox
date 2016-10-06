function s = mapstr(m)
    % containers.Map({'key1', 'key2'}, {'value1', 'value2'}) => key1: value1, key2: value2
    
    s = '';
    keys = m.keys;
    for i = 1:numel(keys)
        k = keys{i};
        s = [s sprintf('%s: %s', k, tostr(m(k)))]; %#ok<AGROW>
        if i ~= numel(keys)
            s = [s ', ']; %#ok<AGROW>
        end
    end
end

function s = tostr(v)
    if isempty(v)
        if iscell(v)
            s = '{}';
        elseif isstruct(v)
            s = '[1x1 struct]';
        else
            s = '[]';
        end
    elseif ischar(v)
        s = v;
    elseif isnumeric(v)
        s = num2str(v);
    else
        s = class(v);
    end
end
