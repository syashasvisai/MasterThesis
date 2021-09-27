% Visualize validation results of system identification
%% Show training and prediction
clear ph
figure,box on, hold on, 
ccolors = get(gca,'colororder');
xSINDYc = xSINDYc(:,1:2);
x_val = x_val(:,1:2);
x_train = x_train(:,1:2);
plot([tval(1),tval(1)],[min([x_train(:);xSINDYc(:)]) max([x_train(:);x_val(:);xSINDYc(:)])],':','Color',[0.4,0.4,0.4],'LineWidth',1.5)
ylim([min([x_train(:);x_val(:);xSINDYc(:)]-0.05) max([x_train(:); x_val(:);xSINDYc(:)]+0.05)])
plot(t,x_train(:,1),'Color',ccolors(1,:),'LineWidth',4);
plot(t,x_train(:,2),'Color',ccolors(2,:),'LineWidth',4);
ph(1) = plot([t';tval'],[x_train(:,1);x_val(:,1)],'Color',ccolors(1,:),'LineWidth',4);
ph(2) = plot([t';tval'],[x_train(:,2);x_val(:,2)],'Color',ccolors(2,:),'LineWidth',4);
try
    ph(4) = plot(tval,xSINDYc(:,1),'-.','Color',ccolors(1,:)-[0 0.2 0.2],'LineWidth',4);
    ph(5) = plot(tval,xSINDYc(:,2),'-.','Color',ccolors(2,:)-[0.1 0.2 0.09],'LineWidth',4);
catch
    ph(4) = plot(tval(1:size(xSINDYc,1)),xSINDYc(:,1),'-.','Color',ccolors(1,:)-[0 0.2 0.2],'LineWidth',4);
    ph(5) = plot(tval(1:size(xSINDYc,1)),xSINDYc(:,2),'-.','Color',ccolors(2,:)-[0.1 0.2 0.09],'LineWidth',4);
end
grid on
xlim([0 tval(end)])
xlabel('\bf{Time} (s)','FontSize',30)
ylabel('\bf{\phi_i} (degree)','FontSize',30)
set(gca,'YTick',2*pi/3:pi/6:4*pi/3)
set(gca,'YtickLabel',{'120°','150°','180°','210°','240°'});
t1 = text(tval(1)-5,max([x_train(:);x_val(:);xSINDYc(:)])-0.15,'Training', 'FontSize',30,'FontWeight', 'bold');
t2 = text(5+tval(1),max([x_train(:);x_val(:);xSINDYc(:)])-0.15,'Validation', 'FontSize',30,'FontWeight', 'bold');
lh = legend(ph([1,4]),' True',' SINDYc','Location','northeast');
% lh.Position = [lh.Position(1)-0.62,lh.Position(2)+0.01,lh.Position(3:4)];

set(gca,'LineWidth',1, 'FontSize',30,'FontWeight','bold')
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
%% Actuation signal
clear ph
figure,box on, hold on, 
ccolors = get(gca,'colororder');
plot([tval(1),tval(1)],[min([u_train;u_val]) max([u_train;u_val])],':','Color',[0.4,0.4,0.4],'LineWidth',1.5)
plot(t,u_train,'-b','LineWidth',4);
plot(tval,u_val,'-r','LineWidth',4);
text(tval(1)-6,0.1,'Training', 'FontSize',30)
text(5+tval(1),0.1,'Validation', 'FontSize',30)
grid on
ylim([min([u_train;u_val])+0.05*min([u_train;u_val]) max([u_train;u_val])+0.05*max([u_train;u_val])])
xlim([0 tval(end)])
xlabel('\bf{Time} (s)','FontSize',30)
ylabel('\bf{Input} (Nm)', 'FontSize',30)
set(gca,'YTick',-0.1:0.05:0.1)
set(gca,'YtickLabel',{'-0.1','-0.05','0','0.05','0.1'});
set(gca,'LineWidth',1, 'FontSize',30)
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
%% Seperate plots if needed
clear ph
h = figure;
ccolors = get(gca,'colororder');
subplot(2,1,1), box on, hold on
plot([tval(1),tval(1)],[1 5],':','Color',[0.4,0.4,0.4],'LineWidth',4)
text(tval(1)-5,4.8,'Training', 'FontSize',30)
text(5+tval(1),4.8,'Validation', 'FontSize',30)
plot([t';tval'],[x_train(:,1);x_val(:,1)],'Color',[.4 .4 .4],'LineWidth',4);
try
    plot(tval,xSINDYc(:,1),'--','Color','r','LineWidth',4);
catch
    plot(tval(1:size(xSINDYc,1)),xSINDYc(:,1),'--','Color','r','LineWidth',4);
end
grid on
ylim([1 5])
xlabel('\bf{Time} (s)','FontSize',30)
ylabel('\bf{\phi_1} (degree)','FontSize',30)
set(gca,'FontSize',13)
subplot(2,1,2), box on, hold on
plot([tval(1) tval(1)],[1 5],':','Color',[0.4,0.4,0.4],'LineWidth',4)
plot([t';tval'],[x_train(:,2);x_val(:,2)],'Color',[.4 .4 .4],'LineWidth',4);
text(tval(1)-5,4.8,'Training', 'FontSize',30)
text(5+tval(1),4.8,'Validation', 'FontSize',30)
try
    plot(tval,xSINDYc(:,2),'--','Color','r','LineWidth',4);
catch
    plot(tval(1:size(xSINDYc,1)),xSINDYc(:,2),'--','Color','r','LineWidth',4);
end
grid on
ylim([1 5])
xlabel('\bf{Time} (s)','FontSize',30)
ylabel('\bf{\phi_2} (degree)','FontSize',30)
set(gca,'FontSize',13)
