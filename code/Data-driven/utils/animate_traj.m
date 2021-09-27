function y = animate_traj(x1,x2,param)
% NOTE: Change the references for x1 and x2 accordingly.
r1 = 45*pi/180;
r2 = 60*pi/180;
tspan = 0:param.Ts:param.Tsim;
% Positions for model defined by x1
px1 = param.l_pivot*sin(x1(:,1));
py1 = param.l_pivot*cos(x1(:,1));
px2 = px1+param.l_pend*sin(x1(:,2));
py2 = py1+param.l_pend*cos(x1(:,2));

% Positions for model defined by x2
pxK1 = param.l_pivot*sin(x2(:,1));
pyK1 = param.l_pivot*cos(x2(:,1));
pxK2 = pxK1+param.l_pend*sin(x2(:,2));
pyK2 = pyK1+param.l_pend*cos(x2(:,2));
%% Calculating joint coordinates for animation purposes
x = [px1, px2];
y = [py1, py2];
x_ = [pxK1, pxK2];
y_ = [pyK1, pyK2];
%%
cc = [[0 0.4470 0.7410];[0.8500 0.3250 0.0980];...
    [0.9290 0.6940 0.1250];[0.4940 0.1840 0.5560]];
figure;
% Plot reference for x1
px1_ref = param.l_pivot*sin(r1);
px2_ref = px1_ref + param.l_pend*sin(0);
py1_ref = param.l_pivot*cos(r1);
py2_ref = py1_ref  + param.l_pend*cos(0);
hh1_ref = plot([0, px1_ref;px1_ref, px2_ref], [0, py1_ref;py1_ref, py2_ref],...
    [0, -px1_ref;-px1_ref, -px2_ref], [0, py1_ref;py1_ref, py2_ref]);
set(hh1_ref, {'color'}, {cc(1,:);cc(2,:);cc(1,:);cc(2,:)});
set(hh1_ref, {'LineStyle','Linewidth'}, {'-.',2});

hold on
% Plot reference for x2
px11_ref = param.l_pivot*sin(r2);
px22_ref = px11_ref + param.l_pend*sin(0);
py11_ref = param.l_pivot*cos(r2);
py22_ref = py11_ref  + param.l_pend*cos(0);
hh2_ref = plot([0, px11_ref;px11_ref, px22_ref], [0, py11_ref;py11_ref, py22_ref], ...
    [0, -px11_ref;-px11_ref, -px22_ref], [0, py11_ref;py11_ref, py22_ref]);
set(hh2_ref, {'color'}, {cc(3,:);cc(4,:);cc(3,:);cc(4,:)});
set(hh2_ref, {'LineStyle','Linewidth'}, {'-.',2});

% Plot initial x1
hh1 = plot([0, x(1,1);x(1,1), x(1,2)], [0, y(1,1);y(1,1), y(1,2)], ...
    '.-', 'MarkerSize', 20, 'LineWidth', 2);
set(hh1, {'color'}, {cc(1,:);cc(2,:)});

% Plot initial x2
hh2 = plot([0, x_(1,1);x_(1,1), x_(1,2)], [0, y_(1,1);y_(1,1), y_(1,2)], ...
    '.-', 'MarkerSize', 20, 'LineWidth', 2);
set(hh2, {'color'}, {cc(3,:);cc(4,:)});
axis equal
axis([-0.20 0.20 -0.025 0.35]);
ht = title(sprintf('Time: %0.0f sec', tspan(1)));
xlabel('m','FontSize',10); ylabel('m','FontSize',10)
legend([hh1(1),hh2(1)],{' \bf{ State Obsv.}',' \bf{RBFs}'})
grid on
set(gca,'LineWidth',1, 'FontSize',10,'FontWeight','bold')
set(gcf,'Position',[500 500 800 600])
set(gcf,'PaperPositionMode','auto')

% Write video file. Change file name accordingly
v = VideoWriter('traj_MPC_DataRBF.avi');
open(v);
tic;     % start timing
for id = 1:length(tspan)
    if(mod(id,10)==1)
        % Update XData and YData
        set(hh1(1), 'XData', [0, x(id, 1)]  , 'YData', [0, y(id, 1)]);
        set(hh1(2), 'XData', x(id, :)       , 'YData', y(id, :));
        set(hh2(1), 'XData', [0, x_(id, 1)]  , 'YData', [0, y_(id, 1)]);
        set(hh2(2), 'XData', x_(id, :)       , 'YData', y_(id, :));
        set(ht, 'String', sprintf('Time: %0.0f sec', tspan(id)));
        %         drawnow;
        pause(0.005)
        % Get frame as an image
        frame = getframe(gcf);
        writeVideo(v,frame);
    end
end
close(v);
fprintf('Animation (Smart update): %0.0f sec\n', toc);