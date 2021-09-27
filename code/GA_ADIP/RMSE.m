function [rmse] = RMSE(xhat,x)

xhat = xhat(:,1:2);
x = x(:,1:2);
error = xhat(:)-x(:);
sq_error = (error).^2;
mean_sq_error = mean(sq_error);
rmse = sqrt(mean_sq_error)*180/pi;
