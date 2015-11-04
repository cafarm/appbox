% Mimics uicontrol 'listbox'.

classdef ListBox < appbox.UIControl %#ok<*MCSUP>

    methods
        
        function obj = ListBox(varargin)
            obj@appbox.UIControl( ...
                varargin{:}, ...
                'Style', 'listbox');
        end

        function setString(obj, string)
            set(obj.Control, 'String', string);
            if get(obj.Control, 'Value') > numel(string)
                set(obj.Control, 'Value', max(numel(string), 1));
            end
        end

        function v = getValue(obj)
            if isempty(get(obj.Control, 'String'))
                v = [];
                return;
            end
            v = get(obj.Control, 'Value');
        end

    end

end
