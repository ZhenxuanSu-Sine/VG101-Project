classdef robot
    %ROBOT 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        sections = {}
        head
        chest
        arms = {{}, {}}
        waist
        legs = {{}, {}}
        position = [0, 0]
    end
    
    methods
        function obj = robot()
            %ROBOT 构造此类的实例
            %   此处显示详细说明
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
        
        function [] = draw(obj)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            num_sections = size(obj.sections, 2);
            figure;
            hold on;
            axis('equal')
            for i = 1: num_sections
                obj.sections{i}.section_plot();
            end
        end
        
    end
end

