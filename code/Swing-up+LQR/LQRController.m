%% Stabilizing controller
function u = LQRController(theta0,thetaT,Q,R,condn)
load('linear_matrices.mat')
switch condn
    case 1
         A = A_uu;
         B = B_uu;
    case 2
        A = A_du;
        B= B_du;
    case 3
        A = A_dd;
        B = B_dd;
end
F = -lqr(A,B,Q,R);
e = theta0 - thetaT; % (Actual - Reference)
u = F*e;
end