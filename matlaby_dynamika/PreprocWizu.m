newq = dis(:,1);
wizuQ = zeros(10,2);

for i=1:10
    r = getbody(newq,i)';
    wizuQ(i,1:2) = r;
end

wizuM = {'mA','mB','mC','mD','mE','mF','mG','mH','mK','mM','mN','mO','mP'};
wizuV = zeros(size(wizuM,2),2);

for i=1:size(wizuM,2)
    mdisp = marker(wizuM{i});
    v = mdisp(:,1)';
    wizuV(i,1:2) = v(1,1:2);
end

wizuV = wizuV';