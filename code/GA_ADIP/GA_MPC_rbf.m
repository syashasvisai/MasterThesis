% Genetic Algorithm to optimize the tuning parameters Q and R for Koopman
% MPC controller. In this case with radial basis functions. However, this
% can be applied to any lifting function
%
clear all; close all; clc
addpath('utils\')
addpath('KOFromData\')
addpath('Resources\')
addpath('Resources\qpOASES-3.1.0\interfaces\matlab\')

% load parameters and options for GA
load('..\parameters.mat')
load ref60_5ms.mat
% Load the data 
load centBest.mat
param.cent = cent;
param.ref = ref60';
param.Nrbf = 50;
param.data = load ('lifted_from5degData.mat');

param.theta0 = [0 0 0 0]*pi/180;     % Up-Up
param.thetaT = [0 0 0 0];
% Koopman
% Plot initial and final conditions for reference
% plotfig(param);
%%
% for i = 1:1
    [param,options] = ga_params_MPC_rbf(param);
   %%
    FitnessFunction = @(x) fitnessfunc_MPC_rbf(x,param);
    % GA
    [X,FVAL,EXITFLAG,OUTPUT,POPULATION,SCORES] = ...
        ga(FitnessFunction,param.numOfParameters,[],[],[],[],param.lb,param.ub,[],options);
    
%     % Save best gene for the preceding GAs as a better starting point
%     [V, ind] = min(SCORES);
%     gene = POPULATION(ind,:);
%     best_genes = [];
%     if exist('best_genes.DNT.mat','file')
%         load('best_genes.DNT.mat');
%     end
%     best_genes = [gene; best_genes];
%     save('best_genes.DNT.mat', 'best_genes');
% end