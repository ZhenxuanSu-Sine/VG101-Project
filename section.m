classdef section < handle
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        connection_points = {}
        position = [0, 0]
        outline = []
        rotation_angle = 0
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
        
        function [] = section_plot(obj, current_axes, robot_position)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            default_color = 'y';
            color = default_color;
            points = obj.position + obj.outline + robot_position;
            patch(current_axes, points(:, 1), points(:, 2), color);
        end
        
        function [] = update_position(obj, last_obj)
            num_connections = size(obj.connection_points, 2);
            for i =1: num_connections
                if obj.connection_points{i}.connection ~= NaN % don't fix this!
                    next_obj = obj.connection_points{i}.connection.belonging;
                    if next_obj == last_obj
                        continue
                    end
                    next_obj.position = obj.position + obj.connection_points{i}.relative_position - obj.connection_points{i}.connection.relative_position;
                    next_obj.update_position(obj);
                end
            end
        end
        
        function [] = rotation(obj, phi)
            obj.rotation_angle = obj.rotation_angle + phi;
            phi = -phi;
            rotation_matrix = [cos(phi), -sin(phi); sin(phi), cos(phi)];
            % obj.position = (obj.position - rotation_point) * rotation_matrix + rotation_point;
            obj.position = obj.position * rotation_matrix;
            % obj.outline = (obj.outline - rotation_point) * rotation_matrix + rotation_point;
            obj.outline = obj.outline * rotation_matrix;
            num_connection_points = size(obj.connection_points, 2);
            for i = 1: num_connection_points
                % obj.connection_points{i}.relative_position = obj.connection_points{i}.relative_position * rotation_matrix;
                obj.connection_points{i}.relative_position = obj.connection_points{i}.relative_position * rotation_matrix;
            end
        end
        
    end
end

