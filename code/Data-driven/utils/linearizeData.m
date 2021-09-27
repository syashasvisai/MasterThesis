function [A,B,C,nObsv] = linearizeData(x,u,param)

% This function returns a linear operator (approximated Koopman operator)
% through EDMD

% Data
X1 = x(1:end-1,:); 
X2 = x(2:end,:);
u  = u(1:end-1,:);
tic
% Observables matrix
X1 = poolData_EDMD(X1,param.n,param.polyorder,param.usesine,param.polysine);
X2 = poolData_EDMD(X2,param.n,param.polyorder,param.usesine,param.polysine);

% Augment the input space with inputs & Transpose the matrices for EDMD
Omega = [X1 u]';
X2 = X2';

% DMD/EDMD
A1=X2*Omega';
A2=Omega*Omega';
K=A1*pinv(A2); % Linear approximation - Koopman operator with inputs 

A = K(1:size(X1,2),1:size(X1,2));
B = K(1:size(A,1),end);
toc 
C = [eye(param.n) zeros(param.n,size(X1,2)-param.n)];
nObsv = size(A,1);
% Residual
fprintf( 'Regression residual %f \n', norm(X2 - A*X1' - B*u','fro') / norm(X2,'fro') );
end