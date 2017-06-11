file = fopen("dane/wiezy_tra.txt", "r");

i = 1;
   
while ~feof(file)
    a(i,:) = textscan(file, "%f %f %s %s\n", 1);
    k(i) = a{i,1};
    v{:,i} = [a{i,2} a{i,3}]';
    i = i+1;
end
    
fclose(file);