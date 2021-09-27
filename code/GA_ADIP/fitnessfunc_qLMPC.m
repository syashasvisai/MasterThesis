function [cost] = fitnessfunc_qLMPC(x)


tune = [x(1) x(2) x(3) x(4) x(5) x(6)]
set_param('GA_qLMPC_sim/qLMPC/vars', 'Value', mat2str(tune))

try
    sim('GA_qLMPC_sim');
    
catch e 
    disp(e)
    cost = 10^10
    return
end

u = data(:,end);

cost = RMSE(data,ref)
% cost = RMSE_swing(data,ref)  

if max(u) < 2.5
    fprintf('Input Ok');
end

end

