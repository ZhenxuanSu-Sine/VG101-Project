% 准备一张自己的背景图片
img = imread('mypicture.png');
% 设置图片在绘制时的尺寸
min_x = 0;
max_x = 52.5;
min_y = 0;
max_y = 20;
 
%绘制自己的图形的数据
 
alteredX=[38.7 43.6 20.1 7.8 7.9];
alteredY=[5.5 16.8 19.1 7.5 17.6];
 
%插入背景图 
 
imagesc([min_x max_x], [min_y max_y], flipdim(img,1)); 
% NOTE: if your image is RGB, you should use flipdim(img, 1) instead of flipud.
 
hold on;
 
%绘制自己的图形
plot(alteredX,alteredY,'r','MarkerSize',10); 
set(gca,'ydir','normal');