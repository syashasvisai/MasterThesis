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
%% MPC
% Build Koopman MPC controller 
koopmanMPC  = getMPC(Alift,Blift,Clift,[],Q,R,QN,Np,u_min, u_max, xlift_min, xlift_max,'qpoases');
x_koop = param.theta0';
x_lift = param.liftFun(x_koop);
XX_koop2 = x_koop; UU_koop2 = [];
 
tictoc_Data2 = [];
% Closed-loop simultion start
for i = 0:Nsim-1
    if(mod(i,10) == 0)
        fprintf('Closed-loop simulation: iterate %i out of %i \n', i, Nsim)
    end
    
    % Current value of the reference signal (Anticipatory)
    yr = yrr45(:,(i+1):i+Np);
    tic
    % Koopman MPC
    u_koop = koopmanMPC(x_lift,yr); % Get control input
    toc1 = toc;
    x_koop = f_ud(0,x_koop,u_koop); % Update true state
    tic
    x_lift = param.liftFun(x_koop);
    toc2 = toc;
    tictoc_Data2 = [tictoc_Data2; toc1+toc2];

    XX_koop2 = [XX_koop2 x_koop];
    UU_koop2 = [UU_koop2 u_koop];
end
avg_compTime_Data2 = mean(tictoc_Data2)