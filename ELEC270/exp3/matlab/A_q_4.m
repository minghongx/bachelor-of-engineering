%% Part A question 4

%%
close all;

a_n = [0 0 0 0 0];
b_n = [1 1/3 1/5 1/7 1/9];

%% Plot the spectrum of $f(t)$ using $c_n = \sqrt{a_n^2 + b_n^2}$
c_n = sqrt(a_n.^2 + b_n.^2);

stem(c_n);
ax = gca;
ax.XTick = 1:1:5;
ax.XTickLabel = {'\omega','2\omega','3\omega','4\omega','5\omega'};
ax.XLim = [0 6]; ax.YLim = [0 1.1];
