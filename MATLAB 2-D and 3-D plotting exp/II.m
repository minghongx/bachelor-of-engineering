clear all
close all
clc

syms t
tiledlayout(2,2)

% a. 笛
nexttile
x = 3*t/(1+t^3);
y = 3*t^2/(1+t^3);
ezplot(x,y)

% b. 摆
nexttile
x = 2*(t-sin(t));
y = 2*(1-cos(t));
ezplot(x,y)

% c. 隐
nexttile
ezplot('exp(x)+sin(xy)')  % fixme: 纵坐标有问题

% d. 星
nexttile
x = cos(t)^3;
y = sin(t)^3;
ezplot(x,y)
