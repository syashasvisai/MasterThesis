function [Xi,record] = sequential_thresh(X,Y,lambda,iter,term_TOL,verbose)
%SEQUENTIAL_THRESH Summary of this function goes here
%   Detailed explanation goes here
if nargin < 4
    iter = 10;
end
if nargin < 5
    term_TOL = -1;
end
if nargin < 6
    verbose= false;
end

Xi = Y*pinv(X);
[n,m] = size(Xi);
record = cell(iter+1,1);
record{1}=Xi;

for k=1:iter

    % set all values in Xi lower then lambda to zero
    smallindexmask = (abs(Xi)<lambda);
    Xi(smallindexmask) = 0; 
    bigindexmask = ~smallindexmask;
    %disp(smallindexmask)
    for j=1:n
        Xi(j,bigindexmask(j,:)) = Y(j,:)*pinv(X(bigindexmask(j,:),:));
    end
       
    record{k+1} = Xi;
    
    termination_crit = norm((record{k}-record{k+1}),'fro');
    if verbose
        fprintf('\n \t iter: %d', k)
        fprintf('\n \t termination_crit: %d',termination_crit)
    end
    if termination_crit <= term_TOL
        fprintf('\n \t termination in iter %d due to similar matrices: %d <= %d \n',k,termination_crit,term_TOL)
        break
    end
end

