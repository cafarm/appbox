function h = layoutHeight(l)
    % Calculates the total height of a layout.
    h = sum(get(l, 'Heights')) + get(l, 'Spacing')*(numel(get(l, 'Heights'))-1);
end

