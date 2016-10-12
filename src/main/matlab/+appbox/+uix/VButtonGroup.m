classdef VButtonGroup < uix.VButtonBox & appbox.uix.AButtonGroup
    %VRadioButtonGroup - Extends uix.VButtonBox to create exclusive radio
    %   button groups.
    
    properties
        
    end
    
    methods
        function obj = VButtonGroup(varargin)
            %% Constructor
            %Superclass constructor 1
            obj = obj@uix.VButtonBox(varargin{:});
            %Superclass constructor 2
            obj = obj@appbox.uix.AButtonGroup(varargin{:});
            
            obj.redraw();
            
        end
        
    end
    
    methods(Access = protected, Hidden = true)
        function onButtonStyleChanged(obj,src,evt) %#ok<INUSD>
            obj.redraw();
        end
                
    end
    
end

