% The code is built with help from publicily available code by Korda et al.
% for their publication 'Linear predictors for nonlinear dynamical
% systems'.
%% MPC setup
% Discretizing the original plant for computing dynamic solution. A
% simulink model also can be built for this purpose and the data can be
% recorded and used. This just seemed to be a relatively easier way than
% building a simulink model.

f_u = @dyn_ADIP; % Dynamics
% Discretize the dynamics through Runge-Kutta 4
k1 = @(t,x,u) ( f_u(t,x,u) );
k2 = @(t,x,u) ( f_u(t,x + k1(t,x,u)*param.Ts/2,u) );
k3 = @(t,x,u) ( f_u(t,x + k2(t,x,u)*param.Ts/2,u) );
k4 = @(t,x,u) ( f_u(t,x + k1(t,x,u)*param.Ts,u) );
f_ud = @(t,x,u) ( x + (param.Ts/6) * ( k1(t,x,u) + 2*k2(t,x,u) + 2*k3(t,x,u) + k4(t,x,u)));

% Simulation steps
Nsim = param.Tsim/param.Ts;
% The range of the trajectory can be increased a bit (40° -> 45°) thanks to
% the MPC controller.
load ref45_5ms.mat
yrr45 = ref45';

% predicting 1 second into the future since this is a highly unstable
% system and cannot run in open loop for longer times
Tpred = 1;
% Prediction horizon
Np = round(Tpred / param.Ts);
% The 'future' reference inputs are provided for anticipatory action of
% MPC, for this reason it is required to augment the original reference
% vector with the expected future reference state, which in our case is
% just an extension of the final state.
yrr45 = [yrr45 yrr45(:,end-Np+1:end)];

% Constraints
xlift_min = [];
xlift_max = [];
u_min = -2.5; %Nm
u_max = 2.5;

% Discrete time linear matrices of the locally linearized system
A_true = syst_D.A;
B_true = syst_D.B;
C_true = eye(param.n);

QN = Q; % penalty on final state. Can be tuned. Was not really necessary in this case

tictoc_local = [];
%% Local MPC
% Build MPC for locally linearized plant
localMPC = getMPC(A_true,B_true,C_true,[],Q,R,QN,Np,u_min, u_max, xlift_min, xlift_max,'qpoases');
x0 = param.theta0; u_loc = 0;
x_loc = x0';
XX_loc = x0'; UU_loc = [];

% Closed-loop simultion start
for i = 0:Nsim-1
    if(mod(i,10) == 0)
        fprintf('Closed-loop simulation: iterate %i out of %i \n', i, Nsim)
    end
    % Current value of the reference signal (Anticipatory)
    yr = yrr45(:,(i+1):i+Np);
    %   Local linearization MPC
    tic
    u_loc = localMPC(x_loc,yr);
    tictoc_local = [tictoc_local; toc];
    
    x_loc = f_ud(0,x_loc,u_loc);
    % Store values
    XX_loc = [XX_loc x_loc];
    UU_loc = [UU_loc u_loc];
end
avg_compTime_local = mean(tictoc_local)