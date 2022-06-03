clear all
close all
clc

hold on
% two plates
fplot(@(x) x, [0,6], 'k')
fplot(0, [0,6], 'k')

% fixme: I do not know how to create sample points only 
% in the space between the plates
[X,Y] = meshgrid(0:0.3:6);

% electric field
U = 15*X^2*Y-5*Y^3;
V = 5*X^3-15*X*Y^2;
quiver(X,Y,U,V, 'Color','#0072BD')

% equipotential
Z = -5*X^3*Y+5*X*Y^3-15;
contour(X,Y,Z)
% A matrix with the same value everywhere (constant ZData) 
% doesn't have any level change, so no contour can be drawn.
hold off
