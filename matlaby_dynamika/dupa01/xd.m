file = fopen("test.txt","r");

i=1;
while ~feof(file)
    a(:) = textscan(file, '%f %f %s %s\n', 1)
    v1 = [a{1} a{2}]';
    aaa = regexp(a{4}{1},"^[a-z].*.m$");
    
    %{
    if(v1(1) == 0)
        v2 = points(a{3}{1});
    else
        v2 = points(a{3}{1}) - bodies(:,v1(1));
    end
    if(v1(2) == 0)
        v3 = points(a{3}{1});
    else
        v3 = points(a{3}{1}) - bodies(:,v1(2));
    end
	rot(:,i) = [v1; v2; v3];
    %}
    
	i = i+1;
end

fclose(file);