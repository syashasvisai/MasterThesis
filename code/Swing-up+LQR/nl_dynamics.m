function dy = nl_dynamics(theta0,params,u)
y1 = theta0(1);  % measured theta1          
y2 = theta0(2);  % mreasured theta2
y3 = theta0(3);  % mreasured theta1d
y4 = theta0(4);  % mreasured theta2d
m1 = params(1);  % Mass of arm
m2 = params(2);  % Mass of pendulum
mh = params(3);  % Mass of Sensor assy.
l1 = params(4);  % Length of arm
l2 = params(5);  % Length of pendulum
g_ = params(6);
J_arm   = params(7);
J_pend  = params(8);
J_motor = params(9);
J_sensor= params(10);
fv1 = params(11);
fv2 = params(12);

dy1 = y3;
dy2 = y4;
dy3 =-(2*(8*J_pend*fv1*y3 - 2*l2^2*m2*u - 8*J_pend*u + 2*fv1*l2^2*m2*y3 + l1^2*l2^2*m2^2*y3^2*sin(2*y1 - 2*y2) + l1*l2^3*m2^2*y4^2*sin(y1 - y2) + g_*l1*l2^2*m2^2*sin(y1) + 4*J_pend*g_*l1*m1*sin(y1) + 8*J_pend*g_*l1*m2*sin(y1) + 8*J_pend*g_*l1*mh*sin(y1) + g_*l1*l2^2*m2^2*sin(y1 - 2*y2) - 4*fv2*l1*l2*m2*y4*cos(y1 - y2) + g_*l1*l2^2*m1*m2*sin(y1) + 2*g_*l1*l2^2*m2*mh*sin(y1) + 4*J_pend*l1*l2*m2*y4^2*sin(y1 - y2)))/(16*J_arm*J_pend + 16*J_motor*J_pend + 16*J_pend*J_sensor + 4*l1^2*l2^2*m2^2 + 4*J_arm*l2^2*m2 + 4*J_motor*l2^2*m2 + 4*J_pend*l1^2*m1 + 16*J_pend*l1^2*m2 + 4*J_sensor*l2^2*m2 - 4*l1^2*l2^2*m2^2*cos(y1 - y2)^2 + l1^2*l2^2*m1*m2);
dy4 =(2*(l1^2*l2^2*m2^2*y4^2*sin(2*y1 - 2*y2) - 8*J_motor*fv2*y4 - 8*J_sensor*fv2*y4 - 2*fv2*l1^2*m1*y4 - 8*fv2*l1^2*m2*y4 - 8*J_arm*fv2*y4 - 4*l1*l2*m2*u*cos(y1 - y2) + 2*g_*l1^2*l2*m2^2*sin(2*y1 - y2) + 4*l1^3*l2*m2^2*y3^2*sin(y1 - y2) - 2*g_*l1^2*l2*m2^2*sin(y2) - 4*J_arm*g_*l2*m2*sin(y2) - 4*J_motor*g_*l2*m2*sin(y2) - 4*J_sensor*g_*l2*m2*sin(y2) + g_*l1^2*l2*m1*m2*sin(2*y1 - y2) + 2*g_*l1^2*l2*m2*mh*sin(2*y1 - y2) + l1^3*l2*m1*m2*y3^2*sin(y1 - y2) + 4*fv1*l1*l2*m2*y3*cos(y1 - y2) + 2*g_*l1^2*l2*m2*mh*sin(y2) + 4*J_arm*l1*l2*m2*y3^2*sin(y1 - y2) + 4*J_motor*l1*l2*m2*y3^2*sin(y1 - y2) + 4*J_sensor*l1*l2*m2*y3^2*sin(y1 - y2)))/(16*J_arm*J_pend + 16*J_motor*J_pend + 16*J_pend*J_sensor + 2*l1^2*l2^2*m2^2 + 4*J_arm*l2^2*m2 + 4*J_motor*l2^2*m2 + 4*J_pend*l1^2*m1 + 16*J_pend*l1^2*m2 + 4*J_sensor*l2^2*m2 - 2*l1^2*l2^2*m2^2*cos(2*y1 - 2*y2) + l1^2*l2^2*m1*m2);
dy = [dy1 dy2 dy3 dy4 zeros(1,20)]';% We integrate only the initial condns.