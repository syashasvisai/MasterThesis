function y = plotComparediffTraj_qLMPC(x1,x2,x3,x4,x5,x6,tspan,dt)
% x1 = KMPC - 3s
% x2 = KMPC - 1.5s
% x3 = KMPC - 1s
% x4 = ref - 3s
% x5 = ref - 1.5s
% x6 = ref - 1s
clear ph
figure,box on
ccolors = get(gca,'colororder');
ccolors_valid = [ccolors(1,:)-[0 0.2 0.2];ccolors(2,:)-[0.1 0.2 0.09];ccolors(3,:)-[0.1 0.2 0.09]];
% Plot KMPC 1 results
for i = 1:1
    ph(i) = plot(tspan,x1(:,i),'-','Color',ccolors(i,:),'LineWidth',3); hold on
end
% Plot KMPC 2 results
for i = 1:1
    ph(1+i) = plot(tspan,x2(:,i),'-','Color',ccolors_valid(i+1,:),'LineWidth',4);
end
% Plot KMPC 3 results
for i = 1:1
    ph(2+i) = plot(tspan,x3(:,i),'-','Color',ccolors_valid(i+2,:),'LineWidth',4);
end
% Plot Ref 1
for i = 1:1
    ph(3+i) = plot(tspan,x4(:,i),'--','Color',ccolors_valid(i,:),'LineWidth',1);
end
% Plot Ref 2
for i = 1:1
    ph(4+i) = plot(tspan,x5(:,i),'--','Color',ccolors_valid(i+1,:),'LineWidth',1);
end
% Plot Ref 3
for i = 1:1
    ph(5+i) = plot(tspan,x6(:,i),'--','Color',ccolors_valid(i+2,:),'LineWidth',1);
end

xlim([0 (length(tspan)-1)*dt]),
x1 = x1(:,1); 
ylim([min(x1(:))-0.1 max(x1(:))+.1])
title('Comparison of controller on different trajectories', 'FontSize', 30, 'FontWeight', 'bold')
xlabel('\bf{Time (s)}','FontSize',30)
ylabel('\bf{\phi_1} (degree)','FontSize',30)
grid on
legend([ph(1) ph(2) ph(3)],{' \bf{qLMPC}_1',' \bf{qLMPC}_2',' \bf{qLMPC}_3'})
% legend([ph(1) ph(2) ph(3) ph(4) ph(5) ph(6)],{' \bf{KMPC(60°)}',' \bf{KMPC(58°)}',' \bf{KMPC(54°)}',' \bf{Ref(45°)}',' \bf{Ref(45°)}',' \bf{Ref(45°)}'})
set(gca,'YTick',-pi/3:pi/6:pi/3)
set(gca,'XTick',0:1:17)
set(gca,'YtickLabel',{'-60°','-30°','0°','30°','60°'});
set(gca,'LineWidth',1, 'FontSize',30,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
end