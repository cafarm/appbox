classdef MessagePresenter < appbox.Presenter

    properties (Access = private)
        text
        title
        button1
        button2
        button3
        default
        width
        checkbox
    end

    methods
        
        function obj = MessagePresenter(text, title, varargin)
            ip = inputParser();
            ip.addParameter('button1', 'OK', @ischar);
            ip.addParameter('button2', '', @ischar);
            ip.addParameter('button3', '', @ischar);
            ip.addParameter('default', 1, @isscalar);
            ip.addParameter('width', appbox.hpix(400/11), @isscalar);
            ip.addParameter('checkbox', '', @ischar);
            ip.addParameter('view', appbox.MessageView(), @(x)isa(x, 'appbox.MessageView'));
            ip.parse(varargin{:});
            
            obj = obj@appbox.Presenter(ip.Results.view);
            obj.view.setWindowStyle('modal');

            obj.text = text;
            obj.title = title;
            obj.button1 = ip.Results.button1;
            obj.button2 = ip.Results.button2;
            obj.button3 = ip.Results.button3;
            obj.default = ip.Results.default;
            obj.width = ip.Results.width;
            obj.checkbox = ip.Results.checkbox;
        end

    end

    methods (Access = protected)

        function willGo(obj)
            obj.view.setText(obj.text);
            obj.view.setTitle(obj.title);
            obj.view.setButton1(obj.button1);
            obj.view.setButton2(obj.button2);
            obj.view.setButton3(obj.button3);
            obj.view.setButton1Visible(~isempty(obj.button1));
            obj.view.setButton2Visible(~isempty(obj.button2));
            obj.view.setButton3Visible(~isempty(obj.button3));
            if obj.default == 1
                obj.view.setButton1Default();
            elseif obj.default == 2
                obj.view.setButton2Default();
            elseif obj.default == 3
                obj.view.setButton3Default();
            end
            if ~isempty(obj.width)
                obj.view.setViewWidth(obj.width);
            end
            obj.view.setCheckbox(obj.checkbox);
            obj.view.setCheckboxVisible(~isempty(obj.checkbox));
        end

        function didGo(obj)
            obj.view.update();
            size = obj.view.getTextSize();
            preferred = obj.view.getTextPreferredSize();
            p = obj.view.position;
            d = preferred - size;
            obj.view.position = p + [-d(1)/2 -d(2)/2 d(1) d(2)];
        end

        function bind(obj)
            bind@appbox.Presenter(obj);

            v = obj.view;
            obj.addListener(v, 'KeyPress', @obj.onViewKeyPress);
            obj.addListener(v, 'Button1', @obj.onViewSelectedButton1);
            obj.addListener(v, 'Button2', @obj.onViewSelectedButton2);
            obj.addListener(v, 'Button3', @obj.onViewSelectedButton3);
        end

    end

    methods (Access = private)

        function onViewKeyPress(obj, ~, event)
            switch event.data.Key
                case 'return'
                    if obj.default == 1
                        obj.onViewSelectedButton1();
                    elseif obj.default == 2
                        obj.onViewSelectedButton2();
                    elseif obj.default == 3
                        obj.onViewSelectedButton3();
                    end
                case 'escape'
                    obj.stop();
            end
        end

        function onViewSelectedButton1(obj, ~, ~)
            obj.result = {obj.button1, obj.view.getCheckboxValue()};
            obj.stop();
        end

        function onViewSelectedButton2(obj, ~, ~)
            obj.result = {obj.button2, obj.view.getCheckboxValue()};
            obj.stop();
        end

        function onViewSelectedButton3(obj, ~, ~)
            obj.result = {obj.button3, obj.view.getCheckboxValue()};
            obj.stop();
        end

    end

end
