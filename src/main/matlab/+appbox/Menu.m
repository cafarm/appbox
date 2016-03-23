% A uimenu alternative.

classdef Menu < matlab.mixin.SetGet
    
    properties
    end
    
    properties (Access = private)
        Control
    end
    
    methods
        
        function obj = Menu(figureHandle)
            drawnow;
            jFrame = get(handle(figureHandle), 'JavaFrame');
            obj.Control = jFrame.fHG2Client.getMenuBar();
        end
        
        function t = addPushTool(obj, varargin)
            p = inputParser();
            p.addParameter('Label', '');
            p.addParameter('Callback', @(h,d)[]);
            p.addParameter('Enable', 'on');
            p.parse(varargin{:});
            
            button = com.mathworks.mwswing.MJButton(p.Results.Label);
            button.setBorderPainted(false);
            button.setDefaultCapable(false);
            button.setFocusTraversable(false);
            button.setFocusable(false);
            button.setRequestFocusEnabled(false);
            button.setFlyOverAppearance(true);
            button.setOpaque(false);
            javaMethodEDT('add', obj.Control, button);
            buttonHandle = handle(button, 'CallbackProperties');
            set(buttonHandle, 'ActionPerformedCallback', p.Results.Callback);
            
            t = appbox.ComponentWrapper(button);
            set(t, 'Enable', p.Results.Enable);
        end
        
    end
    
end

