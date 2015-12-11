% Gets the package name given a path.
% \doc\+appbox\+test\Wow.m => appbox.test

function [name, className, parentPath] = packageName(path)
    if isempty(path)
        name = [];
        className = [];
        parentPath = [];
        return;
    end
    [parentPath, name] = strtok(path, '+');
    [~, className] = fileparts(name);
    name = regexp(name, '\+(\w)+', 'tokens');
    name = strcat([name{:}], [repmat({'.'},1,numel(name)-1) {''}]);
    name = [name{:}];
end