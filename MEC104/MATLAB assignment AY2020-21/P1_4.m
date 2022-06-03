clear all
close all
clc

syms A  % wall area

T_i = 20;
T_o = -10;
R_1 = 0.036/A;
R_2 = 4.01/A;
R_3 = 0.408/A;
R_4 = 0.038/A;

A = [
    R_1/R_2+1 -R_1/R_2 0
    -1 R_2/R_3+1 -R_2/R_3
    0 -1 R_3/R_4+1
    ];
b = [
    T_i
    0
    T_o*R_3/R_4
    ];

T = A\b;
q = T_i-T(1)/R_1;

%% Wall area equals 1m^2
A = 1;
eval( subs(T) )
eval( subs(q) )

%% Wall area equals 10m^2
A = 10;
eval( subs(q) )
