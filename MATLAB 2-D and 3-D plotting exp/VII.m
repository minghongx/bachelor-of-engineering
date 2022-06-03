clear all
close all
clc

[X,Y] = meshgrid(-8:.5:8);
R = sqrt(X.^2 + Y.^2) + eps;  % MATLAB docs 中的写法. 不清楚写 +eps 的用意
Z = sin(R)./R;

tiledlayout(2,2)

nexttile
mesh(X,Y,Z)
title('sinc plotted by mesh')

nexttile
meshc(X,Y,Z)
title('sinc plotted by meshc')

nexttile
meshz(X,Y,Z)
title('sinc plotted by meshz')

nexttile
surf(X,Y,Z)
title('sinc plotted by surf')
