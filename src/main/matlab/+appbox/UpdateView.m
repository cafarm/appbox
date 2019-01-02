classdef UpdateView < appbox.View
    
    events
        Show
        Later
    end
    
    properties (Access = private)
        titleLabel
        bodyText
        releaseNotesText
        showButton
        laterButton
    end
    
    methods
        
        function createUi(obj)
            import appbox.*;
            
            set(obj.figureHandle, ...
                'Name', 'Software Update', ...
                'Position', screenCenter(hpix(450/11), vpix(250/16)));
            
            mainLayout = uix.VBox( ...
                'Parent', obj.figureHandle, ...
                'Padding', 11, ...
                'Spacing', 11);
            
            updateLayout = uix.VBox( ...
                'Parent', mainLayout, ...
                'Spacing', 7);
            obj.titleLabel = Label( ...
                'Parent', updateLayout, ...
                'String', '');
            obj.bodyText = TextArea( ...
                'Parent', updateLayout, ...
                'String', '');
            Label( ...
                'Parent', updateLayout, ...
                'String', '<html><b>Release Notes:</b></html>');
            obj.releaseNotesText = TextArea( ...
                'Parent', updateLayout, ...
                'Scrollable', true);
            set(updateLayout, 'Heights', [vpix(16/11) vpix(32/11) vpix(16/11) -1]);
            
            % Show/Later controls.
            controlsLayout = uix.HBox( ...
                'Parent', mainLayout, ...
                'Spacing', 7);
            uix.Empty('Parent', controlsLayout);
            obj.showButton = uicontrol( ...
                'Parent', controlsLayout, ...
                'Style', 'pushbutton', ...
                'String', 'Show', ...
                'Interruptible', 'off', ...
                'Callback', @(h,d)notify(obj, 'Show'));
            obj.laterButton = uicontrol( ...
                'Parent', controlsLayout, ...
                'Style', 'pushbutton', ...
                'String', 'Later', ...
                'Interruptible', 'off', ...
                'Callback', @(h,d)notify(obj, 'Later'));
            set(controlsLayout, 'Widths', [-1 hpix(75/11) hpix(75/11)]);

            set(mainLayout, 'Heights', [-1 vpix(23/16)]);
            
            % Set add button to appear as the default button.
            try %#ok<TRYNC>
                h = handle(obj.figureHandle);
                h.setDefaultButton(obj.showButton);
            end
        end
        
        function setTitle(obj, t)
            set(obj.titleLabel, 'String', ['<html><b>' t '</b></html>']);
        end
        
        function setBody(obj, t)
            set(obj.bodyText, 'String', t);
        end
        
        function setReleaseNotes(obj, n)
            set(obj.releaseNotesText, 'String', n);
        end
        
    end
    
end

