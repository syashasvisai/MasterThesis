% This file contains the intialization parameters for a qLMPC
% implementation of the ADIP. Select swingup = 1 for qLMPC swingup. Select
% anticipatory_ref = 1 for anticipatory reference tracking. Note that the
% reference signal should be manually switched in the Simulink file too.

clc; clear all; close all;
addpath('..\Data-driven\DataGenerator\References\5ms')
%% parameters
load ..\parameters.mat
param.theta0 = [0,0,0,0];
param.rmax = 60*pi/180;
param.N = 40; % This parameter MUST be changed in the 'ADIP_qLMPC/qLMPC/qLPVMPC' file too. parametrizing won't work for some reason
param.Q = [1884.43340565748,1777.43534813155,80.1622306315080,0.758819384742859]; % 130.9470,78.3460,2.1230,0.0342
param.R = 26.1288357682325; %1.2132
param.P = 2219.42210073220*param.Q; % 716.6427*param.Q
Xko_init = kron(ones(param.N,1),zeros(4,1));
param.Ts = 0.005;
param.Tsim = 17;
param.Ulim = 2.5;
param.iterations = 1;
param.tspan = 0:param.Ts:param.Tsim;
%% Select type of reference: current or anticipatory.
% Anticipatory reference: The controller is able to 'see' the future
% reference values and consequently compute the optimal inputs. 
% Here it is done only for 60degree, however one can generate for any
% trajectory by simply loading the relevant data file (for ex: ref60_5ms.mat)

% Make sure to switch in Simulink too. 

anticipatory_ref=0;

if anticipatory_ref
    load r60_1s.mat
    ref = [ref60; ref60(end-param.N+1:end,:)];
    for i = 1:length(param.tspan)
        r = ref(i:i+param.N-1,:);
        rA(i,:) = reshape(r',[],1);
    end
    r = [param.tspan' rA]; % creates a input vector of N future steps of reference for every time instance.
    switch_rA = 1;
else
    r = [param.tspan' ones(size(param.tspan,2),1)];
    switch_rA = 0;
end
%% SwingUp
swingup = 1;
% IMP: Switch to 'current reference' in Simulink

if swingup
    param.theta0 = [pi,pi,0,0];
    param.rmax = 0;
    param.Q = [2623.00461301948,746.356997478988,46.6476986107682,0.508564871874709];
    param.R = 61.4059134944070;
    param.P = 427.247203203734*param.Q;
    switch_rA = 0;
end
%%
sim('ADIP_qLMPC')
%% errors and plots
% % error_qLMPC = RMSE(data(:,1:4),ref60)
% % data_cur = data;
% % data_ant = data;
% 
% % plotCompareqLMPC(data_ant,data_cur,ref60,param.tspan,param.Ts)
% % plots_qLMPC
% print('-depsc2', '-loose', '-cmyk', 'qLMPC_swingup.eps');