function [dy,T,V] = lagrange(T,V)
load('symbolics.mat')
L = sum(T)-sum(V);
L = subs(L,{diff(theta1(t), t),diff(theta2(t),t)},{theta1_d,theta2_d});
% Equation of motion is given by: 
% d/dt(dL/dq_i) + fv_i*qdot_i - dL/dq_i = Q  (Rayleigh Damping)
% fv - generalized viscous damping co-efficient
% Q = generalized torques/forces. [u 0] - Torque input to the Arm

% First equation
dLdtheta1 = functionalDerivative(L,theta1);
dLdtheta1d = functionalDerivative(L,theta1_d);
ddtdLdtheta1d = diff(dLdtheta1d,t);
ddtdLdtheta1d = subs (ddtdLdtheta1d,...
    {diff(theta1(t), t), diff(theta2(t), t), diff(theta1_d(t),t), ...
    diff(theta2_d(t),t)},{theta1_d, theta2_d, theta1_dd, theta2_dd});  
eqn1 = simplify(ddtdLdtheta1d - dLdtheta1) + fv1*theta1_d - u

% Second equation
dLdtheta2 = functionalDerivative(L,theta2);
dLdtheta2d = functionalDerivative(L,theta2_d);
ddtdLdtheta2d = diff(dLdtheta2d,t);
ddtdLdtheta2d = subs (ddtdLdtheta2d,...
    {diff(theta1(t), t), diff(theta2(t), t), diff(theta1_d(t),t),...
    diff(theta2_d(t),t)},{theta1_d, theta2_d, theta1_dd, theta2_dd});  
eqn2 = simplify(ddtdLdtheta2d - dLdtheta2) + fv2*theta2_d

Sol = solve([eqn1 eqn2],[theta1_dd theta2_dd]);
Sol.theta1_dd = simplify(Sol.theta1_dd);
Sol.theta2_dd = simplify(Sol.theta2_dd);

syms y1 y2 y3 y4 dy1 dy2 dy3 dy4
dy1 = y3;
dy2 = y4;
dy3 = subs(Sol.theta1_dd,{theta1,theta2,theta1_d,theta2_d},{y1,y2,y3,y4})
dy4 = subs(Sol.theta2_dd,{theta1,theta2,theta1_d,theta2_d},{y1,y2,y3,y4})
[dy] = [dy1;dy2;dy3;dy4];