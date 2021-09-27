% Distribution of Initial conditions
rmax = 35*pi/180; % reference
theta1 = linspace(rmax/2,-rmax/2,3);  %[-20 20]
theta2 = linspace(2*pi/180,-2*pi/180,3);    %[-2,2]
theta1d = linspace(-0.25,0.25,3);
theta2d = linspace(-0.25,0.25,3);
dist_in = 1; dist_out_1 = 0; dist_out_2 = 0;
% Tuning Parameters
Q = blkdiag(100,0,0.65,1);
R = 0.17;
% Q = blkdiag(300,0.3,0.15,0.78); % Tuning params for data model from 5 deg
% R = 1.2;
F = -dlqr(sys.A,sys.B,Q,R)
Fi = -lqi(sys,blkdiag(Q,788),R)
% Fi = -lqi(sys,blkdiag(Q,726),R)
sys_cl = ss(sys.A+sys.B*F,sys.B,sys.C,sys.D,param.Ts);

% Generate Data
m = length(theta1);
j = length(theta1d);
x = []; theta0 = []; u = []; dx = [];
for ii= 1:m
    for jj = 1:m
        for kk = 1:j
            for ll = 1:j
                param.theta0 = [theta1(ii),theta2(jj),theta1d(kk),theta2d(ll)];
                plotfig(param);
                grid on
                param.theta0
                simout = sim('sim_dataGenerator');
                data = simout.data;
                ref = simout.Ref;
                x = [x;data(:,1:4)];
                u = [u;data(:,5)];
                dx = [dx; data(:,6:end)];
                theta0 = [theta0; param.theta0'];
            end
        end
    end
end