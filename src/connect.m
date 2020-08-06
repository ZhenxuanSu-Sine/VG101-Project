function [] = connect(point1, point2)
%CONNECT 此处显示有关此函数的摘要
%   此处显示详细说明
    point1.connection = point2;
    point2.connection = point1;
    
    section1 = point1.belonging;
    section2 = point2.belonging;
    
    section2.position = section1.position + point1.relative_position - point2.relative_position;
end

