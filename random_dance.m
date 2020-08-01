
function random_dance(current_axes)

    R = robot('R');

    per_time = 1;
    total_time = 10;
    fps = 144;

    max_angle = 0.5;

    for i = 1: total_time
        per_time = 1 / log(i + 1);
        posture = robot('P');
        num_sections = size(posture.sections, 2);
        for j = 1: num_sections
            angle = rand() * max_angle * 2 - max_angle;
            posture.sections{j}.rotation(angle);
        end
%         disp('before uniform move');
%         
%         R
%         
%         disp('end before');
        
        R.uniform_move(posture, per_time, fps, current_axes);
        
%         disp('after uniform move');
%         
%         R
%         
%         disp('end after');
    end

end