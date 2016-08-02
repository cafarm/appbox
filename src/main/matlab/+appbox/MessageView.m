classdef MessageView < appbox.View

    events
        Button1
        Button2
        Button3
    end

    properties (Access = private)
        text
        button1
        button2
        button3
    end

    methods

        function createUi(obj)
            import appbox.*;

            set(obj.figureHandle, ...
                'Position', screenCenter(hpix(300/11), vpix(58/16)));

            mainLayout = uix.VBox( ...
                'Parent', obj.figureHandle, ...
                'Padding', 11, ...
                'Spacing', 11);

            obj.text = TextArea( ...
                'Parent', mainLayout);

            % Controls.
            controlsLayout = uix.HBox( ...
                'Parent', mainLayout, ...
                'Spacing', 7);
            uix.Empty('Parent', controlsLayout');
            obj.button3 = uicontrol( ...
                'Parent', controlsLayout, ...
                'Style', 'pushbutton', ...
                'Interruptible', 'off', ...
                'Callback', @(h,d)notify(obj, 'Button3', appbox.EventData(get(obj.button3, 'String'))));
            obj.button2 = uicontrol( ...
                'Parent', controlsLayout, ...
                'Style', 'pushbutton', ...
                'Interruptible', 'off', ...
                'Callback', @(h,d)notify(obj, 'Button2', appbox.EventData(get(obj.button2, 'String'))));
            obj.button1 = uicontrol( ...
                'Parent', controlsLayout, ...
                'Style', 'pushbutton', ...
                'Interruptible', 'off', ...
                'Callback', @(h,d)notify(obj, 'Button1', appbox.EventData(get(obj.button1, 'String'))));
            set(controlsLayout, 'Widths', [-1 hpix(75/11) hpix(75/11) hpix(75/11)]);

            set(mainLayout, 'Heights', [-1 vpix(23/16)]);
        end

        function setTitle(obj, t)
            set(obj.figureHandle, 'Name', t);
        end

        function setText(obj, t)
            set(obj.text, 'String', t);
        end

        function s = getTextSize(obj)
            s = get(obj.text, 'Size');
        end

        function s = getTextPreferredSize(obj)
            s = get(obj.text, 'PreferredSize');
        end

        function setButton1(obj, s)
            set(obj.button1, 'String', s);
        end

        function setButton1Visible(obj, tf)
            set(obj.button1, 'Visible', appbox.onOff(tf));
        end

        function setButton1Default(obj)
            try %#ok<TRYNC>
                h = handle(obj.figureHandle);
                h.setDefaultButton(obj.button1);
            end
        end

        function setButton2(obj, s)
            set(obj.button2, 'String', s);
        end

        function setButton2Visible(obj, tf)
            set(obj.button2, 'Visible', appbox.onOff(tf));
        end

        function setButton2Default(obj)
            try %#ok<TRYNC>
                h = handle(obj.figureHandle);
                h.setDefaultButton(obj.button2);
            end
        end

        function setButton3(obj, s)
            set(obj.button3, 'String', s);
        end

        function setButton3Visible(obj, tf)
            set(obj.button3, 'Visible', appbox.onOff(tf));
        end

        function setButton3Default(obj)
            try %#ok<TRYNC>
                h = handle(obj.figureHandle);
                h.setDefaultButton(obj.button3);
            end
        end

    end

end
