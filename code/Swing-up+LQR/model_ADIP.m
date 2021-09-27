% theta1 and theta2 are the angles made by axis of the arm and pendulum
% w.r.t the y-axis. Chosen in such a way to facilitate linearization about
% theta1 = theta2 = 0 (Up-Up configuration).

% Since this is a physical pendulum with mass distributed along its
% length, it is convinient to calculate the total kinetic energy as the sum
% of translational kinetic energy and rotational energy about its COM. Only
% viscous friction (i.e. friction dependent on joint velocities) is
% considered here. However, it is a simple exercise to add static and/or
% Coloumb friction to the final governing differential equation.
clear; clc; close all
%% Equations of Motion
load('symbolics.mat');
%
x_1 = (l1/2)*sin(theta1);              % COM_Arm_x
y_1 = (l1/2)*cos(theta1);              % COM_Arm_y
x_2 = 2*x_1 + (l2/2)*sin(theta2);      % COM_Pendulum_x
y_2 = 2*y_1 + (l2/2)*cos(theta2);      % COM_Pendulum_y
[dy,T,V]  = dyn_eqns(x_1,x_2,y_1,y_2); % [Gov.Eqns,Kin. energy,Pot. energy] 
%% Linearized equations
[A_jcb, B_jcb] = jacobian_eq(dy);
%% Substituting parameters (For LQR Matrices)
load('..\parameters.mat')
% Equillibrium points - Select as required
% thetaT = [0,0];     % (Up-Up) (Unstable equillibrium / Top position)
% thetaT = [pi,0];    % (Down-Up)  (Mid-position)
thetaT = [pi,pi];     % (Down-Down) (Stable equillibrium / Safety catch)
%
u_eq = -(param.m_arm/2 + param.m_pend + param.m_hinge)*param.l_pivot*param.g*sin(y1); % input at equillibrium
A_jcb = subs(A_jcb,u,u_eq);
%
A = subs(A_jcb,[m1,mh,m2,l1,l2,g_,J_arm,J_pend,J_motor,J_sensor,...
    fv1,fv2,y1,y2,y3,y4],[param.m_arm,param.m_pend,param.m_hinge,...
    param.l_pivot,param.l_pend,param.g,param.Jarm,param.Jpend,param.Jl,...
    param.Jhinge,param.C_arm,param.C_pend,thetaT(1),thetaT(2),0,0]);

B = subs(B_jcb,[m1,mh,m2,l1,l2,g_,J_arm,J_pend,J_motor,J_sensor,...
    fv1,fv2,y1,y2,y3,y4],[param.m_arm,param.m_pend,param.m_hinge,...
    param.l_pivot,param.l_pend,param.g,param.Jarm,param.Jpend,param.Jl,...
    param.Jhinge,param.C_arm,param.C_pend,thetaT(1),thetaT(2),0,0]);

A = double(A)
B = double(B)
%% Calculations for swing-up input (Fantoni et al.)
[u_swing,~,~] = swingup(dy(3),T,V,param)
%% Mass and Non-linearities matrices (If required)- For LPV
% Always replace 'eqn1' and 'eqn2' in this file if there are any changes in
% the formulation of equations
run('massMatrix.m');
% C(1,2) and C(2,1) miss a factor of (2) due to the method adopted to
% derive the C matrix. Nevertheless this is only to check the formulation.