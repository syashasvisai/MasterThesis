% This file returns the data-driven approximation of the linear matrices.
% The data is lifted by polynomials/sine functions/ polynomial +sine
% functions. The controller is LQi.

[AK,BK,CK,nObsv] = linearizeData(x,u,param);

n = param.n; polyorder = param.polyorder; usesine = param.usesine; polysine = param.polysine;
% save KO35.mat AK BK n polyorder usesine polysine
DK = [];
CKO = [1,zeros(1,size(AK,1)-1)]; % We take only one output here for LQi weighting
sysk = ss(AK,BK,CKO,DK,param.Ts);

% LQR
% augmenting with zeros for rest of the states
Qaug = blkdiag(Q,zeros(size(AK,1)-4));
% LQR feedback
Fd = -dlqr(AK,BK,Qaug,R)

% LQi feedback
Qi = blkdiag(Qaug,Qint);
Fi = -lqi(sysk,Qi,R)


nObsv
fprintf('Check if the number of observables match the augmented state in the simulink file')
fprintf('\n Press any key to continue')
pause
% Record Data
data_disc = sim('EDMD_sim');
tD = data_disc.tout;
xK = data_disc.data(:,1:4);
uK = data_disc.data(:,5);
theta1 = xK(:,1);
theta2 = xK(:,2);