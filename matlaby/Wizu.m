% DO RYSOWANIA ROBOTA Z ZADANIA - Z KOLORAMI
% v(i,j) - współrzędne punktów
%	i - współrzędna (1=x, 2=y)
%	j - numer punktu (kolejno jak sczytujemy z pliku: A, B, C,...)
% q(i,j) - współrzędne środków mas
%	i - numer ciała
%	j - współrzędna (1=x, 2=y)
% Sorry, że nie są jednolicie zdefiniowane, ale wydawało mi się,
% że w takiej formie je przechowywałeś w kodzie po odczytaniu plików

% DEFINICJA KOLORKÓW
C(:,:,1) = [204;255;77;61;0;255;0;255;0;255;0]/255; %R
C(:,:,2) = [102;177;0;139;0;255;255;128;255;255;204]/255; %G
C(:,:,3) = [204;61;255;255;0;0;0;0;255;153;102]/255; %B

% ZASTĄPIĆ DANYMI OBLICZONYMI W PROGRAMIE
q = [0.7 -0.2 ; 0.0 0.2 ; 0.2 0.3 ; 1.55 -0.35 ; 0.9 0.2 ; 0.2 -0.35 ; 0.6 -0.25 ; 0.15 -0.45 ; 0.25 0.05 ; 0.7 0.0];
v = [1.5 1.3 0.5 0.8 0.5 -0.3 0.3 0.1 1.9 0.8 0.0 0.0 -0.2 ; -0.6 0.0 0.4 0.0 0.2 0.3 0.3 -0.7 -0.5 -0.2 -0.4 0.0 0.1];

% comment out if no preproc
q = wizuQ;
v = wizuV';
%

% RYSOWANIE TRÓJKĄTÓW
x3 = [v(1, 1) v(1, 3) v(1, 1) v(1, 5); v(1, 4) v(1, 5) v(1, 2) v(1, 4); v(1, 13) v(1, 6) v(1, 9) v(1, 10)];
y3 = [v(2, 1) v(2, 3) v(2, 1) v(2, 5); v(2, 4) v(2, 5) v(2, 2) v(2, 4); v(2, 13) v(2, 6) v(2, 9) v(2, 10)];
figure
patch(x3,y3,C([1 3 4 10],:,:), 'FaceAlpha',.4)
axis equal

% RYSOWANIE CZWOROKĄTA C2
x4 = [v(1, 7); v(1, 6); v(1, 13); v(1, 12)];
y4 = [v(2, 7); v(2, 6); v(2, 13); v(2, 12)];
patch(x4,y4,C(2,:,:), 'FaceAlpha',.4)

% RYSOWANIE PIĘCIOKĄTA C0 
% (Nie zmieniać tych liczb wpisanych ręcznie, to i tak jest ground)
x5 = [v(1, 12); v(1, 11); v(1, 8); -0.5; -0.5];
y5 = [v(2, 12); v(2, 11); v(2, 8); -0.7; 0.0];
patch(x5,y5,C(11,:,:), 'FaceAlpha',.4)

% RYSOWANIE PATYKÓW
%	Patyk czarny
x21 = [v(1, 2) v(1, 3)];
y21 = [v(2, 2) v(2, 3)];
line(x21,y21,'Color',C(5,:,:))
%	Siłownik 1.1
x22 = [v(1, 11) 2*q(6, 1)-v(1, 11)];
y22 = [v(2, 11) 2*q(6, 2)-v(2, 11)];
line(x22,y22,'Color',C(6,:,:))
%	Siłownik 1.2
x23 = [2*q(7, 1)-v(1, 10) v(1, 10)];
y23 = [2*q(7, 2)-v(2, 10) v(2, 10)];
line(x23,y23,'Color',C(7,:,:))
%	Siłownik 2.1
x24 = [v(1, 8) 2*q(8, 1)-v(1, 8)];
y24 = [v(2, 8) 2*q(8, 2)-v(2, 8)];
line(x24,y24,'Color',C(8,:,:))
%	Siłownik 2.2
x25 = [2*q(9, 1)-v(1, 7) v(1, 7)];
y25 = [2*q(9, 2)-v(2, 7) v(2, 7)];
line(x25,y25,'Color',C(9,:,:))