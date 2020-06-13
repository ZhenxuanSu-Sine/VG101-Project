classdef section
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        connection_points = {}
        position = [0, 0]
        outline = []
    end
    
    methods
        function obj = section(outline,connection_pos)
            %UNTITLED 构造此类的实例
            %   此处显示详细说明
            obj.outline = outline;
            num_connection_points = size(connection_pos, 1);
            for i = 1: num_connection_points
                obj.connection_points{i} = connection_point(connection_pos(i, :), obj);
            end
        end
        
        function [] = section_plot(obj)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            default_color = 'r';
            color = default_color;
            points = obj.position + obj.outline;
            patch(points(:, 1), points(:, 2), color);
        end
    end
end

