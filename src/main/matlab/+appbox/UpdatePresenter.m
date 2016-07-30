classdef UpdatePresenter < appbox.Presenter

    properties (Access = private)
        updater
    end

    methods

        function obj = UpdatePresenter(updater, view)
            if nargin < 2
                view = appbox.UpdateView();
            end
            obj = obj@appbox.Presenter(view);
            obj.view.setWindowStyle('modal');

            obj.updater = updater;
        end

    end

    methods (Access = protected)

        function willGo(obj)
            host = obj.updater.host;
            update = obj.updater.update;
            obj.view.setTitle(['A new version of ' host.name ' is available!']);
            obj.view.setBody([host.name ' ' update.tag_name ' is now available. You have ' host.version '. ', ...
                'Would you like to download and install it now?']);
            obj.view.setReleaseNotes(update.body);
        end

        function bind(obj)
            bind@appbox.Presenter(obj);

            v = obj.view;
            obj.addListener(v, 'KeyPress', @obj.onViewKeyPress);
            obj.addListener(v, 'Install', @obj.onViewSelectedInstall);
            obj.addListener(v, 'Later', @obj.onViewSelectedLater);
        end

    end

    methods (Access = private)

        function onViewKeyPress(obj, ~, event)
            switch event.data.Key
                case 'return'
                    obj.onViewSelectedInstall();
                case 'escape'
                    obj.onViewSelectedLater();
            end
        end

        function onViewSelectedInstall(obj, ~, ~)
            try
                p = obj.view.showBusy('Downloading...');
                obj.updater.downloadUpdate();
                delete(p);

                p = obj.view.showBusy('Installing...');
                info = obj.updater.installUpdate();
                delete(p);
            catch x
                delete(p);
                obj.view.showError(x.message);
                return;
            end

            obj.result = info;
            obj.stop();
        end

        function onViewSelectedLater(obj, ~, ~)
            obj.stop();
        end

    end

end
