%% Estimation of the friction parameters through Non-linear SysID toolbox
clc; clear all; close all;
%%
load('..\parameters.mat')
FileName      = 'ADIP_est';         % File describing the model structure.
Order         = [2 1 4];            % Model orders [ny nu nx].
Parameters    = [param.m_arm,param.m_pend,param.m_hinge,param.l_pivot,...
    param.l_pend,param.Jarm,param.Jpend,param.Jl,param.Jhinge,...
    1.3e-3,2.2e-5];                                          
InitialStates = [0;0;0;0];          % Initial value of the initial states.
Ts            = 0;                  % Time-continuous system.
nlgr = idnlgrey(FileName, Order, Parameters, InitialStates, Ts, 'Name', ...
                'ADIP',  ...
                'TimeUnit', 's'); 
            
nlgr.InputName = {'Torque'};     % u
nlgr.InputUnit = {'Nm'};
nlgr.OutputName = {'theta1'; ... % y(1)
                   'theta2'}; ... % y(2)
                                     
nglr.OutputUnit = {'rad' 'rad'};

nlgr = setinit(nlgr, 'Name', {'theta1'          ...   % x(1).
                       'theta2'                 ...   % x(2).
                       'theta1d'                ...   % x(3).
                       'theta2d'});             ...   % x(4).
nlgr = setinit(nlgr, 'Unit', {'rad' 'rad' 'rad/s' 'rad/s'});
% setting parameters
nlgr = setpar(nlgr, 'Name', {' Arm mass';      ... % 1. m1
                      'Pendulum mass';         ... % 2. m2
                      'Encoder assy. mass';    ... % 3. mh
                      'Arm length';            ... % 4. l1
                      'Pendulum length';       ... % 5. l2
                      'Inertia of arm';        ... % 6. J_arm
                      'Inertia of pendulum';   ... % 7. J_pend
                      'Inertia from sensor' ;  ... % 8. J_sensor
                      'Motor assy. inertia';   ... % 9. J_motor
                      'Damping of arm';        ... % 10. fv1
                      'Damping of pendulum'});     % 11. fv2    
                     
           
nlgr = setpar(nlgr, 'Unit', {'Kg'; 'Kg'; 'Kg'; 'm'; 'm'; 'kg/m^2'; ...
    'kg/m^2'; 'kg/m^2'; 'kg/m^2'; 'Nms/rad'; 'Nms/rad'});
%%
nlgr = setpar(nlgr, 'Minimum', num2cell(eps(0)*ones(size(Parameters,2), 1)));   % All parameters > 0!

nlgr.Parameters(1).Fixed = true;
nlgr.Parameters(2).Fixed = true;
nlgr.Parameters(3).Fixed = true;
nlgr.Parameters(4).Fixed = true;
nlgr.Parameters(5).Fixed = true;
nlgr.Parameters(6).Fixed = true;
nlgr.Parameters(7).Fixed = true;
nlgr.Parameters(8).Fixed = true;
nlgr.Parameters(9).Fixed = true;
% nlgr.Parameters(10).Fixed = true;
% nlgr.Parameters(11).Fixed = true;
present(nlgr)
%%
addpath('..\Data-driven\DataGenerator\Data_plant\');
load('dataP_1.mat')

theta = data1(:,1:2);
u = data1(:,5);
%%
Ts = 0.005;  
ze = iddata(theta, u, Ts, 'Name', 'Estimation data');
ze.InputName = nlgr.InputName;
ze.InputUnit = nlgr.InputUnit;
ze.OutputName = nlgr.OutputName;
ze.OutputUnit = nlgr.OutputUnit;
ze.Tstart = 0;
ze.TimeUnit = 's';
ze.ExperimentName = 'Estimation';
% Figures
% input data
figure('Name', [ze.Name ': input data']);
plot(ze.SamplingInstants, ze.InputData);
title(ze.InputName);
xlabel('');
axis tight;
xlabel([ze.Domain ' (' ze.TimeUnit ')']);
figure('Name', [ze.Name ': output data']);
% output data
for i = 1:ze.Ny
   subplot(ze.Ny, 1, i);
   plot(ze.SamplingInstants, ze.OutputData(:,i));
   title(['Output #' num2str(i) ': ' ze.OutputName{i}]);
   xlabel('');
   axis tight;
end
xlabel([ze.Domain ' (' ze.TimeUnit ')']);
%%
clf
compare(ze, nlgr);
%% Parameter estimation
opt = nlgreyestOptions('Display', 'on');
opt.SearchOptions.MaxIterations = 25;
nlgr = nlgreyest(ze, nlgr, opt);
%%
compare(ze, nlgr);
present(nlgr)