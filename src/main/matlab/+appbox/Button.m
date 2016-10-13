classdef Button < matlab.mixin.SetGet %#ok<*MCSUP>
    % Mimics uicontrol 'pushbutton' without a border.
    
    properties
        String
        TooltipString
        Icon
        Enable
        Visible
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
            [obj.JControl, obj.Control] = javacomponent(com.mathworks.mwswing.MJButton(), [], p.Results.Parent);
            obj.JControl.setBorderPainted(false);
            obj.JControl.setDefaultCapable(false);
            obj.JControl.setFocusTraversable(false);
            obj.JControl.setFocusable(false);
            obj.JControl.setRequestFocusEnabled(false);
            obj.JControl.setFlyOverAppearance(true);
            obj.JControl.setOpaque(false);
            set(obj.JControl, 'ActionPerformedCallback', @obj.onActionPerformed);
            obj.set(p.Unmatched);
        end
        
        function s = get.String(obj)
            s = char(obj.JControl.getText());
        end
        
        function set.String(obj, s)
            obj.JControl.setText(s);
            obj.JControl.setFont(javax.swing.UIManager.getDefaults().getFont('Button.font'));
        end
        
        function s = get.TooltipString(obj)
            s = char(obj.JControl.getToolTipText());
        end
        
        function set.TooltipString(obj, s)
            obj.JControl.setToolTipText(s);
        end
        
        function set.Icon(obj, i)
            obj.JControl.setIcon(javax.swing.ImageIcon(i));
        end
        
        function set.Enable(obj, e)
            obj.JControl.setEnabled(appbox.onOff(e));
        end
        
        function e = get.Enable(obj)
            e = appbox.onOff(obj.JControl.isEnabled());
        end
        
        function set.Visible(obj, v)
            obj.JControl.setVisible(appbox.onOff(v));
        end
        
        function v = get.Visible(obj)
            v = appbox.onOff(obj.JControl.isVisible());
        end
        
    end
    
    methods (Access = private)
        
        function onActionPerformed(obj, ~, ~)
            % Remove hover appearance
            e = obj.JControl.Enabled();
            obj.JControl.setEnabled(false);
            obj.JControl.setEnabled(e);
            
            if ~isempty(obj.Callback)                
                event = struct();
                obj.Callback(obj, event);
            end
        end
        
    end
    
end

