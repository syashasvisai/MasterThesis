%% Plots 
% Reference plot
tspan = 0:param.Ts:param.Tsim;
ccolors = get(gca,'colororder');
ccolors_valid = [ccolors(1,:)-[0 0.2 0.2];ccolors(2,:)-[0.1 0.2 0.09];ccolors(3,:)-[0.1 0.2 0.09]];
% Plot ref
figure; box on;
for i = 1:2
    ph(i) = plot(tspan,ref(:,i),'--','Color',ccolors(i,:),'LineWidth',4); hold on
end
% ph1 = plot(tspan,u(1:3401,:));
xlim([0 (length(tspan)-1)*param.Ts]),
ylim([min(ref(:,1))-0.1 max(ref(:,1))+.1])
title('Reference trajectories of \bf{\phi_i}', 'FontSize', 50, 'FontWeight', 'bold')
xlabel('\bf{Time (s)}','FontSize',50)
ylabel('\bf{\phi_i} (degree)','FontSize',50)
grid on
legend([ph(1) ph(2)],{'  \bf{\phi_{1(ref)}}',' \bf{\phi_{2(ref)}}'})
set(gca,'YTick',-pi/4:pi/6:pi/4)
set(gca,'YtickLabel',{'-45°','-15°','15°','45°'});
set(gca,'LineWidth',1, 'FontSize',50,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
%%
% Input plot
% Plot ref
figure; box on;
ph1 = plot(tspan(3:3401),u(3:3401,:),'-','Color',ccolors(i,:),'LineWidth',4);
xlim([0 (length(tspan)-1)*param.Ts]),
ylim([min(u(3:3401,1))-0.01 max(u(3:3401,1))+.01])
title('Input signal', 'FontSize', 50, 'FontWeight', 'bold')
xlabel('\bf{Time (s)}','FontSize',50)
ylabel('\bf{Input} (Nm)','FontSize',50)
grid on
set(gca,'LineWidth',1, 'FontSize',50,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
%%
print('-depsc2', '-loose', '-cmyk', 'InitCondn.eps');