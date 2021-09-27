clear ph

[Jvals1] = evalCostFun(xt',ut',Q,R,ref'); %LQi
[Jvals2] = evalCostFun(xK',uK',Q,R,ref'); % KLQi
% [Jvalsx] = evalCostFun(xKx',uKx',Q,R,ref'); % KLQi from extended matrices 
[Jvals3] = evalCostFun(XX_loc(:,2:end),UU_loc,Q,R,ref45'); % local MPC
[Jvals4] = evalCostFun(XX_koop1(:,2:end),UU_koop1,Q,R,ref45'); % KMPC1
[Jvals5] = evalCostFun(XX_koop2(:,2:end),UU_koop2,Q,R,ref45'); % KMPC2
figure,box on
ccolors = get(gca,'colororder');
ccolors_valid = [ccolors(1,:)-[0 0.2 0.2];ccolors(2,:)-[0.1 0.2 0.09];ccolors(3,:)-[0.1 0.2 0.09]];
ph(1)= plot(t,cumsum(Jvals1),'-','Color',ccolors(1,:),'LineWidth',4); hold on,
ph(2)= plot(tD,cumsum(Jvals2),'--','Color',ccolors(1,:),'LineWidth',4);
% ph(3)= plot(tD,cumsum(Jvalsx),'--','Color',ccolors(2,:),'LineWidth',4);
ph(3)= plot(t(2:end),cumsum(Jvals3),':r','LineWidth',3);
ph(4)= plot(t(2:end),cumsum(Jvals4),':b','LineWidth',3);
ph(5)= plot(t(2:end),cumsum(Jvals5),':m','LineWidth',3);
% 
xlim([0 (length(t)-1)*param.Ts]),
title('Comparison of Cost J', 'FontSize', 30, 'FontWeight', 'bold')
xlabel('\bf{Time (s)}','FontSize',30)
ylabel('\bf{J}','FontSize',30)
grid on
% legend([ph(1) ph(2)],{' \bf{LQi}',' \bf{KLQi}', ' \bf{KLQi}'})
% legend([ph(1) ph(2) ph(3)],{' \bf{LQi}',' \bf{KLQi_1}', ' \bf{KLQi_2}'})
legend([ph(1) ph(2) ph(3) ph(4) ph(5)],{' \bf{LQi}',' \bf{KLQi}',' \bf{MPC}',' \bf{KMPC1}',' \bf{KMPC2}'})
legend('Location', 'Northwest')
set(gca,'YTick',0:100:400)
set(gca,'YtickLabel',{'0','100','200','300','400'});
set(gca,'LineWidth',1, 'FontSize',30,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
%%
% print('-depsc2', '-loose', '-cmyk', 'CostsLQi.eps');