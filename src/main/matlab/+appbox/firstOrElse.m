function out = firstOrElse(l, e)
    % firstOrElse([1 2 3], 9) => 1
    % firstOrElse([], 9) => 9
    
    out = e;
    if ~isempty(l)
        out = l(1);
    end
end

