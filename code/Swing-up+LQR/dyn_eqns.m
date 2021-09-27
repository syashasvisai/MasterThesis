function [dy,T,V] = dyn_eqns(x_1,x_2,y_1,y_2)
load('symbolics.mat')
x_1d = diff(x_1,t);
y_1d = diff(y_1,t);
x_2d = diff(x_2,t);
y_2d = diff(y_2,t);
%
% Velocities of COMs of the arm and pendulum
v1 = sqrt(x_1d^2 + y_1d^2);
v2 = sqrt(x_2d^2 + y_2d^2);
%
% Kinetic Energies of the arm and pendulum
T1 = simplify(0.5*J_arm*theta1_d^2 + 0.5*m1*v1^2);
T2 = simplify(0.5*J_pend*theta2_d^2 + 0.5*m2*v2^2);
%
% Rotational energy of the Motor assy. and the sensor assy. should be
% considered since the mass of the sensor assembly is NOT negligible
% w.r.t. the mass of the arm and pendulum.
T3 = 0.5*J_motor*theta1_d^2;  % J_motor acts at the shoulder of the arm
T4 = 0.5*J_sensor*theta1_d^2; % Treated as a point mass
%
% Potential Energies of the two arms and the sensor assembly
V1 = m1*g_*((l1/2) - y_1);
V2 = m2*g_*((l1 + l2/2) - y_2);
V3 = mh*g_*(l1 - 2*y_1);
T = [T1 T2 T3 T4];
V = [V1 V2 V3];
[dy] = lagrange(T,V);