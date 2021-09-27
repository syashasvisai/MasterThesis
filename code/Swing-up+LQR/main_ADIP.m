% This is the file for LQR and LQi controllers to implement both a swing-up
% and trajectory tracking using plant model derived from first principles.
%
% IMP Notes:
% 1. The tuning values are only for swing-up and stabilization
% corresponding to Up-Up equillibrium. Tuning needs to be done for Down-Up
% and Safety catch or Down-Down configurations. The corresponding linear
% matrices are however already present.
clc; clear; close all;
%% Simulation parameters
% Enter '1' to for only tracking
tracking = 0
% Plant Parameters
load('..\parameters.mat')
param.Ts = 0.005; % Sample time
param.Tsim = 17;
param.rmax = 40*pi/180;

%Initial position
if tracking
    param.theta0 = [0;0;0;0]*pi/180;   % Up-Up
else
    param.theta0 = [pi;pi;0;0];        % Down-Down
end
% Target position
condn = 1;  % For Target position
switch condn
    case 1                             % Up-Up
        param.thetaT = [0;0;0;0];
        A = param.A_uu;
        B = param.B_uu;
    case 2                             % Down-Up
        param.thetaT = [pi;0;0;0];
        A = param.A_du;
        B = param.B_du;
    case 3                             % Down-Down (Safety-Catch)
        param.thetaT = [pi;pi;0;0];
        A = param.A_dd;
        B = param.B_dd;
end

C = [1,0,0,0];             % Measuring only theta1 for integrator purposes
D = [];
% Continuous-time system to Discrete-time system
sys_cont = ss(A,B,C,D);
sys = c2d(sys_cont,param.Ts);
% Initial and Target positions figure
plotfig(param);
%% Controller - Swing-Up + LQR stabilization

% Swing-Up tuning parameters (GA tuned)
param.Kp = 4.55;   % 5.5
param.Kd = 0.4;    % 0.5
param.Ke = 0.8;    % 1.0

% LQR or LQi for tracking
lqr_ = 1;
lqi_ = 0;

Q  = blkdiag(294,74,8.8,0.8);
R  = 1e3;
Qint = 530;
F  = -dlqr(sys.A,sys.B,Q,R)
if tracking
    % Switching controllers and ref
    track = 1;
    ref_track = 1;
    stab = 0;
    ref_stab = 0;
    Qi = blkdiag(Q,Qint);
    Fi = -lqi(sys,Qi,R)
else
    % Switching controllers and ref
    track = 0;
    ref_track = 0;
    stab = 1;
    ref_stab = 1;
    
    Fi = zeros(1,size(A,1)+1)
end

simout = sim('ADIP_sim');
data = simout.data;
N = size(simout.tout,1);

% % MATLAB implementation
% init_t=0; final_t=10; dt=0.005;
% N = (final_t-init_t)/dt;.28
% t_span = linspace(init_t,final_t,N);
% parameters = [param.m_arm,param.m_pend,param.m_hinge,param.l_pivot,...
%     param.l_pend,param.g,param.Jarm,param.Jpend,param.Jl,param.Jhinge,...
%     param.C_arm,param.C_pend param.Kp param.Kd param.Ke];
% init_condn = [theta0' param.thetaT' parameters condn]';
% tic
% [t,Y] = ode45(@Controller,t_span,init_condn);
% time_LQR = toc
%
% % Plot
% figure(3)
% plot(t_span,(Y(:,1))*180/pi,'r',t_span,(Y(:,2))*180/pi,'k',t_span,...
%     180*ones(size(Y,1),1),'b--')
% legend('theta1','theta2')
% grid on
% data = Y;
%% Animation
close all;
figure; hold on;
px1_ref = param.l_pivot*sin(param.rmax);
px2_ref = px1_ref + param.l_pend*sin(0);
py1_ref = param.l_pivot*cos(param.rmax);
py2_ref = py1_ref  + param.l_pend*cos(0);
plot([0 px1_ref],[0 py1_ref],'k--',px1_ref,py1_ref,'ro',[px1_ref px2_ref],...
    [py1_ref py2_ref],'b--',[0 -px1_ref],[0 py1_ref],'k--',...
    -px1_ref,py1_ref,'ro',[-px1_ref -px2_ref],[py1_ref py2_ref],'b--',...
    'LineWidth',1.5)
for i=1:N-1
    if(mod(i,10)==1)
        clf;
        theta1=data(i,1);
        theta2=data(i,2);
        px1 = param.l_pivot*sin(theta1);
        py1 = param.l_pivot*cos(theta1);
        px2 = px1+param.l_pend*sin(theta2);
        py2 = py1+param.l_pend*cos(theta2);
        plot(0,0,'r^',[0 px1],[0 py1],'k-',px1,py1,'ro',...
            [px1 px2],[py1 py2],'b-','Linewidth',3);
        axis([-0.40 0.40 -0.40 0.40]);
        xlabel('\bf{m}');
        ylabel('\bf{m}');
        
        pause(0.005);
        
    end
end
%% Plots
tspan = 0:param.Ts:param.Tsim;

ccolors = get(gca,'colororder');
ccolors_valid = [ccolors(1,:)-[0 0.2 0.2];ccolors(2,:)-[0.1 0.2 0.09];ccolors(3,:)-[0.1 0.2 0.09]];

% theta1 and theta2 plot
clear ph
figure,box on
for i = 1:2
    ph(i) = plot(tspan,simout.data(:,i),'-','Color',ccolors(i,:),'LineWidth',4);hold on
end
xlim([0 (length(tspan)-2900)*param.Ts]),
ylim([-0.1 3.7])
set(gca,'YTick',0:pi/6:pi)
set(gca,'YtickLabel',{'0°','30°','60°','90°','120°','150°','180°'});
title('Time response of \bf{\phi_i}', 'FontSize', 30, 'FontWeight', 'bold')
xlabel('{Time}','FontSize',30)
ylabel('\bf{\phi_i} (degree)','FontSize',30)
legend([ph(1) ph(2)],{' \bf{\phi_{arm}}',' \bf{\phi_{pend}}'})
grid on
set(gca,'LineWidth',1, 'FontSize',30,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')

%%
% Etilda plot
clear ph
figure,box on
ph1 = plot(tspan,simout.Etilda,'-','Color',ccolors(1,:),'LineWidth',4);
xlim([0 (length(tspan)-3000)*param.Ts]),
ylim([-0.7 0.08])
title('Time response of \bf{E - E_{top}}', 'FontSize', 50, 'FontWeight', 'bold')
xlabel('\bf{Time}','FontSize',50)
ylabel('\bf{E - E_{top}}','FontSize',50)
set(gca,'YTick',-0.75:0.25:0)
set(gca,'YtickLabel',{'-0.75','-0.5','-0.25','0'});
grid on
set(gca,'LineWidth',1, 'FontSize',50,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
%%
% Lyapunov function graph
clear ph
figure,box on
ph1 = plot(tspan,simout.Lyapunov,'-','Color',ccolors(1,:),'LineWidth',4);
xlim([0 (length(tspan)-3000)*param.Ts]),
ylim([-0.15 25])
title('Time response of Lyapunov function \bf{V}', 'FontSize', 50, 'FontWeight', 'bold')
xlabel('{Time}','FontSize',50)
ylabel('\bf{V} ','FontSize',50)
grid on
set(gca,'LineWidth',1, 'FontSize',50,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')

%%
print('-depsc2', '-loose', '-cmyk', 'Etilda.eps');