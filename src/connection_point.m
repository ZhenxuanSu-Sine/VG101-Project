classdef connection_point < handle
    %CONNECTION_SITE �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        relative_position = [0, 0]
        connection
        belonging
    end
    
    methods
        function obj = connection_point(relative_position, belonging)
            %CONNECTION_SITE ��������ʵ��
            %   create a connection point
            obj.relative_position = relative_position;
            obj.belonging = belonging;
        end
        
    end
end

