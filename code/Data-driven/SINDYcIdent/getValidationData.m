% Get actual simulation data from this file.
A = 0.065;
forcing_val = @(x,t) A*chirp(t,0.9,10,0.9,[],-90);
u1 = forcing_val(0,tspan);
data = sim('SINDYcData');
x_val = data.data(:,1:4);
u_val = data.data(:,5);
%% Show data
figure;
plot(tspan,u_val)
xlabel('Time')
ylabel('Nm')
set(gca,'LineWidth',1, 'FontSize',14)
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
title('Input')
figure;
plot(t,x_val(:,1:2),'LineWidth',1.5)
xlabel('Time')
ylabel('Radians')
legend('theta1','theta2')
set(gca,'LineWidth',1, 'FontSize',14)
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
title('Validation data')