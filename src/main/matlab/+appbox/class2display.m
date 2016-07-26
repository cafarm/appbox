% edu.washington.riekelab.protocols.LedPulseFamily => Led pulse family
% 'pack1.Wow', 'pack1.Hello', 'pack2.Hello' => Wow, Hello (pack1.Hello), Hello (pack2.Hello)

function displayNames = class2display(classNames, capitalize)
    if nargin < 2
        capitalize = false;
    end
    
    if ~iscell(classNames)
        classNames = {classNames};
    end

    displayNames = cell(1, numel(classNames));
    for i = 1:numel(classNames)
        split = strsplit(classNames{i}, '.');
        displayNames{i} = appbox.humanize(split{end});
        if capitalize
            displayNames{i} = appbox.capitalize(displayNames{i});
        end
    end

    for i = 1:numel(displayNames)
        name = displayNames{i};
        repeats = find(strcmp(name, displayNames));
        if numel(repeats) > 1
            for j = 1:numel(repeats)
                displayNames{repeats(j)} = [name ' (' classNames{repeats(j)} ')'];
            end
        end
    end
end

