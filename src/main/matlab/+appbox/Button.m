% Mimics uicontrol 'pushbutton' without a border.

classdef Button < matlab.mixin.SetGet %#ok<*MCSUP>
    
    properties
        String
        Icon
        Callback
    end
    
    properties (Access = private)
        Control
        JControl
    end
    
    methods
        
        function obj = Button(varargin)
            p = inputParser();
            p.KeepUnmatched = true;
            p.addOptional('Parent', get(groot, 'CurrentFigure'));
            p.parse(varargin{:});
            [obj.JControl, obj.Control] = javacomponent(javax.swing.JButton(), [], p.Results.Parent);
            obj.JControl.setBorder(javax.swing.BorderFactory.createEmptyBorder());
            obj.JControl.setBorderPainted(false);
            obj.JControl.setContentAreaFilled(false);
            obj.JControl.setFocusPainted(false);
            obj.set(p.Unmatched);
        end
        
        function s = get.String(obj)
            s = char(obj.JControl.getText());
        end
        
        function set.String(obj, s)
            obj.JControl.setText(s);
        end
        
        function set.Icon(obj, i)
            obj.JControl.setIcon(javax.swing.ImageIcon(i));
        end
        
        function set.Callback(obj, c)
            set(obj.JControl, 'ActionPerformedCallback', c);
        end
        
    end
    
end

