function error = errorPlots(theta0,t_span,polyorder,usesine,options) 
% load the data that should be compared
K1 = load('K_5_0.05.mat');
K2 = load('K_10_0.05.mat');
K3 = load('K_5_0.4.mat');
K4 = load('K_5_0.1.mat');


% K3 = load('K_10_0.4.mat');
% K4 = load('K_10_0.6.mat');
% K5 = load('K_10_0.1.mat');
KLambda = [K1 K2 K3 K4];

data = sim('ADIP_Sim_Data');
xA = data.xk1;

error = [];
for ii = 1:size(KLambda,2)
    [tB,xB]=ode45(@(t,x)sparseGalerkin(t,x,KLambda(ii).Xi,polyorder,usesine),t_span,theta0',options); % approximate
    error_ = xA(end-1,:)-xB;
    error = [error error_(:,1:2)];
end
clf
figure(1)
for ind = 1:size(error,2)
    if(mod(ind,2)==0)
        subplot(2,1,1)
        hold on
        plot(tB,error(:,ind).^2);
    else
        subplot(2,1,2)
        hold on
        plot(tB,error(:,ind).^2);
    end
end
lab_opt = {'fontsize', 16};
subplot(2,1,1)
title('Squared error comaprison between Fixed and Variable sampling times, \lambda = [0.05, 0.5]')
legend(' \lambda = 0.5,var.', ' \lambda = 0.5, fix.', ' \lambda = 0.05, var.',' \lambda = 0.05, fix.',lab_opt{:})
xlabel('time(s)',lab_opt{:})
ylabel('\phi_1 error^2',lab_opt{:})
subplot(2,1,2)
title('Squared error comaprison between Fixed and Variable sampling times, \lambda = [0.05, 0.5]')
legend(' \lambda = 0.5,var.', ' \lambda = 0.5, fix.', ' \lambda = 0.05, var.',' \lambda = 0.05, fix.',lab_opt{:})
xlabel('time(s)',lab_opt{:})
ylabel('\phi_2 error^2',lab_opt{:})
% subplot(2,1,1)
% title('Squared error between true and identified \phi_1 w.r.t \lambda')
% legend('\lambda = 0.05', '\lambda = 0.3')
% xlabel('time(s)')
% ylabel('error^2')
% subplot(2,1,2)
% title('Squared error between true and identified \phi_2 w.r.t \lambda')
% legend('\lambda = 0.05', '\lambda = 0.3')
% xlabel('time(s)')
% ylabel('error^2')
% cost = sum(cost)
% cost = sqrt(mean(error))
end



