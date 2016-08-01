classdef BusyView < appbox.View

    properties (Access = private)
        text
        spinner
    end

    methods

        function createUi(obj)
            import appbox.*;
            
            set(obj.figureHandle, ...
                'Position', screenCenter(hpix(210/11), vpix(45/16)));

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
            
            set(mainLayout, 'Widths', [-1 32 hpix(150/11) -1]);
        end
        
        function setTitle(obj, t)
            set(obj.figureHandle, 'Name', t);
        end

        function setText(obj, t)
            set(obj.text, 'String', t);
        end

    end

end
