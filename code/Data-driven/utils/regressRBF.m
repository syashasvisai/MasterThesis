function [Alift,Blift,Clift] = regressRBF(x,u,param)
%% Data
X = x(1:end-1,:)';
Y = x(2:end,:)';
U = u(1:end-1,:)';
%% Lifting
disp('Starting LIFTING')
% Observables matrix
Xlift = param.liftFun(X);
Ylift = param.liftFun(Y);
% Augment the input space with inputs & Transpose the matrices for EDMD
disp('Starting REGRESSION for A,B,C')

Omega = [Xlift;U];
% DMD - For low dimensional measurements
A1=Ylift*Omega';
A2=Omega*Omega';
K=A1*pinv(A2); % Linear approximation - Koopman operator with inputs 

Alift = K(1:param.Nlift,1:param.Nlift);
Blift = K(1:param.Nlift,param.Nlift+1:end);
Clift = blkdiag([eye(4) zeros(4,size(Alift,1)-4)]);
fprintf('Regression for A, B, C DONE \n');

% Residual
fprintf( 'Regression residual %f \n', norm(Ylift - Alift*Xlift - Blift*U,'fro') / norm(Ylift,'fro') );
end