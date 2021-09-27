%% GA tuning for MPC tracking
% IMP Notes: This file is used to GA tune parameters using the MPC toolbox.

clear; close all; clc;
addpath('utils\')
addpath('KOFromData\')
% load parameters and options for GA
load('..\parameters.mat')
param.data = load ('KO35.mat');
param.rmax = 45*pi/180;
param.theta0 = [0 0 0 0]*pi/180;     % Up-Up
param.thetaT = [0 0 0 0];
% Koopman
param.Koopman = 1; % GA for True or Koopman
% Plot initial and final conditions for reference
plotfig(param);

%%
% for i = 1:1
    [param,options,MPCobj] = ga_params_MPC(param);
    %%
    tic
    FitnessFunction = @(x) fitnessfunc_MPC(x);
    % GA
    [X,FVAL,EXITFLAG,OUTPUT,POPULATION,SCORES] = ...
        ga(FitnessFunction,param.numOfParameters,[],[],[],[],param.lb,param.ub,[],options);
    toc
    %     % Save best gene for the preceding GAs as a better starting point
    %     [V, ind] = min(SCORES);
    %     gene = POPULATION(ind,:);
    %     best_genes = [];
    %     if exist('best_genes.DNT.mat','file')
    %     load('best_genes.DNT.mat');
    %     end
    %     best_genes = [gene; best_genes];
    %     save('best_genes.DNT.mat', 'best_genes');
% end