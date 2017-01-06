classdef BusyPresenter < appbox.Presenter

    properties (Access = private)
        title
        text
        width
    end

    methods

        function obj = BusyPresenter(title, text, varargin)
            if nargin < 2
                text = 'This may take a moment.';
            end
            ip = inputParser();
            ip.addParameter('width', appbox.hpix(210/11), @isscalar);
            ip.addParameter('view', appbox.BusyView(), @(x)isa(x, 'appbox.BusyView'));
            ip.parse(varargin{:});
            
            obj = obj@appbox.Presenter(ip.Results.view);
            obj.view.setWindowStyle('modal');
            
            obj.title = title;
            obj.text = text;
            obj.width = ip.Results.width;
        end

    end

    methods (Access = protected)

        function willGo(obj)
            obj.view.setTitle(obj.title);
            obj.view.setText(obj.text);
            if ~isempty(obj.width)
                obj.view.setViewWidth(obj.width);
            end
        end
        
        function onViewSelectedClose(obj, ~, ~) %#ok<INUSD>
            % Do nothing.
        end

    end

end
