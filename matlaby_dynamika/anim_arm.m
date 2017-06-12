function [] = anim_arm( marker1, marker2 )
    figure
    n = size(marker1, 2);
    for i=1:n
        x1 = marker1(1,i);
        y1 = marker1(2,i);
        x2 = marker2(1,i);
        y2 = marker2(2,i);   
        clf
        plot(marker2(1,1:i),marker2(2,1:i),'r-o');
        axis([-2.0 2.0 -2.0 1.0]);
        pbaspect([1 0.75 1]);
        grid on
        line([0.0 x1], [0.0 y1]);
        line([x1 x2], [y1 y2]);
        if(i == 1)
            pause(5.0); % start delay
        else
            pause(0.01);
        end
    end

end

