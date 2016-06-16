% Mimics uicontrol to enable extensibility.

classdef UIControl < matlab.mixin.SetGet %#ok<*MCSUP>
    
    properties
        Parent
        String
        Callback
        Enable
        Value
        ForegroundColor
        BackgroundColor
        UIContextMenu
        GetJControlFcn
    end
    
    properties (Access = protected)
        Control
        JControl
    end
    
    methods
        
        function obj = UIControl(varargin)
            obj.Control = uicontrol(varargin{:});
            obj.GetJControlFcn = @(c)findjobj(c);
        end
        
        function p = get.Parent(obj)
            p = get(obj.Control, 'Parent');
        end
        
        function set.Parent(obj, p)
            set(obj.Control, 'Parent', p);
            obj.JControl = [];
        end
        
        function s = get.String(obj)
            s = obj.getString();
        end
        
        function s = getString(obj)
            s = get(obj.Control, 'String');
        end
        
        function set.String(obj, s)
            obj.setString(s);
        end
        
        function setString(obj, s)
            set(obj.Control, 'String', s);
        end
        
        function c = get.Callback(obj)
            c = get(obj.Control, 'Callback');
        end
        
        function set.Callback(obj, c)
            set(obj.Control, 'Callback', c);
        end
        
        function e = get.Enable(obj)
            e = get(obj.Control, 'Enable');
        end
        
        function set.Enable(obj, e)
            set(obj.Control, 'Enable', e);
        end
        
        function v = get.Value(obj)
            v = obj.getValue();
        end
        
        function v = getValue(obj)
            v = get(obj.Control, 'Value');
        end
        
        function set.Value(obj, v)
            obj.setValue(v);
        end
        
        function setValue(obj, v)
            set(obj.Control, 'Value', v);
        end
        
        function c = get.ForegroundColor(obj)
            c = get(obj.Control, 'ForegroundColor');
        end
        
        function set.ForegroundColor(obj, c)
            set(obj.Control, 'ForegroundColor', c);
        end
        
        function c = get.BackgroundColor(obj)
            c = get(obj.Control, 'BackgroundColor');
        end
        
        function set.BackgroundColor(obj, c)
            set(obj.Control, 'BackgroundColor', c);
        end
        
        function m = get.UIContextMenu(obj)
            m = get(obj.Control, 'UIContextMenu');
        end
        
        function set.UIContextMenu(obj, m)
            set(obj.Control, 'UIContextMenu', m);
        end
        
        function uicontrol(obj)
            uicontrol(obj.Control);
        end
        
        function c = get.JControl(obj)
            if isempty(obj.JControl)
                obj.JControl = obj.GetJControlFcn(obj.Control);
            end
            c = obj.JControl;
        end
        
    end
    
end

