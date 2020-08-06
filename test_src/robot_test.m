set(gcf, 'doublebuffer', 'on')
for i=1:length(x)
	plot3(x(1:i),y(1:i),z(1:i),'*');
	axis([-0.5 2.5 -1.0 3.0 2.2 2.5 -1 1]);
	drawnow;
	pause(0.1);
end