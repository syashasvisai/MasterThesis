function [dx, y] = ADIP_est(t, x, u, m1, m2, mh, l1, l2, J_arm, J_pend,J_motor,J_sensor, fv1, fv2, varargin)
% Arm- Driven inverted pendulum
% Output equations.
y = [x(1); x(2)];

y1 = x(1);
y2 = x(2);
y3 = x(3);
y4 = x(4);

u = u*0.0741; % This is imp. Multiply by motor constant
g_ = -9.81; 

% State equations.
dy1 = y3;
dy2 = y4;
dy3 =-(2*(8*J_pend*fv1*y3 - 2*l2^2*m2*u - 8*J_pend*u + 2*fv1*l2^2*m2*y3 + l1^2*l2^2*m2^2*y3^2*sin(2*y1 - 2*y2) + l1*l2^3*m2^2*y4^2*sin(y1 - y2) + g_*l1*l2^2*m2^2*sin(y1) + 4*J_pend*g_*l1*m1*sin(y1) + 8*J_pend*g_*l1*m2*sin(y1) + 8*J_pend*g_*l1*mh*sin(y1) + g_*l1*l2^2*m2^2*sin(y1 - 2*y2) - 4*fv2*l1*l2*m2*y4*cos(y1 - y2) + g_*l1*l2^2*m1*m2*sin(y1) + 2*g_*l1*l2^2*m2*mh*sin(y1) + 4*J_pend*l1*l2*m2*y4^2*sin(y1 - y2)))/(16*J_arm*J_pend + 16*J_motor*J_pend + 16*J_pend*J_sensor + 4*l1^2*l2^2*m2^2 + 4*J_arm*l2^2*m2 + 4*J_motor*l2^2*m2 + 4*J_pend*l1^2*m1 + 16*J_pend*l1^2*m2 + 4*J_sensor*l2^2*m2 - 4*l1^2*l2^2*m2^2*cos(y1 - y2)^2 + l1^2*l2^2*m1*m2);
dy4 =(2*(l1^2*l2^2*m2^2*y4^2*sin(2*y1 - 2*y2) - 8*J_motor*fv2*y4 - 8*J_sensor*fv2*y4 - 2*fv2*l1^2*m1*y4 - 8*fv2*l1^2*m2*y4 - 8*J_arm*fv2*y4 - 4*l1*l2*m2*u*cos(y1 - y2) + 2*g_*l1^2*l2*m2^2*sin(2*y1 - y2) + 4*l1^3*l2*m2^2*y3^2*sin(y1 - y2) - 2*g_*l1^2*l2*m2^2*sin(y2) - 4*J_arm*g_*l2*m2*sin(y2) - 4*J_motor*g_*l2*m2*sin(y2) - 4*J_sensor*g_*l2*m2*sin(y2) + g_*l1^2*l2*m1*m2*sin(2*y1 - y2) + 2*g_*l1^2*l2*m2*mh*sin(2*y1 - y2) + l1^3*l2*m1*m2*y3^2*sin(y1 - y2) + 4*fv1*l1*l2*m2*y3*cos(y1 - y2) + 2*g_*l1^2*l2*m2*mh*sin(y2) + 4*J_arm*l1*l2*m2*y3^2*sin(y1 - y2) + 4*J_motor*l1*l2*m2*y3^2*sin(y1 - y2) + 4*J_sensor*l1*l2*m2*y3^2*sin(y1 - y2)))/(16*J_arm*J_pend + 16*J_motor*J_pend + 16*J_pend*J_sensor + 2*l1^2*l2^2*m2^2 + 4*J_arm*l2^2*m2 + 4*J_motor*l2^2*m2 + 4*J_pend*l1^2*m1 + 16*J_pend*l1^2*m2 + 4*J_sensor*l2^2*m2 - 2*l1^2*l2^2*m2^2*cos(2*y1 - 2*y2) + l1^2*l2^2*m1*m2);
dx = [dy1; dy2; dy3; dy4];
  