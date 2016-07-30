classdef BusyPresenter < appbox.Presenter

    properties (Access = private)
        title
        text
    end

    methods

        function obj = BusyPresenter(title, text, view)
            if nargin < 2
                text = 'This may take a moment.';
            end
            if nargin < 3
                view = appbox.BusyView();
            end
            obj = obj@appbox.Presenter(view);
            obj.view.setWindowStyle('modal');
            
            obj.title = title;
            obj.text = text;
        end

    end

    methods (Access = protected)

        function willGo(obj)
            obj.view.setTitle(obj.title);
            obj.view.setText(obj.text);
        end
        
        function onViewSelectedClose(obj, ~, ~) %#ok<INUSD>
            % Do nothing.
        end

    end

end
