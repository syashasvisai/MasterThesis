function [param,options] = ga_params_MPC_rbf(param)
%% Options for GA
options = optimoptions('ga');
options.PopulationSize = 10;
options.MaxGenerations = 10;
options.OutputFcn = @myfun;
param.Ts = 0.005;
param.Tsim = 17;
param.Nsim = param.Tsim/param.Ts;
param.numOfParameters = 5; % [q11,q22,q33,q44,r]
param.lb = [1;1;0;0;1e-1];
param.ub = [1e3;5e2;1e1;1;1e2];

% param.initialPopulation = [85.3784,15.3198,0,0.4436];
% param.initialPopulation = [84.3784546295141,89.9501276455957,0,0.0839466739931350,0.1]; % 45° (from 5° data)
param.initialPopulation = [99.895564981400070,36.778725418957570,5.126655336054643,0.018752775370497,21.486737008858295]; % 60° (from 5° data)
Tpred = 1;
% Prediction horizon
param.Np = round(Tpred / param.Ts);
%% Best genes (If they exist from previous optimizations)
% Load Best genes if the file exists
% if exist('best_genes.DNT.mat','file')
%     load('best_genes.DNT.mat');
%     num_of_best_genes = size(best_genes,1);
%     param.initialPopulation(end - num_of_best_genes + 1:end, :) = best_genes;
% end
%% Linear matrices and state vectors
param.nObsv = size(param.data.Alift,1);
param.C = param.data.Clift; %
param.D = [];
param.sys = ss(param.data.Alift,param.data.Blift,param.data.Clift,param.D,param.Ts);
end