clear all
close all
clc

R = 0.8;
L = 0.003;
K_T = 0.05;
K_e = 0.05;
c = 0;
J = 8e-5;

DCMotor_Vc_20V = @(t, i_omiga) [  % i_omiga(1) is i; i_omiga(2) is omiga
    (( -R*i_omiga(1) - K_e*i_omiga(2) + 20)/L)
    (( K_T*i_omiga(1) - c*i_omiga(2) )/J)
];

tspan = [0, 0.5];
i_omiga_0 = [0, 0];  % First entry is i_0; Second is omiga_0
[t,i_omiga] = ode45(DCMotor_Vc_20V, tspan, i_omiga_0);  % i_omiga(:,1) is i; i_omiga(:,2) is omiga

p_i = plot(t, i_omiga(:,1));
hold on
p_omiga = plot(t, i_omiga(:,2), '-r');
xlabel('time (s)')
legend([p_omiga, p_i], "speed (rad/s)", "current (A)", 'Location','EastOutside')
title("armature-controlled DC motor's speed and current vs time")

f_position = get(gcf, 'position');
width = f_position(3)+150;
set(gcf, 'position', [f_position(1), f_position(2), width, f_position(4)])