clear all
close all
clc

% fixme: 不知道怎么在极坐标下画隐函数
%subplot(2,1,1), ezpolar('r^2=cos(2*theta)')
subplot(2,1,1), fimplicit(@(r,theta) cos(2*theta)-r^2)
title('r^2=cos(2*theta)')

subplot(2,1,2), ezpolar('2*(1+cos(theta))')
title('r=2*(1+cos(theta))')
