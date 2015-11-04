classdef EventData < event.EventData

    properties
        data
    end

    methods

        function obj = EventData(data)
            obj.data = data;
        end

    end

end
