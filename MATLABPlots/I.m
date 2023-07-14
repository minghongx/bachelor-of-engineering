clear all
close all
clc

x = linspace(0,2*pi);
sin_wave = sin(x);
cos_wave = cos(x);

% 这种写法的 hold 更灵活
tiledlayout(1,1)
axis = nexttile;

handle_sin = plot(axis, x, sin_wave, '-r');
hold(axis, "on")
handle_cos = plot(axis, x, cos_wave, '--og');
hold(axis, "off")
grid on

legend([handle_sin, handle_cos], 'y1 = sin(x)', "y2 = cos(x)", 'Location','EastOutside')
title("Experimental Task I")
