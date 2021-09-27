function [A_jcb,B_jcb] = jacobian_eq(dy)
load('symbolics.mat')
eq = [dy(1);dy(2);dy(3);dy(4)];
vec = [y1;y2;y3;y4];
A_jcb = jacobian(eq,vec);
B_jcb = jacobian(eq,u);