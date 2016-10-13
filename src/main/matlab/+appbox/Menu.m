classdef Menu < matlab.mixin.SetGet
    % A uimenu alternative.
    
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
            warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
            jFrame = get(handle(figureHandle), 'JavaFrame');
            warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
            obj.Control = jFrame.fHG2Client.getMenuBar();
        end
        
        function delete(obj)
            obj.close();
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
            set(button, 'ActionPerformedCallback', @(h,d)onActionPerformed(obj, button, p.Results.Callback));
            
            function onActionPerformed(obj, btn, cback)
                % Remove hover appearance
                e = btn.Enabled();
                btn.setEnabled(false);
                btn.setEnabled(e);
                
                if ~isempty(cback)
                    event = struct();
                    cback(obj, event);
                end
            end
            
            t = appbox.ComponentWrapper(button);
            set(t, 'Enable', p.Results.Enable);
        end
        
    end
    
end

