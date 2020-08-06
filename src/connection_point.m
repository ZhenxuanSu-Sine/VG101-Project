classdef connection_point < handle
    %CONNECTION_SITE 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        relative_position = [0, 0]
        connection
        belonging
    end
    
    methods
        function obj = connection_point(relative_position, belonging)
            %CONNECTION_SITE 构造此类的实例
            %   create a connection point
            obj.relative_position = relative_position;
            obj.belonging = belonging;
        end
        
    end
end

