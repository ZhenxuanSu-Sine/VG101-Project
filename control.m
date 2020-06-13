my_robot = robot();

left_leg = my_robot.legs{1}{1};
left_leg.outline + left_leg.position;

left_leg.rotation(pi / 4);
left_leg.outline + left_leg.position;

my_robot.head.update_position([]);

my_robot.draw();