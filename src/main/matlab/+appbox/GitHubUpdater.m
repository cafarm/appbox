classdef GitHubUpdater < handle
    
    properties
        versionCompareFcn % Function that returns negative, zero, or positive number if a is less than, equal to, or greater than b.
    end
    
    properties (SetAccess = private)
        host        % Struct containing name and version of host app
        update      % Struct containing update release data (https://developer.github.com/v3/repos/releases)
        download    % Downloaded update file path
    end
    
    methods
        
        function obj = GitHubUpdater()
            obj.versionCompareFcn = @(a,b)compareVersions(a,b);
        end
        
        % Returns true if an update is available. owner should be the GitHub repo owner. repo should be the GitHub repo 
        % name. host should be a struct with fields 'name' and 'version' containing the name and version of the host app.
        function tf = checkForUpdates(obj, owner, repo, host)
            obj.host = host;
            url = ['https://api.github.com/repos/' owner '/' repo '/releases/latest'];
            
            tf = false;
            try
                data = webread(url, 'ContentType', 'json');
            catch
                return;
            end
            if obj.versionCompareFcn(data.tag_name, host.version) <= 0
                return;
            end
            obj.update = data;
            tf = true;
        end
        
        function downloadUpdate(obj)
            if isempty(obj.update)
                error('No update available');
            end
            
            asset = [];
            for i = 1:numel(obj.update.assets)
                a = obj.update.assets(i);
                [~, ~, ext] = fileparts(a.name);
                if any(strcmpi(ext, {'.mltbx', '.mlappinstall'}))
                    asset = a;
                    break;
                end
            end
            
            if isempty(asset)
                error('Unable to find .mltbx or .mlappinstall in update');
            end
            
            filename = fullfile(tempdir, asset.name);
            if exist(filename, 'file')
                delete(filename);
            end
            
            obj.download = websave(filename, asset.browser_download_url);
        end
        
        function installUpdate(obj)
            if isempty(obj.download)
                error('No download available');
            end
            
            [~, ~, ext] = fileparts(obj.download);
            if strcmpi(ext, '.mltbx')
                matlab.addons.toolbox.installToolbox(obj.download);
            else
                matlab.apputil.install(obj.download);
            end
        end
        
    end
    
end

function c = compareVersions(a, b)
    a = sscanf(a, '%d.%d.%d.%d');
    b = sscanf(b, '%d.%d.%d.%d');
    
    if numel(a) ~= 4 || numel(b) ~= 4
        error('Expected version number to match X.X.X.X format');
    end
    
    if a(1) ~= b(1)
        c = a(1) - b(1);
    elseif a(2) ~= b(2)
        c = a(2) - b(2);
    elseif a(3) ~= b(3)
        c = a(3) - b(3);
    else
        c = a(4) - b(4);
    end
end