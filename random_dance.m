R = robot();

per_time = 1;
total_time = 30;
fps = 144;

max_angle = 0.5;

for i = 1: total_time
    per_time = 0.2 / log(i + 1);
    posture = robot();
    num_sections = size(posture.sections, 2);
    for j = 1: num_sections
        angle = rand() * max_angle * 2 - max_angle;
        posture.sections{j}.rotation(angle);
    end
    R.uniform_move(posture, per_time, fps);
end