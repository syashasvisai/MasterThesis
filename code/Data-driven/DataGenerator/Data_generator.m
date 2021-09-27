clear; clc; close all;
%% Plant
load('..\..\parameters.mat')
tracking = 1
param.Ts = 0.005;
param.Tsim = 17;

if tracking
    param.theta0 = [0;0;0;0];
else
    param.theta0 = [0.6*pi;0.6*pi;1;-1];
end
param.thetaT = [0;0;0;0];

A = param.A_uu;
B = param.B_uu;
C = [1 0 0 0];
D = 0;
sys1 = ss(A,B,C,D);
sys = c2d(sys1,param.Ts);

% Plot initial and final conditions for reference
plotfig(param);
%% Data with input (and/or freefall) around the stable equillibrium 
% DataWithInput
% save data_.mat x dx u theta0
%% Data with Feedback around the unstable equillbrium
% Assuming that a model and a controller exist, we collect the data around
% the unstable equillibrium to identify a closed loop model of the ADIP.
DataWithFeedback
%% Plots 
plotRef
%%
save closed35FromData.mat x dx u 