%% Parameters
% Taken from the manual for planar rotary inverted pendulum
param.Km = 0.0741;  % Nm/Amp Motor Torque constant
param.Kt = param.Km;      % Back emf = Motor constant for DC motor
param.Vmax = 24;    % volts
param.Imax = 21.6;  % amp
param.Rm = 1.11;    % ohms Terminal resistance
param.Lm = 1.81e-3; % MH Inductance
param.Mass_upperDisk = .075;
param.Mass_lowerDisk = 0.170;
param.radius = 2*.0254;
param.Jdisc_lower = param.Mass_lowerDisk * param.radius^2/4;
param.Jdisc_upper = param.Mass_upperDisk * param.radius^2/4;
param.Jm = 4.4e-3;        % oz in sec2
param.Jm = param.Jm * 1.829e-5; % motor inertia
param.Jl = 1.44e-04;% estimated % Jdisc_lower + Jm + Jdisc_upper -- (1.5814e-04) -- previous value

% Actual Measured
param.m_arm=0.1;     % Mass of arm (Total mass of arm is 0.170 Kg, mass of arm is assumed to be 0.1Kg)  
param.m_hinge=0.07;  % Mass of hinge(approx., assumption after measuring the mass of a similar encoder)
param.m_pend=0.070;  % Mass of pendulum
param.l_pivot=0.154; % Distance between hinge points on the arm
param.l_pend=0.186;  % Length of Pendulum
param.l_arm = 0.184; % Total length of arm - to calculate MOI about COM
param.w_arm = 0.038; % Width of arm, considered since it is significant relative to length
param.g = -9.81;
% MOI
param.Jhinge = 1.495e-03;%estimated       % MOI of sensor assy. at the Pivot -- m_hinge*l_pivot^2
param.Jarm = 2.674e-04; %estimated        % MOI about its COM -- (m_arm/12)*(l_arm^2+w_arm^2)
param.Jpend = 2.091e-04;%estimated        % MOI about its COM -- (m_pend/12)*l_pend^2 
% Damping Parameters
param.C_arm = 5.295e-04;                  % estimated
param.C_pend = 4.172e-04;                 % estimated 