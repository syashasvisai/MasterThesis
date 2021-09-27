function [cost] = fitnessfunc_LQi(x,param)

% State Feedback gain Tuning matrices
Q = blkdiag(x(1),x(2),x(3),x(4));
R = x(5);
% For KO augmented states
if param.Koopman
    % augmenting with zeros for rest of the states
    Q = [Q zeros(size(Q,1),size(param.sys.A,1)-size(Q,1));...
    zeros(size(param.sys.A,1)-size(Q,1), size(param.sys.A,1))];
end
% Integral State Feedback tuning matrix Qi
Qi = blkdiag(Q,x(6));

try
    F = -dlqr(param.sys.A,param.sys.B,Q,R);
    Fi = -lqi(param.sys,Qi,R);
    set_param('GA_LQi_sim/Controller/LQR_Gain','Gain',mat2str(F));
    set_param('GA_LQi_sim/Controller/LQi_Gain','Gain',mat2str(Fi));
    data = sim('GA_LQi_sim');
catch e
    disp(e);
    cost = 10^10;
    return;
end

state = data.state(:,1:4);
ref = data.ThetaRef(:,1:4);
% extracting the states for each simulation
y1 = state(:,1);
y3 = state(:,3);
y1_ref = ref(:,1);
y3_ref = ref(:,3);
u = data.input;

ind = 1:1:length(y1); % we can 'sparsify' the calculation of costs if req.
cost = sum((y1(ind)-y1_ref(ind))'*(y1(ind)-y1_ref(ind))...
    +0.1*(y3(ind)-y3_ref(ind))'*(y3(ind)-y3_ref(ind)))

if u < 2.5
    fprintf('Input Ok');
end