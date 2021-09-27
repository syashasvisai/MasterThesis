% This file runs the 'local' model of the ADIP for comparison with the data
% driven model. The controller used is LQi

% % Tuning parameters (GA tuned for local model) - 10ms
% Q = blkdiag(100.5,0.97,0.376,0.737);
% R = 3.575;
% Qint = 852;
% 
% % Tuning parameters (GA tuned for data-driven model)- 10ms
% Q = blkdiag(122.7,0.12,0.42,0.68);
% R = 1.9;
% Qint = 902;

% Tuning parameters (GA tuned for local model LQi)
% Q = blkdiag(100,10,0.04,0.8);
% R = 1.7;


% Tuning parameters (GA tuned for data-driven model(rbf) MPC) - Np = 40
% (prediction horizon). Done just for testing.
% Q = blkdiag(20.12,11.5069,3.477,0.019);
% R = 82.19;
% Qint = 300;


% Tuning parameters (GA tuned for data-driven model(rbf) MPC) - Np = 200
Q = blkdiag(85.3784,15.3198,0,0.4436);
R = 1.4; 
Qint = 300;


At = param.A_uu;
Bt = param.B_uu;
Ct = [1 0 0 0]; % Measuring only theta1 for the sake of computing integral gain
Dt = [];
syst = ss(At,Bt,Ct,Dt);
syst_D = c2d(syst,param.Ts); % Continuous to discrete time

% % Swing-Up tuning parameters
% param.Kp = 5.5;   % 5.5
% param.Kd = 0.5;   % 0.5
% param.Ke = 1.0;   % 1.0

Qi = blkdiag(Q,Qint);
% LQR gain
Ft = -dlqr(syst_D.A,syst_D.B,Q,R)
% LQi gain
Fi_t = -lqi(syst_D,Qi,R)

% Record data
data = sim('ADIP_LocalSim');
xt = data.data(:,1:4);
ut = data.data(:,5);
ref = data.Ref;
t = data.tout;