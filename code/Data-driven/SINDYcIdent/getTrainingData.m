% Get actual simulation data from a single trajectory.
x0 = param.theta0;
dt = 0.01;  % Time step
Tsim = 10;
tspan= 0:dt:Tsim;
t = tspan;
A = 0.1;
% Generate data for single trajectory
forcing_train = @(x,t) A*chirp(t,0.5,10,0.7,[],-90);
u1 = forcing_train(0,tspan);
param.Ts = dt;
simout = sim('SINDYcData');
data = simout.data;
x_train = data(:,1:4);
u_train = data(:,5);
dx_train = data(:,6:end);

% When we want to evaluate on a single trajectory
if ~Multi_traj
    x = x_train;
    u = u_train;
    dx = dx_train;
end
%% Show data
plotTrainingData