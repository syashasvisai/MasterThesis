function [cost] = fitnessfunc_MPC_rbf(x,param)
%% Dynamics
f_u = @dyn_ADIP; % Dynamics
% Discretize the dynamics through Runge-Kutta 4
k1 = @(t,x,u) ( f_u(t,x,u) );
k2 = @(t,x,u) ( f_u(t,x + k1(t,x,u)*param.Ts/2,u) );
k3 = @(t,x,u) ( f_u(t,x + k2(t,x,u)*param.Ts/2,u) );
k4 = @(t,x,u) ( f_u(t,x + k1(t,x,u)*param.Ts,u) );
f_ud = @(t,x,u) ( x + (param.Ts/6) * ( k1(t,x,u) + 2*k2(t,x,u) + 2*k3(t,x,u) + k4(t,x,u)));
%% Basis functions
%basisFunction = 'rbf';
% plotRBFcentre
rbf_type = 'thinplate'; % thinplate, gauss, invquad, invmultquad, polyharmonic
param.liftFun = @(xx)( [xx;rbf(xx,param.cent,rbf_type,1)] );
%% Tuning parameters
Q = blkdiag(x(1),x(2),x(3),x(4));
R = x(5);
% Constraints
xlift_min = [];
xlift_max = [];
u_min = -2.5;
u_max = 2.5;
%% MPC
% Build Koopman MPC controller
koopmanMPC  = getMPC(param.data.Alift,param.data.Blift,param.data.Clift,[],Q,R,Q,param.Np,u_min, u_max, xlift_min, xlift_max,'qpoases');
x_koop = param.theta0';
x_lift = param.liftFun(x_koop);
XX_koop3 = x_koop; UU_koop3 = [];

yrrext = param.ref;
yrrext = [yrrext yrrext(:,end-param.Np+1:end)];

try
    tic
    % Closed-loop simultion start
    for i = 0:param.Nsim-1
%         if(mod(i,10) == 0)
%             fprintf('Closed-loop simulation: iterate %i out of %i \n', i, param.Nsim)
%         end
        
        % Current value of the reference signal (Anticipatory)
        yr = yrrext(:,(i+1):i+param.Np);
        %     tic
        % Koopman MPC
        u_koop = koopmanMPC(x_lift,yr); % Get control input
        %     toc
        x_koop = f_ud(0,x_koop,u_koop); % Update true state
        x_lift = param.liftFun(x_koop);
        
        XX_koop3 = [XX_koop3 x_koop];
        UU_koop3 = [UU_koop3 u_koop];
    end
    toc
catch e
    disp(e)
    cost = 10^10
    return
end
%%
% sq_error = (XX_koop3(1,:)- param.ref(1,:)).^2 + (XX_koop3(2,:)- param.ref(2,:)).^2;
% + 0.01*(XX_koop3(3,:)- param.ref(3,:)).^2;
cost = RMSE(XX_koop3',param.ref')    
end

