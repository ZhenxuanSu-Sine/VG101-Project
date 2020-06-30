R = robot();

posture1 = robot();
posture1.head.rotation(0.7);
posture1.legs{1}{1}.rotation(-0.3);
posture1.legs{2}{2}.rotation(0.2);
posture1.arms{1}{2}.rotation(1.2);
posture1.arms{2}{1}.rotation(0.9);
posture1.arms{2}{2}.rotation(-0.3);
posture1.update_position();

posture2 = robot();
posture2.head.rotation(-0.7);
posture2.legs{1}{1}.rotation(0.3);
posture2.legs{2}{2}.rotation(-0.2);
posture2.arms{1}{2}.rotation(-1.2);
posture2.arms{2}{1}.rotation(-0.9);
posture2.arms{2}{2}.rotation(0.3);
posture2.update_position();

time = 1;
fps = 144;
R.uniform_move(posture1, time, fps);

time = 0.5;
for i = 1: 100
    R.uniform_move(posture2, time / sqrt(i), fps);
    R.uniform_move(posture1, time / sqrt(i), fps);
end