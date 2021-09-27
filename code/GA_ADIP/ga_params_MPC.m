function [param,options,MPCobj] = ga_params_MPC(param)
%% Options for GA
options = optimoptions('ga');
% options = optimoptions('gamultiobj');
options.PopulationSize = 10;
options.MaxGenerations = 5;
options.OutputFcn = @myfun;
param.Ts = 0.01;
param.Tsim = 17;
param.numOfParameters = 5; % [q11,q22,q33,q44,r]
param.lb = [1;1;0;0;1e-1];
param.ub = [1e2;1e2;1e1;1;1e2];

% param.initialPopulation = [85.67,99.28,4.23,0.01,63;...
%     35.3,79,3.9,0.95,7.4;...
%     65,96,2.5,0.46,48.7:...
%     74,50,0.74,5.47,0.91,47.47]; % Local model

param.initialPopulation = [];
% %% Best genes (If they exist from previous optimizations)
% % Load Best genes if the file exists
% if exist('best_genes.DNT.mat','file')
%     load('best_genes.DNT.mat');
%     num_of_best_genes = size(best_genes,1);
%     param.initialPopulation(end - num_of_best_genes + 1:end, :) = best_genes;
% end
%% Linear matrices and state vectors
if param.Koopman
    param.nObsv = size(param.data.AK,1);
    param.C = eye(4);
    param.D = [];
    param.sys = ss(param.data.AK,param.data.BK,param.C,param.D,param.Ts);
else
    % First principle model matrices
    param.nObsv = size(param.A_uu,1);
    param.C = eye(4); %
    param.D = [];
    sys_cont = ss(param.A_uu,param.B_uu,param.C,param.D);
    param.sys = c2d(sys_cont,param.Ts);
end
%% Parameters
% Parameters for the nonlinear model
param.parameters = [param.m_arm param.m_pend param.m_hinge param.l_pivot ...
    param.l_pend param.g param.Jarm param.Jpend param.Jl param.Jhinge...
    param.C_arm param.C_pend ];

% Simulink model
param.ADIP_GA = 'GA_MPC_sim';

% Open and load the simulink file
open_system(param.ADIP_GA);
load_system(param.ADIP_GA);
%% Assigning parameters to the Simulink model
% Assign parameters to the nonlinear ADIP model
set_param('GA_MPC_sim/ADIP/Parameters','Value', mat2str(param.parameters));

% Assign the initial conditions vector
set_param('GA_MPC_sim/ADIP/InitCondn', 'Value', mat2str(param.theta0));

%% MPC object
Tpred = 1;
N = Tpred/param.Ts; % Prediction Horizon
Nu = 5; % Control Horizon

model = ss(param.data.AK,param.data.BK,param.C,param.D,param.Ts);
MPCobj = mpc(model,param.Ts,N,Nu); % output is the MPC controller object

% Setup output constraints (Default value - [-inf inf])
MPCobj.OV(1).Min = -46*pi/180;
MPCobj.OV(1).Max = 46*pi/180;
MPCobj.OV(2).Min = -5*pi/180;
MPCobj.OV(2).Max = 5*pi/180;

% Setup input constraints
MPCobj.MV(1).Min = -2.5;
MPCobj.MV(1).Max = 2.5;

% Compute optimal control
MPCstate=mpcstate(MPCobj);
MPCstate.plant = [0,0,0,0];
end