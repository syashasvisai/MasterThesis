function y = plotCompareMPC2(x1,x2,x3,x4,tspan,dt)
% x1 = KMPC1
% x2 = KMPC2
% x3 = Ref45
% x4 = Ref60
clear ph
figure,box on
ccolors = get(gca,'colororder');
ccolors_valid = [ccolors(1,:)-[0 0.2 0.2];ccolors(2,:)-[0.1 0.2 0.09];ccolors(3,:)-[0.1 0.2 0.09];ccolors(2,:)-[0.1 0.2 0.09]];
% Plot KMPC1 results
for i = 1:2
    ph(i) = plot(tspan,x1(:,i),'-','Color',ccolors(i,:),'LineWidth',4); hold on
end
% Plot KMPC2 results
for i = 1:2
    ph(2+i) = plot(tspan,x2(:,i),'-','Color',ccolors_valid(2+i,:),'LineWidth',4);
end
% Plot Ref1
for i = 1:2
    ph(4+i) = plot(tspan,x3(:,i),'--','Color',ccolors_valid(i,:),'LineWidth',1);
end
% Plot Ref2
for i = 1:2
    ph(6+i) = plot(tspan,x4(:,i),'--','Color',ccolors_valid(2+i,:),'LineWidth',1);
end
% % Plot KMPC3 results
% for i = 1:1
%     ph(5) = plot(tspan,x5(:,i),'-','Color',ccolors_valid(3,:),'LineWidth',4);
% end
% % Plot Ref3
% for i = 1:1
%     ph(6) = plot(tspan,x6(:,i),'--','Color',ccolors_valid(3,:),'LineWidth',1);
% end
xlim([0 (length(tspan)-1)*dt]),
x1 = x1(:,1:2); x2 = x2(:,1:2);
ylim([min([x1(:);x2(:)])-0.05 max([x1(:); x2(:)])+.08])
title('Comparison of KMPC with different observables', 'FontSize', 30, 'FontWeight', 'bold')
xlabel('\bf{Time}','FontSize',30)
ylabel('\bf{\phi_i} (degree)','FontSize',30)
grid on
legend([ph(1) ph(3) ph(5) ph(7)],{' \bf{KMPC1}',' \bf{KMPC2}',' \bf{Ref(45°)}',' \bf{Ref(60°)}'})
set(gca,'YTick',-pi/3:pi/12:pi/3)
set(gca,'YtickLabel',{'-60°','-45°','-30°','15°','0°','15°','30°','45°','60°'});
set(gca,'LineWidth',1, 'FontSize',30,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
end