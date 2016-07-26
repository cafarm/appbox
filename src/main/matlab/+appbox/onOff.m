function output = onOff(input)
    % Converts logicals to 'on'/'off' and vice versa.
    
    if ischar(input)
        if strcmpi(input, 'on')
            output = true;
        else
            output = false;
        end
    else
        if input
            output = 'on';
        else
            output = 'off';
        end
    end
end