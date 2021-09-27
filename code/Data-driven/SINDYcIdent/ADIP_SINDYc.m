% This file meant to approximately identify the most important terms of the
% RHS dynamics. The plant is actuated with an input that drives the
% pendulum away from the point of stable equillibrium. The SINDy with
% control algorithm is implemented in a iterative fashion to best identify
% the dominant RHS functions.

% data_fixed_freefall.mat is data generated from stable equilibrium with a
% chirp signal initially and after a period of time the pendulum is just
% allowed to freefall, therefore, it is a combination of both data with
% input and without. It did not give any 'better' results than
% data_fixed.mat since the result from the latter was good already. Infact,
% there was no difference between the two.

close all; clear; clc;
addpath('../utils');
addpath('../DataGenerator/')

load ..\..\parameters.mat

load data_fixed.mat
%% SINDYc options
Nvar = 4; % Dimension of the system (or the measurements)
% Options to generate library of candidate functions
polyorder = 1;    % Enter the order of the polynomial)
usesine = 0;      %  To use trignometric functions)
polysine = 1;     % (To use a combination of polynomial & Trig. func.)
lambda = 0.5;    % Sparsity Knob
options = odeset('RelTol',1e-10,'AbsTol',1e-10*ones(1,Nvar));
param.theta0 = [pi;pi;0;0];

% Data from multiple trajectories, select 0 to generate data from a single
% trajectory
Multi_traj = 1;
Discrete = 0;     % Run Discrete time SINDy
%% Data
getTrainingData
%% Train the SINDYc with the available measurement data and generate a
% sparsity matrix
trainSINDYc
% observables
% %% Compare identified dynamics with training data
% % Simulate identified dynamics
tic
[~,xSINDYc]=ode45(@(t,x)sparseGalerkinControl(t,x,forcing_train(x,t),...
    Xi(:,1:Nvar),polyorder,usesine,polysine),tspan,x0,options);
toc
% % %%
% % if Discrete
% %     p.ahat = Xi(:,1:Nvar);
% %     p.polyorder = polyorder;
% %     p.usesine = usesine;
% %     p.polysine = polysine;
% %     p.dt = dt;
% %     [N,Ns] = size(x_act);
% %     xSINDYc = zeros(Ns,N); xSINDYc(:,1) = x0';
% %     for ct=1:N-1
% %         xSINDYc(:,ct+1) = rk4u(@sparseGalerkinControl_Discrete,xSINDYc(:,ct),u(ct),dt,1,[],p);
% %     end
% %     xSINDYc = xSINDYc';
% % end
% % %%
plotCompareSINDYc(x_train,xSINDYc,Nvar,tspan,dt)
%% Validation with a new forcing function.
% Make sure that the range of theta lies in the training data. Frequencies
% and amplitude can change
getValidationData
%%
tic
[~,xSINDYc]=ode45(@(t,x)sparseGalerkinControl(t,x,forcing_val(x,t),...
    Xi(:,1:Nvar),polyorder,usesine,polysine),tspan,x0,options);
toc
plotCompareSINDYc(x_val,xSINDYc,Nvar,tspan,dt)
%% Show training and prediction
tval = t+10;
Viz_SI
%% print function
print('-depsc2', '-loose', '-cmyk', 'TrainingData.eps');
