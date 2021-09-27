function [rows,K] = subsequent_iterV3(Xp,PsiX,PsiXp,iter,term_TOL,lambda)
%SUBSEQUENT_ITERV3 Summary of this function goes here
%   Detailed explanation goes here
if nargin < 4
    iter = 10;
end
if length(iter) == 2
    iter2 = iter(2);
    iter = iter(1);
elseif length(iter) == 1
    iter2 = iter;
else
    error('iter must be integer or vector of 2 integers')
end
if nargin < 5
    term_TOL = 0; % default is no tolerance
end
if nargin < 6
    lambda = 0.05; % default is recommended value from SINDy paper
end

% get initial rows
I = ismember(PsiXp,Xp,'row');
idx = 1:length(I);
rows = idx(I==1);
if length(rows) == size(Xp,1)
    P = PsiXp(rows,:);
else
    P = Xp;
end
if nargout > 1
    K = zeros(size(PsiX,1)*[1 1]);
    ii = 1;
end
for i = 1:iter
    fprintf('\n iteration %d \n',i);
    disp('in sequential_thresh:')
    Xi = SINDy(PsiX,P,lambda,iter2,term_TOL);
    if nargout > 1
        K(ii:ii+size(Xi,1)-1,:) = Xi;
        ii = ii+size(Xi,1);
    end
    I = ~(sum(Xi==0,1)==size(Xi,1));
    nonzerorows = idx(I==1);
    newrows = nonzerorows(~ismember(nonzerorows,rows));
    fprintf('\n %d newly identified observables\n',length(newrows));
    rows = [rows,newrows];
    if isempty(newrows)
        fprintf('\n update does not select any new entries.')  
        break
    else
        P = PsiXp(newrows,:);
    end

end
fprintf(' \n stop at iteration (%d/%d) \n',i,iter)
if nargout > 1
    K = K(1:length(rows),rows);
end
end
function Xi = SINDy(X,Y,lambda,iter,term_TOL)
%     lambda = 0.05;
%     iter = 10;
%     term_TOL = 0;
    verbose = true;
    [Xi,~] = sequential_thresh(X,Y,lambda,iter,term_TOL,verbose);
   
end