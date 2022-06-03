clear all
close all
clc

A = [
    1 4 2
    2 4 100
    7 9 7
    3 pi 42
    ];

B = log(A);

%% a)
secondRow = B(2, :);

%% b)
sumOfSecondRow = sum( B(2, :) );

%% c)
mul = B(2, :) .* A(1, :);

%%  d)
[m, index] = max(mul);

%% e)
div = A(1, :) ./ B(1:3, 3)';  % Inverse B(1:3, 3) form col vector to row vector
sumOfDivision = sum(div);