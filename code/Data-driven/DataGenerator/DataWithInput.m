%% Data with input - Around the stable equillibrium. Random inputs, open loop

dt = param.Ts;  % Time step
tspan= 0:dt:param.Tsim;
t = tspan';
A = 0.1; % amplitude of chirp signal
forcing = @(x,t) A*chirp(t,0.5,10,0.7,[],-90);
u1 = forcing(0,tspan);
plot(u1)

% Data with just one initial condition
% data = sim('sim_dataGenerator');
% x = data.data(:,1:4);
% u = data.data(:,5);
% dx = data.data(:,6:end);

% Distribution of Initial conditions
theta1 = linspace(210*pi/180,180*pi/180,3);
theta2 = linspace(150*pi/180,180*pi/180,3);
theta1d = linspace(-1,1,3);
theta2d = linspace(-1,1,3);
% Amin = 0.1;
% Amax = 0.3;
% u = forcing(0,tspan);
% fmin = 0.1;
% fmax = 0.3;
% A = 0.1;

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
%                 Randomizing the frequencies and amplitude. This data did
%                 not work as well as the data with constant frequencies
%                 but varying amplitudes.
%                 rf = (fmax-fmin).*rand(3,1) + fmin;
%                 fmin = rf(1);
%                 fmax = rf(2);
%                 rA = (Amax-Amin).*rand(3,1) + Amin;
%                 forcing = @(x,t) A*chirp(t,fmin,10,fmax,[],-90);
%                 u1 = forcing(0,tspan);
%                 u1 = zeros(1,length(tspan));
                data = sim('sim_dataGenerator');
                x = [x;data.data(:,1:4)];
                u = [u;u1'];
                dx = [dx; data.data(:,6:end)];
                theta0 = [theta0; param.theta0'];
            end
        end
    end
end