my_robot = robot();

left_leg1 = my_robot.legs{1}{1};

left_leg2 = my_robot.legs{1}{2};

my_robot.head.update_position(NaN);

clf;

for i = 1: 30
    left_leg1.rotation(pi / 15);
    my_robot.head.update_position(NaN);
    my_robot.draw();
    pause(0.05);
    if mod(i, 5) == 0
        pause(0.45);
    end
end

pause(2);

for i = 1: 30
    left_leg2.rotation(pi / 150);
    my_robot.head.update_position(0);
    my_robot.draw();
    pause(0.1);
end
