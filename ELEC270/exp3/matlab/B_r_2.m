%% Part B requirement 2

close all

syms b_n(V, n)
b_n(V, n) = rdivide(2*V,pi*n);

n = [1:1:10];
b_n(V, n)
