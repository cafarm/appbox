classdef PasswordField < matlab.mixin.SetGet %#ok<*MCSUP>
    
    properties
        Enable
        String
    end
    
    properties (Access = private)
        Control
        JControl
    end
    
    methods
        
        function obj = PasswordField(varargin)
            p = inputParser();
            p.KeepUnmatched = true;
            p.addOptional('Parent', get(groot, 'CurrentFigure'));
            p.parse(varargin{:});
            [obj.JControl, obj.Control] = javacomponent(javax.swing.JPasswordField(), [], p.Results.Parent);
            obj.JControl.setFocusable(true);
            obj.JControl.putClientProperty('TabCycleParticipant', true);
            obj.set(p.Unmatched);
        end
        
        function set.Enable(obj, e)
            obj.JControl.setEnabled(appbox.onOff(e));
        end
        
        function e = get.Enable(obj)
            e = appbox.onOff(obj.JControl.isEnabled());
        end
        
        function s = get.String(obj)
            s = char(obj.JControl.getText());
        end
        
        function set.String(obj, s)
            obj.JControl.setText(s);
        end
        
    end
    
end

