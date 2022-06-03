clear all
close all
clc

R = 0.8;
L = 0.003;
K_T = 0.05;
K_e = 0.05;
c = 0;
J = 8e-5;

% picewise func v(t)
v = @(t) 400*t .* (t>=0 & t<0.05) ... 
         + 20 * (t>=0.05 & t<=0.2) ...
         + (-400*(t-0.2)+20) .* (t>0.2 & t<=0.25) ...
         + 0 * (t>0.25);

% Inputs for solving the ODE
tspan = [0, 0.3];
if ~isempty(find(tspan<0, 1))  % The interval t < 0 is undefined in v(t), so check the invalid t.
    error('time span must be positive')
end
i_omiga_0 = [0, 0];  % First entry is i_0; Second is omiga_0

DCMotor_Vc_is_piecewise_func = @(t, i_omiga) [
    (( -R*i_omiga(1) - K_e*i_omiga(2) + v(t) )/L)
    (( K_T*i_omiga(1) - c*i_omiga(2) )/J)
];

[t,i_omiga] = ode45(DCMotor_Vc_is_piecewise_func, tspan, i_omiga_0);  % i_omiga(:,1) is i; i_omiga(:,2) is omiga

% Plot on the same figure and get the plot handle for later use
p_omiga = plot(t, i_omiga(:,1));
hold on
p_v = plot(t, v(t), '-r');

% Set the maximum value displayed on the y-axis to 25
ylimits = get(gca, 'YLim');
set(gca, 'YLim', [ylimits(1), 25])

% Add some text explanations
legend([p_v, p_omiga], 'applied voltage (V)', "speed (rad/s)", 'Location','EastOutside')
title("armature-controlled DC motor's speed and applied voltage vs time")

% Widen the figure
f_position = get(gcf, 'position');
width = f_position(3)+250;
set(gcf, 'position', [f_position(1), f_position(2), width, f_position(4)])
