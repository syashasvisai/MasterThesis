function [param,options] = ga_params_qLMPC(param)
%% Options for GA
options = optimoptions('ga');
options.PopulationSize = 10;
options.MaxGenerations = 5;
% options.OutputFcn = @myfun;
param.Ts = 0.005;
param.Tsim = 17;
param.numOfParameters = 6; % [q11,q22,q33,q44,r,p]
param.lb = [1e1;1;0;0;1e-2;1];
param.ub = [3e3;3e3;1e2;1;5e2;3e3];
% 
% for 5ms
param.initialPopulation = [2.912072417464241e+03,1.967566356770604e+03,65.547789017755660,0.317099480060861,18.695391729392316,2.879272131589727e+03;...
    2233.62015938771,2674.85613270353,44.2645614818116,0.689420829610687,140.820497806325,1560.18965521104;...
    1884.43340565748,1777.43534813155,80.1622306315080,0.758819384742859,26.1288357682325,2219.42210073220];

% % for 10ms
% param.initialPopulation = [4.687379488263923e+02,83.553149423002680,1.747520742014967,0.750089983488543,0.263087110593212,6.791248748502789e+04;...
%     9.555758442618957e+02,38.277058062610040,3.003487348970456,0.964034991901461,8.638943523730713,9.937167599878030e+03;...
%     873.576048644807,68.7652362637466,6.13183106337416,0.955183839598853,1.89776367321712,639163.562298910;...
%     2.533584897013020e+03,66.059653387634700,8.972237448265580,0.924757001456557,0.010000000000000,4.998183782817065e+05;...
%     7849.57726866612,98.1751558778572,3.80417492091752,0.746942359108157,6.28306457222095,728761.298743157];

% %% Best genes (If they exist from previous optimizations)
% % Load Best genes if the file exists
% if exist('best_genes.DNT.mat','file')
%     load('best_genes.DNT.mat');
%     num_of_best_genes = size(best_genes,1);
%     param.initialPopulation(end - num_of_best_genes + 1:end, :) = best_genes;
% end

param.N = 40; %% THIS PARAMETER MUST BE CHANGED IN THE 'GA_qLMPC_sim/qLMPC/qLPVMPC' file also.
param.iterations = 1;
param.ulim = 2.5; % Actuator constraint (1.6 Nm Torque)
param.tspan = 0:param.Ts:param.Tsim;


if param.anticipatory_ref
    load ref60_5ms.mat
    ref = [ref60; ref60(end-param.N+1:end,:)];
    for i = 1:length(param.tspan)
        r = ref(i:i+param.N-1,:);
        rA(i,:) = reshape(r',[],1);
    end
    param.r = [param.tspan' rA]; % creates a input vector of N future steps of reference for every time instance.
    switch_rA = 1;
else
    param.r = [param.tspan' ones(size(param.tspan,2),1)];
    switch_rA = 0;
end

% Simulink model
param.ADIP_GA = 'GA_qLMPC_sim';

% Open and load the simulink file
open_system(param.ADIP_GA);
load_system(param.ADIP_GA);

set_param('GA_qLMPC_sim/qLMPC/Anticipatory','Value',mat2str(switch_rA));
% Parameters for the nonlinear model
param.parameters = [param.m_arm param.m_pend param.m_hinge param.l_pivot ...
    param.l_pend param.g param.Jarm param.Jpend param.Jl param.Jhinge...
    param.C_arm param.C_pend];
set_param('GA_qLMPC_sim/qLMPC/Parameters','Value', mat2str(param.parameters));




Xko_init = kron(ones(param.N,1),zeros(4,1));

set_param('GA_qLMPC_sim/qLMPC/Xko_init','Value', mat2str(Xko_init));
set_param('GA_qLMPC_sim/qLMPC/Constant','Value', mat2str(zeros(2*param.N,1)));

% Assign parameters to the nonlinear ADIP model
set_param('GA_qLMPC_sim/ADIP/Parameters','Value', mat2str(param.parameters));

% Assign the initial conditions vector
set_param('GA_qLMPC_sim/ADIP/InitCondn', 'Value', mat2str(param.theta0));
end