clear ; close all; clc
addpath('./utils');
addpath('./DataGenerator'); % For data
% load references directory. Note that there are seperate directories for
% references generated for 5ms and 10ms sampling times. Load as per
% requirement.
addpath('./DataGenerator/References/');
addpath('./DataGenerator/References/5ms');

% Options for MPC
addpath('./Resources')  
addpath('./Resources/qpOASES-3.1.0/interfaces/matlab')
% IMP: Run the make.m file from the above path if running on the PC for the
% first time. 
%% Data
% closed40_5ms.mat/closed40_10ms.mat is the closed loop data generated from
% multiple initial conditions around the unstable equillibrium with noise
% added to the input to distinguish feedback control from state dynamics.

% load measurement data
load closed40_5ms.mat
% load relevant parameters for the true model.
load('..\parameters.mat')

% One can sparsify the data just to decrease computation time.
% Observation - taking only every '10'th time step decreases the computation
% time by a factor of 3. But the response does not vary degrade much,
% However, this must be researched more. 
% Additionally the initial conditions can be altered such that there is no
% variation in the theta1d and theta2d, since a small variation in these do
% not affect the system much.
%
%x = x(1:10:end,:); u = u(1:10:end,:);
%% Options
param.polyorder = 1;    % search space up to nth order polynomials
param.usesine   = 0;    % trig functions
param.polysine  = 0;    % use product of 1st & 2nd order poly. & trig functions
param.n = 4;            % 4D system
param.options = odeset('RelTol',1e-10,'AbsTol',1e-10*ones(1,param.n));
param.Ts = 0.005;
param.theta0 = [0,0,0,0];
param.thetaT = [0,0,0,0];
param.rmax = 40*pi/180; % Max tracking angle desired for true model
param.Tsim = 17;
param.Nrbf = 50;
%% Local model (LQi) - linearized local dynamics 
runLocalModel
%% EDMDc with polynomials/sine/polynomial+sine functions (LQi)
% It is important to change the dimension of the state vector in the
% simulink file 'EDMDtest/augmented_state' when the number of observables
% change(specified by the user as a consequence of choosing the
% polyorder,usesine and polysine options above)
runDataDriven
%% Compare LQR for true model and Koopman model
plotCompareLQR(xt,xK,ref,t,param.Ts)
%% Animations
animate_traj(x,XX_koop3',param)
animate_plantCombi(x,XX_koop3',ref60,ref54,param)
%% MPC
% local linearization model
runMPCLocal
% DataDriven with polynomials/sine basis functions
runMPCData_1
% DataDriven with radial basis functions
runMPCData_2
%% DataDriven with RBF and 60 degrees reference
runMPCData_3
%% Plots
% Compare tracking performance of the KMPCs with local linearization
plotCompareMPC(XX_loc',XX_koop1',yrr45(:,1:length(ref45))',t,param.Ts)
% Compare KMPC1 and KMPC3
plotCompareMPC2(XX_koop1',XX_koop3',yrr45(:,1:length(ref45))',yrrext(:,1:length(ref60))',t,param.Ts);
% plotCompareMPC2(data1',data2',r1,r2,data3',r3,t,param.Ts);
%% Results
% Computation time and RMSE
evaluateCost
avg_compTime_local
avg_compTime_Data1
avg_compTime_Data2
error_LQiLocal = RMSE(xt,ref)
error_LQiKoopman = RMSE(xK,ref)
error_MPCLocal = RMSE(XX_loc',ref45)
error_MPCK1 = RMSE(XX_koop1',ref45)
error_MPCK2 = RMSE(XX_koop2',ref45)
error_MPCK3 = RMSE(XX_koop3',ref60)
%% for Latex
print('-depsc2', '-loose', '-cmyk', 'Cont_diffTraj.eps');