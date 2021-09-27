3% Build Koopman MPC controller
koopmanMPC  = getMPC(AK,BK,CK,[],Q,R,QN,Np,u_min, u_max, xlift_min, xlift_max,'qpoases');
x_koop = param.theta0';  %n*1
x_lift = poolData_EDMD(param.theta0,param.n,param.polyorder,param.usesine,param.polysine); % 1*Nobsv
XX_koop1 = x_koop; UU_koop1 = [];

% Optimize
tictoc_Data1 = [];
% Closed-loop simultion start
for i = 0:Nsim-1
    if(mod(i,10) == 0)
        fprintf('Closed-loop simulation: iterate %i out of %i \n', i, Nsim)
    end
    
    % Current value of the reference signal (Anticipatory)
    yr = yrr45(:,(i+1):i+Np);
    
    % Koopman MPC
    tic
    u_koop = koopmanMPC(x_lift',yr); % Get control input
    toc1 = toc;
    x_koop = f_ud(0,x_koop,u_koop);  % Update true state
    tic
    x_lift = poolData_EDMD(x_koop',param.n,param.polyorder,param.usesine,param.polysine); % Lift the state
    toc2 = toc;
    tictoc_Data1 = [tictoc_Data1; toc1+toc2];
    XX_koop1 = [XX_koop1 x_koop];
    UU_koop1 = [UU_koop1 u_koop];  
end
avg_compTime_Data1 = mean(tictoc_Data1)