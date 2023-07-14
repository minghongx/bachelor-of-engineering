clear all
close all
clc

syms x

y = piecewise( ...
    (0<=x)&(x<4), sqrt(x), ...
    (4<=x)&(x<6), 2, ...
    (6<=x)&(x<8), 5-x/2, ...
    x>=8, 1);

fplot(y, [0,10])
title('a piecewise function')
