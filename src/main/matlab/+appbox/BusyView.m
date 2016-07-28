classdef BusyView < appbox.View

    properties (Access = private)
        text
        spinner
    end

    methods

        function createUi(obj)
            import appbox.*;
            
            width = 210;
            if ismac
                width = width + 20;
            end
            set(obj.figureHandle, ...
                'Position', screenCenter(width, 45));

            mainLayout = uix.HBox( ...
                'Parent', obj.figureHandle, ...
                'Padding', 11);
            
            uix.Empty('Parent', mainLayout);
            
            spinnerLayout = uix.VBox('Parent', mainLayout);
            uix.Empty('Parent', spinnerLayout);
            obj.spinner = com.mathworks.widgets.BusyAffordance();
            javacomponent(obj.spinner.getComponent(), [], spinnerLayout);
            obj.spinner.start();
            set(spinnerLayout, 'Heights', [4 -1]);
            
            obj.text = Label( ...
                'Parent', mainLayout, ...
                'String', '', ...
                'HorizontalAlignment', 'left', ...
                'VerticalAlignment', 'center');
            
            uix.Empty('Parent', mainLayout);
            
            set(mainLayout, 'Widths', [-1 32 width-60 -1]);
        end
        
        function setTitle(obj, t)
            set(obj.figureHandle, 'Name', t);
        end

        function setText(obj, t)
            set(obj.text, 'String', t);
        end

    end

end
