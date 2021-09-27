%% Swing-Up and LQR controller
function dy = Controller(~,X)
theta0 = X(1:4);
thetaT = X(5:8);
params = X(9:end-1);
condn = X(end);
Switching condition
if abs(thetaT(1)-theta0(1))<= 20*pi/180
    Q = blkdiag(1,0,0,0); R = 10;        % Tuning
    u = LQRController(theta0,thetaT,Q,R,condn);
else
    Kp = 5.5 ; Kd = 0.5; Ke = 1.0;            % Tuning
    u = swingupController(theta0,thetaT,params,Kp,Kd,Ke);
end
% u = 0 ;
dy = nl_dynamics(theta0,params,u);