% A uimenu alternative.

classdef Menu < matlab.mixin.SetGet
    
    properties
    end
    
    properties (Access = private)
        FigureHandle
        Control
    end
    
    methods
        
        function obj = Menu(figureHandle)
            drawnow;
            obj.FigureHandle = figureHandle;
            jFrame = get(handle(figureHandle), 'JavaFrame');
            obj.Control = jFrame.fHG2Client.getMenuBar();
        end
        
        function delete(obj)
            obj.Close();
        end
        
        function close(obj)
            count = obj.Control.getComponentCount();
            for i = 1:count
                component = obj.Control.getComponent(i-1);
                h = handle(component, 'CallbackProperties');
                set(h, 'ActionPerformedCallback', []);
            end
        end
        
        function t = addPushTool(obj, varargin)
            p = inputParser();
            p.addParameter('Label', '');
            p.addParameter('Callback', @(h,d)[]);
            p.addParameter('Enable', 'on');
            p.parse(varargin{:});
            
            button = javaObjectEDT('com.mathworks.mwswing.MJButton', p.Results.Label);
            button.setBorderPainted(false);
            button.setDefaultCapable(false);
            button.setFocusTraversable(false);
            button.setFocusable(false);
            button.setRequestFocusEnabled(false);
            button.setFlyOverAppearance(true);
            button.setOpaque(false);
            javaMethodEDT('add', obj.Control, button);
            button = handle(button, 'CallbackProperties');
            set(button, 'ActionPerformedCallback', p.Results.Callback);
            
            t = appbox.ComponentWrapper(button);
            set(t, 'Enable', p.Results.Enable);
        end
        
    end
    
end

