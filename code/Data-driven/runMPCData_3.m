%% Basis functions
basisFunction = 'rbf';
% Max range of data we want to consider
t1_max = 45*pi/180;
t2_max = 2*pi/180;
t1d_max = 1; t2d_max = 1;
param.Nlift = param.Nrbf + param.n;
% The distribution of the centres is done individually for each state since
% they change on different scales/ranges. 
% cent = zeros(param.n,param.Nrbf);
% cent(1,:) = rand(1,Nrbf)*2*t1_max - t1_max; % RBF centers
% cent(2,:) = rand(1,Nrbf)*2*t2_max - t2_max;
% cent(3,:) = rand(1,Nrbf)*2*t1d_max - t1d_max;
% cent(4,:) = rand(1,Nrbf)*2*t2d_max - t2d_max;%%
% cent = rand(param.n,param.Nrbf)*2 - 1; % RBF centers
% Load saved 'best' centres
load centBest.mat
% plotRBFcentre
rbf_type = 'thinplate'; % thinplate, gauss, invquad, invmultquad, polyharmonic
param.liftFun = @(xx)( [xx;rbf(xx,cent,rbf_type,1)] );
% Regression
[Alift,Blift,Clift] = regressRBF(x,u,param);
% 
% % Tuning matrices for model derived from 5° data for ref45
% Q = blkdiag(84.3784546295141,89.9501276455957,0,0.0839466739931350);
% R = 0.1; 

% Tuning matrices for model derived from 5° data for ref60
Q = blkdiag(99.895564981400070,36.778725418957570,5.126655336054643,0.018752775370497);
R = 21.486737008858295; 
%% MPC
% Build Koopman MPC controller 
koopmanMPC  = getMPC(Alift,Blift,Clift,[],Q,R,QN,Np,u_min, u_max, xlift_min, xlift_max,'qpoases');
x_koop = param.theta0';
x_lift = param.liftFun(x_koop);
XX_koop3 = x_koop; UU_koop3 = [];

load ref60_5ms.mat
yrrext = ref60';
yrrext = [yrrext yrrext(:,end-Np+1:end)]; 

% Closed-loop simultion start
for i = 0:Nsim-1
    if(mod(i,10) == 0)
        fprintf('Closed-loop simulation: iterate %i out of %i \n', i, Nsim)
    end
    
    % Current value of the reference signal (Anticipatory)
    yr = yrrext(:,(i+1):i+Np);
    % Koopman MPC
    u_koop = koopmanMPC(x_lift,yr); % Get control input
    x_koop = f_ud(0,x_koop,u_koop); % Update true state
    x_lift = param.liftFun(x_koop);

    XX_koop3 = [XX_koop3 x_koop];
    UU_koop3 = [UU_koop3 u_koop];
end