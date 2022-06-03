clear all
close all
clc

g = 9.81;
L = 1;
tspan = [0, 10];

motion4pendulum_a_equals_5 = @(t, theta) [
    theta(2)
    (( 5*cos(theta(1)) - g*sin(theta(1)) )/L)
];

% a)
[t,theta] = ode45(motion4pendulum_a_equals_5, tspan, [0.5 0]);
subplot(2,2,1), plot(t, theta(:,1))
grid on
xlabel('time (s)')
ylabel('\theta (rad)')
title('P2-1 a)')

% b)
[t,theta] = ode45(motion4pendulum_a_equals_5, tspan, [3 0]);
subplot(2,2,2), plot(t, theta(:,1))
grid on
xlabel('time (s)')
ylabel('\theta (rad)')
title('P2-1 b)')

% c)
motion4pendulum_a_linear_with_t = @(t, theta) [
    theta(2)
    (( 0.5*t*cos(theta(1)) - g*sin(theta(1)) )/L)
];
[t,theta] = ode45(motion4pendulum_a_linear_with_t, tspan, [3 0]);
subplot(2,2,[3 4]), plot(t, theta(:,1))
grid on
xlabel('time (s)')
ylabel('\theta (rad)')
title('P2-1 c)')
suptitle('motion of a pendulum whose base is accelerating horizontally')
