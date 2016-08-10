classdef Separator < matlab.mixin.SetGet %#ok<*MCSUP>
    
    properties
        Color
    end
    
    properties
        Control
    end
    
    methods
        
        function obj = Separator(varargin)
            p = inputParser();
            p.KeepUnmatched = true;
            p.addOptional('Parent', get(groot, 'CurrentFigure'));
            p.parse(varargin{:});
            obj.Control = uix.HBox( ...
                'Parent', p.Results.Parent, ...
                'BackgroundColor', [160/255 160/255 160/255]);
            obj.set(p.Unmatched);
        end
        
        function c = get.Color(obj)
            c = get(obj.Control, 'BackgroundColor');
        end
        
        function set.Color(obj, c)
            set(obj.Control, 'BackgroundColor', c)
        end
        
    end
    
end

