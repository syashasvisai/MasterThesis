%% Plots
tspan = 0:param.Ts:param.Tsim;

ccolors = get(gca,'colororder');
ccolors_valid = [ccolors(1,:)-[0 0.2 0.2];ccolors(2,:)-[0.1 0.2 0.09];ccolors(3,:)-[0.1 0.2 0.09]];

% theta1 and theta2 plot
clear ph
figure,box on
for i = 1:2
    ph(i) = plot(tspan,data(:,i),'-','Color',ccolors(i,:),'LineWidth',4);hold on
end
xlim([0 (length(tspan)-2900)*param.Ts]),
ylim([-0.5 5])
set(gca,'YTick',0:pi/6:3*pi/2)
set(gca,'YtickLabel',{'0°','30°','60°','90°','120°','150°','180°','210°','240°','270°'});
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
ph1 = plot(tspan,E_tilda,'-','Color',ccolors(1,:),'LineWidth',4);
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