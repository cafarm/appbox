classdef BusyPresenter < appbox.Presenter

    properties (Access = private)
        text
        title
    end

    methods

        function obj = BusyPresenter(text, title, view)
            if nargin < 3
                view = appbox.BusyView();
            end
            obj = obj@appbox.Presenter(view);
            obj.view.setWindowStyle('modal');
            
            obj.text = text;
            obj.title = title;
        end

    end

    methods (Access = protected)

        function willGo(obj)
            obj.view.setText(obj.text);
            obj.view.setTitle(obj.title);
        end
        
        function onViewSelectedClose(obj, ~, ~) %#ok<INUSD>
            % Do nothing.
        end

    end

end
