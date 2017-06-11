function [  ] = try_anim( dis, marker, time )
%TRY_ANIM Summary of this function goes here
%   Detailed explanation goes here

    n = size(dis,2);
    wizuQ = zeros(10,2);
    wizuM = {'mA','mB','mC','mD','mE','mF','mG','mH','mK','mM','mN','mO','mP'};
    wizuV = zeros(size(wizuM,2),2);

    sleep_time = time/n;

    figure
    for j=1:n
        newq = dis(:,j);
    
        for i=1:10
            r = getbody(newq,i)';
            wizuQ(i,1:2) = r;
        end

        for i=1:size(wizuM,2)
            mdisp = marker(wizuM{i});
            v = mdisp(:,j)';
            wizuV(i,1:2) = v(1,1:2);
        end

        wizuV = wizuV';
    
        clf
        wizu_hav(wizuQ, wizuV);
        if(j == 1)
            pause(2.0); % start delay
        else
            pause(0.001);
        end
    end
end

