function [param,options] = ga_params_LQi(param)
%% Options for GA
options = optimoptions('ga');
options.PopulationSize = 10;
options.MaxGenerations = 10;
options.OutputFcn = @myfun;
options.FitnessLimit = 0.02; % This should be selected as per the problem
param.Ts = 0.01;
param.Tsim = 17;
param.numOfParameters = 6; % [q11,q22,q33,q44,r,qii]
param.lb = [1e2;0;1e-1;1e-1;1e-2;1];
param.ub = [1e3;1;1;1;1e1;1e3];

% param.initialPopulation = [229,0.58,0.667,0.79,0.27,940;...
%     100.5,0.97,0.376,0.737,3.575,852.545];  % For True model

param.initialPopulation = [205,0.35,0.31,0.9,5,935;...
    100,0.067,0.135,0.769,4.79,786.6;...
    231,0.3,0.28,0.7,6.5,945;...
    100.5,0,0.24,0.25,1.3,842;...
    122.7,0.12,0.42,0.68,1.9267,901.85]; % For Data-driven model
% %% Best genes (If they exist from previous optimizations)
% % load Best genes if the file exists
% if exist('best_genes.DNT.mat','file')
%     load('best_genes.DNT.mat');
%     num_of_best_genes = size(best_genes,1);
%     param.initialPopulation(end - num_of_best_genes + 1:end, :) = best_genes;
% end
%% Linear matrices and state vectors
if param.Koopman
    param.nObsv = size(param.data.AK,1);
    % Augment the output matrix for integrator We take only the measurment
    % of theta1 for calculating the Feedback integrator gain.
    param.C = [1,zeros(1,size(param.data.AK,1)-1)]; %
    param.D = [];
    param.sys = ss(param.data.AK,param.data.BK,param.C,param.D,param.Ts);
    % Since we compare the original augmented state vector with the
    % reference in computing LQR state feedback, we need to augment the
    % Target vector with observables
    param.thetaT = poolData(param.thetaT,param.data.n,param.data.polyorder,...
        param.data.usesine,param.data.polysine);
else
    param.nObsv = size(param.A_uu);
    % First principle model matrices
    param.C = [1,zeros(1,size(param.A_uu,1)-1)]; %
    param.D = [];
    sys_cont = ss(param.A_uu,param.B_uu,param.C,param.D);
    param.sys = c2d(sys_cont,param.Ts);
end
%% Parameters
% Swing-up tuning parameters
param.Kp = 4.5;
param.Kd = 0.4;
param.Ke = 0.8;

% Parameters for the nonlinear model
param.parameters = [param.m_arm param.m_pend param.m_hinge param.l_pivot ...
    param.l_pend param.g param.Jarm param.Jpend param.Jl param.Jhinge...
    param.C_arm param.C_pend param.Kp param.Kd param.Ke];

% Parameters for generating the augmented state vector in simulink
param.obsv = [param.data.n param.data.polyorder param.data.usesine param.data.polysine];

% Simulink model
param.data.ADIP_GA = 'GA_LQi_sim';

% Open and load the simulink file
open_system(param.data.ADIP_GA);
load_system(param.data.ADIP_GA)
%% Assigning parameters to the Simulink model
% Assign parameters to the nonlinear ADIP model
set_param('GA_LQi_sim/ADIP/Parameters','Value', mat2str(param.parameters));

% Assign parameters to the swing-up model
set_param('GA_LQi_sim/Controller/Swingup/Constants','Value',...
    mat2str(param.parameters));

% Assign parameters for the augmented state block
set_param('GA_LQi_sim/ADIP/augmented_state/param_obsv','Value',mat2str(param.obsv));
% Assign the initial conditions vector
set_param('GA_LQi_sim/ADIP/InitCondn', 'Value', mat2str(param.theta0));

% Assign the target state vector
set_param('GA_LQi_sim/Controller/Refernce/Target','Value',...
    mat2str(param.thetaT));
% Assign thetaT(1) in the reference block
set_param('GA_LQi_sim/Controller/Refernce/ThetaT1','Value',...
    mat2str(param.thetaT(1)));

% Assign swingup weights
% set_param('GA_LQi_sim/Controller/Swingup/Kp','Gain',mat2str(param.Kp));
% set_param('GA_LQi_sim/Controller/Swingup/Kd','Gain',mat2str(param.Kd));
% set_param('GA_LQi_sim/Controller/Swingup/Ke','Gain',mat2str(param.Ke));


% Assign switching conditions
% Reference block
set_param('GA_LQi_sim/Controller/Refernce/ref_track1','Gain',mat2str(1));
set_param('GA_LQi_sim/Controller/Refernce/ref_track2','Gain',mat2str(1));
set_param('GA_LQi_sim/Controller/Refernce/ref_swing1','Gain',mat2str(0));
set_param('GA_LQi_sim/Controller/Refernce/ref_swing2','Gain',mat2str(0));
% Controller block
set_param('GA_LQi_sim/Controller/track_on','Gain',mat2str(1));
set_param('GA_LQi_sim/Controller/lqr_on','Gain',mat2str(0));
set_param('GA_LQi_sim/Controller/lqi_on','Gain',mat2str(1));
set_param('GA_LQi_sim/Controller/swingup','Gain',mat2str(0));
end