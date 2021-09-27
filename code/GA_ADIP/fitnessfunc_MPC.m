function [cost] = fitnessfunc_MPC(x)

% State Feedback gain Tuning matrices
Q = [x(1),x(2),x(3),x(4)]
R = x(5)

set_param('GA_MPC_sim/MPC/Q','Value', mat2str(Q));
set_param('GA_MPC_sim/MPC/R','Value', mat2str(R));

try
    data = sim('GA_MPC_sim');
    
catch e 
    disp(e)
    cost = 10^10
    return
end
state = data.data(:,1:4);
ref = data.data(:,5:8);
% extracting the states for each simulation
y1 = state(:,1);
y3 = state(:,3);
y1_ref = ref(:,1);
y3_ref = ref(:,3);
u = data.data(:,end);

% ind = 1:1:length(y1); % we can 'sparsify' the calculation of costs if req.
% cost = sum((y1(ind)-y1_ref(ind))'*(y1(ind)-y1_ref(ind))...
%     +0.1*(y3(ind)-y3_ref(ind))'*(y3(ind)-y3_ref(ind)))

if u < 2.5
    fprintf('Input Ok');
end


cost = RMSE(state,ref)
end

