classdef ComponentWrapper < matlab.mixin.SetGet %#ok<*MCSUP>
    
    properties
        Enable
        Visible
    end
    
    properties (Access = private)
        JComponent
    end
    
    methods
        
        function obj = ComponentWrapper(component)
            obj.JComponent = component;
        end
        
        function set.Enable(obj, e)
            obj.JComponent.setEnabled(appbox.onOff(e));
        end
        
        function e = get.Enable(obj)
            e = appbox.onOff(obj.JComponent.isEnabled());
        end
        
        function set.Visible(obj, v)
            obj.JComponent.setVisible(appbox.onOff(v));
        end
        
        function v = get.Visible(obj)
            v = appbox.onOff(obj.JComponent.isVisible());
        end
        
    end
    
end

