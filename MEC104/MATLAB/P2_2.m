clear all
close all
clc

tspan = [0, 20];
y0 = [0, 0];

% a)
omiga = 1;
motion = @(t, y) [
    y(2)
    (( 10*sin(omiga*t) - 75*y(1) )/3)
];
[t,y] = ode45(motion, tspan, y0);
subplot(2,2,1), plot(t, y(:,1))
grid on
xlabel('time (s)')
ylabel('motion')
title('P2-2 a)')

% b)
omiga = 5;
motion = @(t, y) [
    y(2)
    (( 10*sin(omiga*t) - 75*y(1) )/3)
];
[t,y] = ode45(motion, tspan, y0);
subplot(2,2,2), plot(t, y(:,1))
grid on
xlabel('time (s)')
ylabel('motion')
title('P2-2 b)')

% c)
omiga = 10;
motion = @(t, y) [
    y(2)
    (( 10*sin(omiga*t) - 75*y(1) )/3)
];
[t,y] = ode45(motion, tspan, y0);
subplot(2,2,[3,4]), plot(t, y(:,1))
grid on
xlabel('time (s)')
ylabel('motion')
title('P2-2 c)')

suptitle('motion of a certain mass connected to a spring with no friction')
