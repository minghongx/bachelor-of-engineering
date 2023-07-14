clear all
close all
clc

% Area
a = input('a equals ');
b = input('b equals ');

%FIXME: Using this logic, m1 and m2, also node num, will not be integers
% Finite Difference
h = input('h equals ');  % mesh size
m1 = a/h;                % division num
m2 = b/h;
nodeNum_x = m1 + 1;      % node num
nodeNum_y = m2 + 1;

% Boundary conditions
phi_where_x_equals_0 = input('Boundary condition for x = 0: ');
phi_where_x_equals_a = input('Boundary condition for x = a: ');
phi_where_y_equals_0 = input('Boundary condition for y = 0: ');
phi_where_y_equals_b = input('Boundary condition for y = b: ');

% Already known the matrix size, so pre-allocate memory to improve program performance.
phi_ini = ones(nodeNum_x, nodeNum_y);

% Assgin boundary conditions
phi_ini(:, 1) = phi_where_y_equals_0;
phi_ini(:, nodeNum_y) = phi_where_y_equals_b;
phi_ini(1, :) = phi_where_x_equals_0;
phi_ini(nodeNum_x, :) = phi_where_x_equals_a;

% Solve the Lapalce equation using a relaxation method
relaxation_factor = 2/(1+sqrt(1-power((cos(pi/m1)+cos(pi/m2))/2,2)));
tolerance = 1e-5;
[phi,n,error] = Laplace_equation_using_an_iterative_method(phi_ini, relaxation_factor, tolerance);

% Plot
phi = phi';  % for ease of plotting
[X,Y] = meshgrid(0:h:a, 0:h:b);
figure('Name','Laplace Equation | mesh()','NumberTitle','off');
mesh(X,Y,phi)
figure('Name','Laplace Equaton | contour()','NumberTitle','off');
contour(X,Y,phi)
xlabel('Dimension x')
ylabel('Dimension y')
zlabel('Dimension \phi')
title('Laplace Equation')