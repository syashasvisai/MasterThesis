function [u_swing, E_top, E_tilda] = swingup(dy_3,T,V,param)
load('symbolics.mat');
[Num,Den] = numden(dy_3);
Num = Num/16; Den = Den/16;
F = subs(Num,u,0)
t_2 = diff(Num,u)
E = sum(T)+sum(V); % Total Energy
E = subs(E,[theta1, theta2, theta1_d,theta2_d],[y1,y2,y3,y4])
E_top = subs(E,[y1,y2,y3,y4],[0,0,0,0]);
E_top = subs(E_top,[m1,m2,mh,l1,l2,g_],...
    [param.m_arm,param.m_pend,param.m_hinge,param.l_pivot,param.l_pend,param.g]);
E_top = double(E_top)
E_tilda = E-E_top

u_swing = (-Kd*F - Den*(y3+Kp*y1_tilda))/(Den*Ke*E_tilda + Kd*t_2);