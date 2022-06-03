clear all
close all
clc

subplot(2,1,1), ezplot('exp(2*x)+sin(3*x^2)', [-1,2])

subplot(2,1,2), fplot(@(x) exp(2*x)+sin(3*x^2), [-1,2])
title('exp(2*x)+sin(3*x^2) using fplot')
xlabel('x')
