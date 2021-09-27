%% GA tuning for LQi tracking
% IMP Notes: When using with KO model of n>4, change the size of the
% variable 'y' (in the matlab function 'ADIP/augmented_state' Was not able
% to automate this due to a strange simulink error. This file can also be
% used to tune the swing-up parameters with necessary substitutions.
clear; close all; clc;
addpath('utils\')
addpath('KOFromData\')
% load parameters and options for GA
load('..\parameters.mat')
param.data = load ('KO40_10ms.mat');
param.rmax = 40*pi/180;
param.theta0 = [0 0 0 0]*pi/180;     % Up-Up
param.thetaT = [0 0 0 0];
% Koopman
param.Koopman = 1; % GA for True or Koopman
% Plot initial and final conditions for reference
plotfig(param);
%%
% load parameters and options for GA
% for i = 1:4
    [param,options] = ga_params_LQi(param);
    %%
    tic
    FitnessFunction = @(x) fitnessfunc_LQi(x,param);
    % GA
    [X,FVAL,EXITFLAG,OUTPUT,POPULATION,SCORES] = ...
        ga(FitnessFunction,param.numOfParameters,[],[],[],[],param.lb,param.ub,[],options);
    %     Save best gene for the preceding GAs as a better starting point
    %     [V, ind] = min(SCORES);
    %     gene = POPULATION(ind,:);
    %     best_genes = [];
    %     if exist('best_genes.DNT.mat','file')
    %         load('best_genes.DNT.mat');
    %     end
    %     best_genes = [gene; best_genes];
    %     save('best_genes.DNT.mat', 'best_genes');
    toc
% end