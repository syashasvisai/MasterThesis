if Multi_traj
    figure;
    sgtitle('Training data','FontSize', 30, 'FontWeight', 'bold')
    for i = 1:length(tspan):length(x)
        subplot(2,1,1)
        plotData(tspan,x(i:i+length(tspan)-1,1))
        ylabel('\bf{\phi_1 (degree)}')
        set(gca,'YTick',pi/2:pi/4:3*pi/2)
        set(gca,'YtickLabel',{'90°','135°','180°','225°','270°'});
        ylim([pi/2-0.005 3*pi/2+.1])
        subplot(2,1,2)
        plotData(tspan,x(i:i+length(tspan)-1,2))
        ylabel('\bf{\phi_2 (degree)}')
        xlabel('\bf{Time (s)}')
        set(gca,'YTick',pi/2:pi/4:3*pi/2)
        set(gca,'YtickLabel',{'90°','135°','180°','225°','270°'});
        ylim([pi/2-0.5 3*pi/2+.6])        
    end
    figure;
    sgtitle('Input','FontSize', 30, 'FontWeight', 'bold')
    for i = 1:length(tspan):length(x)
        plotData(tspan,u(i:i+length(tspan)-1,1))
        ylabel('\bf{Input (Nm)}')
        xlabel('\bf{Time (s)}')
        set(gca,'YTick',-0.1:0.05:0.1)
        set(gca,'YtickLabel',{'-0.1','-0.05','0','0.05','0.1'});
        ylim([-0.1-0.01 0.1+.01])
    end
else 
    figure;
    sgtitle('Training data','FontSize', 30, 'FontWeight', 'bold')
    subplot(2,1,1)
    ylabel('\bf{\phi_1 (degree)}')
    plotData(tspan,x(:,1))
    set(gca,'YTick',pi/2:pi/4:3*pi/2)
    set(gca,'YtickLabel',{'90°','135°','180°','225°','270°'});
    subplot(2,1,2)
    plotData(tspan,x(:,2))
    ylabel('\bf{\phi_2 (degree)}')
    set(gca,'YTick',pi/2:pi/4:3*pi/2)
    set(gca,'YtickLabel',{'90°','135°','180°','225°','270°'});
    xlabel('\bf{Time (s)}')
    figure;
    sgtitle('Input','FontSize', 30, 'FontWeight', 'bold')
    plotData(tspan,u)
    ylabel('\bf{Input (Nm)}')
    xlabel('\bf{Time (s)}')
end

function y = plotData(tspan,x)
 plot(tspan,x,'LineWidth',1.5)
 hold on
 grid on
 set(gca,'LineWidth',1, 'FontSize',30,'FontWeight','bold')
 set(gcf,'Position',[100 100 300 200])
 set(gcf,'PaperPositionMode','auto')           
end

% print('-depsc2', '-loose', '-cmyk', 'TrainingData.eps');