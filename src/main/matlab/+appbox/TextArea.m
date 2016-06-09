classdef TextArea < matlab.mixin.SetGet %#ok<*MCSUP>
    
    properties
        String
        WrapStyleWord
        Editable
        Opaque
        Size
        PreferredSize
    end
    
    properties (Access = private)
        Control
        JControl
    end
    
    methods
        
        function obj = TextArea(varargin)
            p = inputParser();
            p.KeepUnmatched = true;
            p.addOptional('Parent', get(groot, 'CurrentFigure'));
            p.addOptional('Scrollable', false);
            p.parse(varargin{:});
            if p.Results.Scrollable
                [obj.JControl, obj.Control] = javacomponent(javax.swing.JScrollPane(javax.swing.JTextArea()), [], p.Results.Parent);
                obj.JControl = obj.JControl.getComponent(0).getComponent(0);
                obj.Opaque = true;
            else
                [obj.JControl, obj.Control] = javacomponent(javax.swing.JTextArea(), [], p.Results.Parent);
                obj.JControl.setBorder([]);
                obj.Opaque = false;
            end
            obj.WrapStyleWord = true;
            obj.Editable = false;
            obj.set(p.Unmatched);
        end
        
        function s = get.String(obj)
            s = char(obj.JControl.getText());
        end
        
        function set.String(obj, s)
            obj.JControl.setText(s);
        end
        
        function tf = get.WrapStyleWord(obj)
            tf = obj.JControl.getWrapStyleWord();
        end
        
        function set.WrapStyleWord(obj, tf)
            obj.JControl.setLineWrap(tf);
            obj.JControl.setWrapStyleWord(tf);
        end
        
        function tf = get.Editable(obj)
            tf = obj.JControl.isEditable();
        end
        
        function set.Editable(obj, tf)
            obj.JControl.setEditable(tf);
        end
        
        function tf = get.Opaque(obj)
            tf = obj.JControl.getOpaque();
        end
        
        function set.Opaque(obj, tf)
            obj.JControl.setOpaque(tf);
        end
        
        function s = get.Size(obj)
            dim = obj.JControl.getSize();
            s = [dim.width, dim.height];
        end
        
        function s = get.PreferredSize(obj)
            dim = obj.JControl.getPreferredSize();
            s = [dim.width, dim.height];
        end
        
    end
    
end

