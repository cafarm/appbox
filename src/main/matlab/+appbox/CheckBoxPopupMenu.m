classdef CheckBoxPopupMenu < matlab.mixin.SetGet %#ok<*MCSUP>
    
    properties
        String
        Value
        Callback
    end
    
    properties (Access = private)
        Control
        JControl
    end
    
    methods
        
        function obj = CheckBoxPopupMenu(varargin)
            p = inputParser();
            p.KeepUnmatched = true;
            p.addOptional('Parent', get(groot, 'CurrentFigure'));
            p.parse(varargin{:});
            [obj.JControl, obj.Control] = javacomponent(com.jidesoft.combobox.CheckBoxListExComboBox(), [], p.Results.Parent);
            obj.JControl = handle(obj.JControl, 'CallbackProperties');
            set(obj.JControl, 'ActionPerformedCallback', @obj.onActionPerformed);
            obj.set(p.Unmatched);
        end
        
        function s = get.String(obj)
            m = obj.JControl.getModel();
            s = {};
            for i = 1:m.getSize()
                s{end + 1} = char(m.getElementAt(i - 1)); %#ok<AGROW>
            end
        end
        
        function set.String(obj, string)
            obj.JControl.setModel(javax.swing.DefaultComboBoxModel(string));
        end
        
        function v = get.Value(obj)
            v = obj.JControl.getSelectedIndices() + 1;
        end
        
        function set.Value(obj, v)
            if isempty(v)
                obj.JControl.setSelectedIndex(-1);
                return;
            end
            obj.JControl.setSelectedIndices(v - 1);
        end
        
    end
    
    methods (Access = private)
        
        function onActionPerformed(obj, ~, ~)
            if ~isempty(obj.Callback)
                event = struct();
                obj.Callback(obj, event);
            end
        end
        
    end
    
end

