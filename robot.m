classdef robot
    %ROBOT 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        sections = {}
        rotation_angle = [];
        head
        chest
        arms = {{}, {}}
        left_arm
        left_forearm
        right_arm
        right_forearm
        waist
        legs = {{}, {}}
        left_thigh
        left_calf
        right_thigh
        right_calf
        position = [0, 0]
        name = 'unnamed'
        
        on_ground_foot = 1
        on_ground_foot_x = 0
    end
    
    methods
        function obj = robot(name)
            %ROBOT 构造此类的实例
            %   此处显示详细说明
            obj.name = name;
            
            head_outline = [0, 0; 0, 2; 2, 2; 2, 0];
            head_connection_points = [1, 0];
            obj.head = section(head_outline, head_connection_points);
            
            chest_outline = [0, 0; 0, 3; 3, 3; 3, 0];
            chest_connection_points = [1.5, 0; 1.5, 3; 0, 2; 3, 2];
            obj.chest = section(chest_outline, chest_connection_points);
            
            waist_outline = [0, 0; 4, 0; 4, 2; 0, 2];
            waist_connection_points = [2, 2; 1, 0; 3, 0];
            obj.waist = section(waist_outline, waist_connection_points);
            
            leg_length = 3.5;
            leg_outline = [0, 0; 0.5, 0; 0.5, leg_length; 0, leg_length];
            leg_connection_points = [0.25, 0; 0.25, leg_length];
            obj.legs = {{section(leg_outline, leg_connection_points), 
                section(leg_outline, leg_connection_points)}, 
                {section(leg_outline, leg_connection_points), 
                section(leg_outline, leg_connection_points)}};
            
            obj.left_thigh = obj.legs{1}{1};
            obj.left_calf = obj.legs{1}{2};
            obj.right_thigh = obj.legs{2}{1};
            obj.right_calf = obj.legs{2}{2};
            
            arm_length = 2.5;
            arm_outline = [0, 0; arm_length, 0; arm_length, 0.5; 0, 0.5];
            arm_connection_points = [0, 0.25; arm_length, 0.25];
            obj.arms = {{section(arm_outline, arm_connection_points), 
                section(arm_outline, arm_connection_points)}, 
                {section(arm_outline, flip(arm_connection_points, 1)), 
                section(arm_outline, flip(arm_connection_points, 1))}};
            
            connect(obj.head.connection_points{1}, obj.chest.connection_points{2});
            
            connect(obj.chest.connection_points{1}, obj.waist.connection_points{1});
            
            for i = 1: 2
                connect(obj.waist.connection_points{i + 1}, obj.legs{i}{1}.connection_points{2});
                connect(obj.legs{i}{1}.connection_points{1}, obj.legs{i}{2}.connection_points{2});
            end
            
            for i = 1: 2
                connect(obj.chest.connection_points{2 + i}, obj.arms{i}{1}.connection_points{2});
                connect(obj.arms{i}{1}.connection_points{1}, obj.arms{i}{2}.connection_points{2});
            end
            
            obj.sections = {obj.head, obj.chest, obj.waist, obj.legs{1}{1}, obj.legs{1}{2}, obj.legs{2}{1}, obj.legs{2}{2}, obj.arms{1}{1}, obj.arms{1}{2}, obj.arms{2}{1}, obj.arms{2}{2}};
            
        end
        
        function [] = draw(obj, current_axes)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            num_sections = size(obj.sections, 2);
            % clf;
            cla(current_axes);
            % hold on;
            
            for i = 1: num_sections
                obj.sections{i}.section_plot(current_axes, obj.position);
            end
            % hold off;
        end
        
        function new_robot = copy(obj)
            % get a copy of the robot obj
            % cannot use "=" because sections of robot are handle
            new_robot = robot();
            num_sections = size(new_robot.sections, 2);
            for i = 1: num_sections
                new_robot.sections{i}.rotation(obj.sections{i}.rotation_angle);
            end
        end
        
        function obj = update_position(obj)
            % get all sections connected
            obj.head.update_position(NaN);
            
            calf_points = [obj.left_calf.outline + obj.left_calf.position; obj.right_calf.outline + obj.right_calf.position];
            [min_y, idx] = min(calf_points(:, 2));
            % obj.on_ground_foot
            if idx ~= obj.on_ground_foot
                obj.on_ground_foot_x = calf_points(idx, 1) + obj.position(1);
%                 obj.name
%                 calf_points(:, 2)
%                 origin = obj.on_ground_foot
%                 new = idx
                obj.on_ground_foot = idx;
%                 system('pause');
            end
            obj.position = [obj.on_ground_foot_x - calf_points(idx, 1), -min_y];
            % obj
        end
        
        function obj = uniform_move(obj, target_posture, time, fps, current_axes) 
            % unit of time is second
%             disp('start uniform move');
%             obj
            
            section_number = size(obj.sections, 2);
            assert(section_number == size(target_posture.sections, 2));
            delta_angle = zeros(1, section_number);
            for i = 1: section_number
                delta_angle(i) = target_posture.sections{i}.rotation_angle - obj.sections{i}.rotation_angle;
            end
            total_step = floor(time * fps);
            for step = 1: total_step
                
                for i = 1: section_number 
%                     obj
                    obj.sections{i}.rotation(delta_angle(i) / total_step);
                end
                obj = obj.update_position();
                obj.draw(current_axes);
                pause(1 / fps);
            end
            pause(time - total_step / fps);
            
%             disp('end uniform move')
        end
        
    end
end

