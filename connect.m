function [section1, section2] = connect(section1, section2, connect1_idx, connect2_idx)
%CONNECT 此处显示有关此函数的摘要
%   此处显示详细说明
    point1 = section1.connection_points{connect1_idx};
    point2 = section2.connection_points{connect2_idx};
    
    point1.connection = point2;
    point2.connection = point1;
    
    section1.connection_points{connect1_idx} = point1;
    section2.connection_points{connect2_idx} = point2;
    section2.position = section1.position + point1.relative_position - point2.relative_position;
end

