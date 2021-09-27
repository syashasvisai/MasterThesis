function [rmse] = RMSE(xhat,x)
% relative rmse
error = xhat(:,1)-x(:,1);
sq_error = (error).^2;
mean_sq_error = mean(sq_error);
rmse = 100*sqrt(mean_sq_error)/sqrt(mean(x(:,1).^2));
