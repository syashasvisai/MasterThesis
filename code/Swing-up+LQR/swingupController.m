%% Swing up controller
function u = swingupController(theta0,thetaT,params,Kp,Kd,Ke)

y1 = theta0(1); y2 = theta0(2); y3 = theta0(3); y4 = theta0(4);

m1 = params(1); m2 = params(2); mh = params(3); l1 = params(4);  
l2 = params(5); g_ = params(6); J_arm = params(7); 
J_pend = params(8); J_motor = params(9); J_sensor= params(10);
fv1 = params(11); fv2 = params(12);
y1_tilda = theta0(1)-thetaT(1);

u = (Kd*(J_pend*fv1*y3 + (fv1*l2^2*m2*y3)/4 + (l1^2*l2^2*m2^2*y3^2*sin(2*y1 - 2*y2))/8 + (l1*l2^3*m2^2*y4^2*sin(y1 - y2))/8 + (g_*l1*l2^2*m2^2*sin(y1))/8 + (J_pend*g_*l1*m1*sin(y1))/2 + J_pend*g_*l1*m2*sin(y1) + J_pend*g_*l1*mh*sin(y1) + (g_*l1*l2^2*m2^2*sin(y1 - 2*y2))/8 - (fv2*l1*l2*m2*y4*cos(y1 - y2))/2 + (g_*l1*l2^2*m1*m2*sin(y1))/8 + (g_*l1*l2^2*m2*mh*sin(y1))/4 + (J_pend*l1*l2*m2*y4^2*sin(y1 - y2))/2) - (y3 + Kp*y1_tilda)*(J_arm*J_pend + J_motor*J_pend + J_pend*J_sensor + (l1^2*l2^2*m2^2)/4 + (J_arm*l2^2*m2)/4 + (J_motor*l2^2*m2)/4 + (J_pend*l1^2*m1)/4 + J_pend*l1^2*m2 + (J_sensor*l2^2*m2)/4 - (l1^2*l2^2*m2^2*cos(y1 - y2)^2)/4 + (l1^2*l2^2*m1*m2)/16))/(Kd*((m2*l2^2)/4 + J_pend) + Ke*((J_arm*y3^2)/2 + (J_motor*y3^2)/2 + (J_pend*y4^2)/2 + (J_sensor*y3^2)/2 + g_*m1*(l1/2 - (l1*cos(y1))/2) + g_*m2*(l1 + l2/2 - l1*cos(y1) - (l2*cos(y2))/2) + g_*mh*(l1 - l1*cos(y1)))*(J_arm*J_pend + J_motor*J_pend + J_pend*J_sensor + (l1^2*l2^2*m2^2)/4 + (J_arm*l2^2*m2)/4 + (J_motor*l2^2*m2)/4 + (J_pend*l1^2*m1)/4 + J_pend*l1^2*m2 + (J_sensor*l2^2*m2)/4 - (l1^2*l2^2*m2^2*cos(y1 - y2)^2)/4 + (l1^2*l2^2*m1*m2)/16));
end