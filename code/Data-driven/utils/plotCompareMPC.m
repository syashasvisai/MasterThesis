function y = plotCompareMPC(x1,x2,x4,tspan,dt)
% x1 = local MPC
% x2 = KMPC1
% x3 = KMPC2
% x4 = Ref
clear ph
figure,box on
ccolors = get(gca,'colororder');
ccolors_valid = [ccolors(1,:)-[0 0.2 0.2];ccolors(2,:)-[0.1 0.2 0.09];ccolors(3,:)-[0.1 0.2 0.09]];
% Plot MPC results
for i = 1:2
    ph(i) = plot(tspan,x1(:,i),'-','Color',ccolors(i,:),'LineWidth',3); hold on
end
% Plot KMPC results
for i = 1:2
    ph(2+i) = plot(tspan,x2(:,i),'--','Color',ccolors_valid(i,:),'LineWidth',4);
end
% % Plot KMPC results
% for i = 1:2
%     ph(4+i) = plot(tspan,x3(:,i),'--','Color',ccolors_valid(end,:),'LineWidth',4);
% end
% Plot Ref
for i = 1:2
    ph(6+i) = plot(tspan,x4(:,i),'--','Color',ccolors_valid(i,:),'LineWidth',1);
end

xlim([0 (length(tspan)-1)*dt]),
x1 = x1(:,1:2); x2 = x2(:,1:2); 
% x3 = x3(:,1:2);
ylim([min([x1(:);x2(:)])-0.1 max([x1(:); x2(:)])+.1])
% ylim([min([x1(:);x2(:); x3(:)])-0.05 max([x1(:); x2(:); x3(:)])+.08])
title('Comparison of Local and Koopman MPC', 'FontSize', 30, 'FontWeight', 'bold')
xlabel('\bf{Time (s)}','FontSize',30)
ylabel('\bf{\phi_i} (degree)','FontSize',30)
grid on
legend([ph(1) ph(3) ph(7)],{' \bf{Local MPC}',' \bf{KMPC 1}',' \bf{Ref}'})
% legend([ph(1) ph(3) ph(5) ph(7)],{'  \bf{Local MPC}',' \bf{KMPC 1}',' \bf{KMPC 2}','  \bf{Ref}'})
set(gca,'YTick',-pi/4:pi/6:pi/4)
set(gca,'YtickLabel',{'-45°','-15°','15°','45°'});
set(gca,'LineWidth',1, 'FontSize',30,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
end