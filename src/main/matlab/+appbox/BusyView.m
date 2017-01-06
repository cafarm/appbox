classdef BusyView < appbox.View

    properties (Access = private)
        text
        spinner
    end

    methods

        function createUi(obj)
            import appbox.*;
            
            set(obj.figureHandle, ...
                'Position', screenCenter(hpix(210/11), vpix(45/16)), ...
                'Resize', 'off');

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
            
            set(mainLayout, 'Widths', [3 32 -1 3]);
        end
        
        function setViewWidth(obj, w)
            p = get(obj.figureHandle, 'Position');
            delta = p(3) - w;
            set(obj.figureHandle, 'Position', p + [delta/2 0 -delta 0]);
        end
        
        function setTitle(obj, t)
            set(obj.figureHandle, 'Name', t);
        end

        function setText(obj, t)
            set(obj.text, 'String', t);
        end

    end

end
