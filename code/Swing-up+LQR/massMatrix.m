load('symbolics.mat');
syms rho1 rho2
eqn1 = J_arm*theta1_dd - u + J_motor*theta1_dd + J_sensor*theta1_dd + fv1*theta1_d(t) + (l1^2*m1*theta1_dd)/4 + l1^2*m2*theta1_dd + (g_*l1*m1*sin(theta1(t)))/2 + g_*l1*m2*sin(theta1(t)) + g_*l1*mh*sin(theta1(t)) + (l1*l2*m2*theta2_dd*cos(theta1(t) - theta2(t)))/2 + (l1*l2*m2*sin(theta1(t) - theta2(t))*theta2_d(t)^2)/2;
eqn2 = J_pend*theta2_dd + fv2*theta2_d(t) + (l2^2*m2*theta2_dd)/4 + (g_*l2*m2*sin(theta2(t)))/2 + (l1*l2*m2*theta1_dd*cos(theta1(t) - theta2(t)))/2 - (l1*l2*m2*sin(theta1(t) - theta2(t))*theta1_d(t)^2)/2;
eqn1 = eqn1 + u;

D_eq = formula([eqn1;eqn2]);
D_var = [theta1_dd; theta2_dd];
D_ = jacobian(D_eq,D_var); % Mass matrix
G_ = jacobian(D_eq,g_)*g_;   % Gravitational forces matrix
C_ = simplify([eqn1;eqn2] - D_*[theta1_dd;theta2_dd]-G_); % Coriolis matrix
C_ = subs(C_,{theta1,theta2,theta1_d,theta2_d},{y1,y2,y3,y4});

D = subs(D_,{theta1,theta2,theta1_d,theta2_d},{y1,y2,y3,y4})
% D = subs(D_,{theta1,theta2,theta1_d,theta2_d},{rho1,0,rho2,0})
G = subs(G_,{theta1,theta2,theta1_d,theta2_d},{y1,y2,y3,y4})
% G = subs(G_,{theta1,theta2,theta1_d,theta2_d},{rho1,0,rho2,0})
C = jacobian(C_,[y3,y4]);
% C = subs(C,[y1,y2,y3,y4],[rho1,0,rho2,0])
C = formula(C);
C = simplify(C)




% D = subs(D_,{theta1,theta2,theta1_d,theta2_d},{,y2,y3,y4})

Dlpv = subs(D,cos(y1-y2),cos(y1))
C(1,2) = 0.5*C(1,2);
C(2,1) = 0.5*C(2,1);

Clpv = subs(C,{y4,sin(y1-y2)},{0,sin(y1)})

G_ = [G(1)/y1 0 ; 0 G(2)];
Glpv = subs(G_,sin(y2),1)


