clear all
close all
clc

fsurf(@(t) cos(t), @(t) 2*sin(t), @(t) 3*t, [0,10*pi])
