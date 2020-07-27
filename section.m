classdef section < handle
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        connection_points = {}
        position = [0, 0]
        outline = []
        rotation_angle = 0
        
        link_flag = false;
        link_slider
        link_edit_field
    end
    
    methods
        function obj = section(outline,connection_pos)
            %UNTITLED ��������ʵ��
            %   �˴���ʾ��ϸ˵��
            obj.outline = outline;
            num_connection_points = size(connection_pos, 1);
            for i = 1: num_connection_points
                obj.connection_points{i} = connection_point(connection_pos(i, :), obj);
            end
        end
        
        function section_plot(obj, current_axes, robot_position)
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            %   �˴���ʾ��ϸ˵��
            default_color = 'y';
            color = default_color;
            points = obj.position + obj.outline + robot_position;
            patch(current_axes, points(:, 1), points(:, 2), color);
        end
         
        function update_position(obj, last_obj)
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
        
        function rotation(obj, phi)
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
        
        function update_link(obj)
            if ~obj.link_flag
                return;
            else
                angle = obj.rotation_angle;
                obj.link_edit_field.Value = angle;
                if angle < obj.link_slider.Limits(1)
                    obj.link_slider.Value = obj.link_slider.Limits(1);
                elseif angle > obj.link_slider.Limits(2)
                    obj.link_slider.Value = obj.link_slider.Limits(2);
                else
                    obj.link_slider.Value = angle;
                end
            end
        end
    end
end

