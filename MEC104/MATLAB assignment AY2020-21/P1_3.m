clear all
close all
clc

syms mg

A = [
    1/sqrt(35) -3/sqrt(34) 1/sqrt(42)
    3/sqrt(35) 0 -4/sqrt(42)
    5/sqrt(35) 5/sqrt(34) 5/sqrt(42)
    ];
b = [
    0
    0
    mg
    ];

T = A\b;

% eval(subs(T))
