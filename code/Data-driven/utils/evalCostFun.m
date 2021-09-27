function [Jvals] = evalCostFun(y,u,Q,R,yREF)
% y: NxM
try
M = size(y,2);
Jvals = zeros(length(y),1);
for k=1:M
    Jvals(k) = (y(:,k)-yREF(:,k))'*Q*(y(:,k)-yREF(:,k)) + u(:,k)'*R*u(:,k);
end
catch
    keyboard
end

