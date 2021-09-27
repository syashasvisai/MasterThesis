function y = plotCompareSINDYc(x1,x2,Nvar,tspan,dt)
ModelName = ' \bf{SINDYc}';
clear ph
figure,box on
ccolors = get(gca,'colororder');
ccolors_valid = [ccolors(1,:)-[0 0.2 0.2];ccolors(2,:)-[0.1 0.2 0.09];ccolors(3,:)-[0.1 0.2 0.09]];
for i = 1:Nvar-2
    ph(i) = plot(tspan,x1(:,i),'-','Color',ccolors(i,:),'LineWidth',3); hold on
end
try
    for i = 1:Nvar-2
    ph(2+i) = plot(tspan,x2(:,i),'--','Color',ccolors_valid(i,:),'LineWidth',4);
    end
catch
    for i = 1:Nvar-2
    ph(2+i) = plot(tspan(1:size(x2,1)),x2(:,i),'--','Color',ccolors_valid(i,:),'LineWidth',4);
    end
end
xlim([0 (length(tspan)-1)*dt]), 
x1 = x1(:,1:2); x2 = x2(:,1:2);
ylim([min([x1(:);x2(:)])-0.05 max([x1(:); x2(:)])+.08])
title('Comparison of true and SINDYc identified models on validation data', 'FontSize', 30, 'FontWeight', 'bold')
xlabel('\bf{Time} (s)','FontSize',30)
ylabel('\bf{\phi_i} (degree)','FontSize',30)
grid on
legend([ph(1) ph(3)],{' \bf{True}',' \bf{SINDYc}'})
% legend([ph(1) ph(3)],{'  \bf{Local MPC}',' \bf{KMPC 1}',' \bf{KMPC 2}','  \bf{Ref}'})
set(gca,'YTick',2*pi/3:pi/6:4*pi/3)
set(gca,'YtickLabel',{'120°','150°','180°','210°','240°'});
set(gca,'LineWidth',1, 'FontSize',30,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')

end