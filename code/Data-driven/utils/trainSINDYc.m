% This file uses the data to generate the sparse matrix through the SINDy
% algorithm.
% if Discrete
%     xt = x(1:end-1,:);
%     dxt = x(2:end,:);  
%     xaug = [xt u(1:end-1)];
%     dxt(:,size(x,2)+1) = 0*dxt(:,size(x,2));
% else
    clear xt dxt
    xt = x(1:end-1,:);
    dxt = dx(1:end-1,:);  
    xaug = [xt u(1:end-1)];
    dxt(:,size(x,2)+1) = 0*dxt(:,size(x,2));
% end

n = size(dxt,2);

% Sparse regression
clear Theta Xi
Theta = poolData(xaug,n,polyorder,usesine,polysine);
m = size(Theta,2);

Xi = sparsifyDynamics(Theta,dxt,lambda,n-1);

str_vars = {'t1','t2','t1d','t2d','u'};    

Epsilon = poolDataLIST(str_vars,Xi,n,polyorder,usesine,polysine)