%% Function to plot the initial and final positions of the ADIP
function y = plotfig(param)
x_1 = param.l_pivot*sin(param.theta0(1));
y_1 = param.l_pivot*cos(param.theta0(1));
x_2 = x_1 + param.l_pend*sin(param.theta0(2));
y_2 = y_1 + param.l_pend*cos(param.theta0(2));

x_T1 = param.l_pivot*sin(param.thetaT(1));
y_T1 = param.l_pivot*cos(param.thetaT(1));
x_T2 = x_T1 + param.l_pend*sin(param.thetaT(2));
y_T2 = y_T1 + param.l_pend*cos(param.thetaT(2));

hold on
box on;
figure(1);
p = plot(0,0,'r^',[0 x_1],[0 y_1],'k-',x_1,y_1,'ro',[x_1 x_2],[y_1 y_2],...
    'b-',[0 x_T1],[0 y_T1],'k--',x_T1,y_T1,'ro',[x_T1 x_T2],[y_T1 y_T2],'b-.', 'LineWidth', 3);
axis([-0.4 0.4 -0.4 0.4]);
xlabel('m','FontSize',50)
ylabel('m','FontSize',50)
ylim([-0.01 0.4])
xlim([-0.1 0.1])
title('Initial conditions', 'FontSize', 50, 'FontWeight', 'bold');
legend([p(2) p(4)],' Arm',' Pendulum')
set(gca,'LineWidth',1, 'FontSize',50,'FontWeight','bold')

grid;

end