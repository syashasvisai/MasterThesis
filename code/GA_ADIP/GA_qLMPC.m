%% GA tuning for qLMPC tracking
clear; close all; clc;
% load parameters and options for GA
load('..\parameters.mat')
param.rmax = 60*pi/180;
param.theta0 = [0 0 0 0]*pi/180;     % Up-Up
param.thetaT = [0 0 0 0];
param.anticipatory_ref=1;
% Plot initial and final conditions for reference
% plotfig(param);
%%
% for i = 1:1
    [param,options] = ga_params_qLMPC(param);
    %%    
    FitnessFunction = @(x) fitnessfunc_qLMPC(x);
    % GA
    [X,FVAL,EXITFLAG,OUTPUT,POPULATION,SCORES] = ...
        ga(FitnessFunction,param.numOfParameters,[],[],[],[],param.lb,param.ub,[],options);
    
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