function G = linearize_ADIP(p1,p2)
% LPVplant(y1,pi)
% Linearizes the Control Moment Gyroscope frozen operating points
np1 = numel(p1);
np2 = numel(p2);

G = ss(zeros(2,1,np1,np2));
for ii = 1:np1
    for jj = 1:np2
       G(:,:,ii,jj) = LPVplant(p1(ii),p2(jj));
    end
end

function G = LPVplant(y1,y3)
load('parameters.mat')
A_lin = [                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1,                                                                                                                                                                                                                                                                                                                                                                                               0;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0,                                                                                                                                                                                                                                                                                                                                                                                                        1;
                                                                                                                                                                                                            (2*(2*g*l_pend^2*l_pivot*m_pend^2*cos(y1) + 4*Jpend*g*l_pivot*m_arm*cos(y1) + 8*Jpend*g*l_pivot*m_hinge*cos(y1) + 8*Jpend*g*l_pivot*m_pend*cos(y1) - 2*l_pend^2*l_pivot^2*m_pend^2*y3^2*cos(2*y1) + g*l_pend^2*l_pivot*m_arm*m_pend*cos(y1) + 2*g*l_pend^2*l_pivot*m_hinge*m_pend*cos(y1)))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 4*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 4*l_pend^2*l_pivot^2*m_pend^2*cos(y1)^2) - (16*l_pend^2*l_pivot^2*m_pend^2*cos(y1)*sin(y1)*(2*g*l_pend^2*l_pivot*m_pend^2*sin(y1) - 2*C_arm*l_pend^2*m_pend*y3 - 8*Jpend*g*l_pivot*sin(y1)*(m_arm/2 + m_hinge + m_pend) - 8*C_arm*Jpend*y3 + 4*Jpend*g*l_pivot*m_arm*sin(y1) + 8*Jpend*g*l_pivot*m_hinge*sin(y1) + 8*Jpend*g*l_pivot*m_pend*sin(y1) - l_pend^2*l_pivot^2*m_pend^2*y3^2*sin(2*y1) - 2*g*l_pend^2*l_pivot*m_pend*sin(y1)*(m_arm/2 + m_hinge + m_pend) + g*l_pend^2*l_pivot*m_arm*m_pend*sin(y1) + 2*g*l_pend^2*l_pivot*m_hinge*m_pend*sin(y1)))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 4*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 4*l_pend^2*l_pivot^2*m_pend^2*cos(y1)^2)^2,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            (16*l_pend^2*l_pivot^2*m_pend^2*cos(y1)*sin(y1)*(2*g*l_pend^2*l_pivot*m_pend^2*sin(y1) - 2*C_arm*l_pend^2*m_pend*y3 - 8*Jpend*g*l_pivot*sin(y1)*(m_arm/2 + m_hinge + m_pend) - 8*C_arm*Jpend*y3 + 4*Jpend*g*l_pivot*m_arm*sin(y1) + 8*Jpend*g*l_pivot*m_hinge*sin(y1) + 8*Jpend*g*l_pivot*m_pend*sin(y1) - l_pend^2*l_pivot^2*m_pend^2*y3^2*sin(2*y1) - 2*g*l_pend^2*l_pivot*m_pend*sin(y1)*(m_arm/2 + m_hinge + m_pend) + g*l_pend^2*l_pivot*m_arm*m_pend*sin(y1) + 2*g*l_pend^2*l_pivot*m_hinge*m_pend*sin(y1)))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 4*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 4*l_pend^2*l_pivot^2*m_pend^2*cos(y1)^2)^2 - (2*(- 2*cos(2*y1)*l_pend^2*l_pivot^2*m_pend^2*y3^2 + 2*g*cos(y1)*l_pend^2*l_pivot*m_pend^2))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 4*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 4*l_pend^2*l_pivot^2*m_pend^2*cos(y1)^2),                                                                                                                                                                      -(2*(2*y3*sin(2*y1)*l_pend^2*l_pivot^2*m_pend^2 + 2*C_arm*l_pend^2*m_pend + 8*C_arm*Jpend))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 4*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 4*l_pend^2*l_pivot^2*m_pend^2*cos(y1)^2),                                                                   -(8*C_pend*l_pend*l_pivot*m_pend*cos(y1))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 4*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 4*l_pend^2*l_pivot^2*m_pend^2*cos(y1)^2);
 (2*(4*g*l_pend*l_pivot^2*m_pend^2*cos(2*y1) - 4*l_pend*l_pivot^3*m_pend^2*y3^2*cos(y1) + 2*g*l_pend*l_pivot^2*m_arm*m_pend*cos(2*y1) + 4*g*l_pend*l_pivot^2*m_hinge*m_pend*cos(2*y1) - l_pend*l_pivot^3*m_arm*m_pend*y3^2*cos(y1) + 4*C_arm*l_pend*l_pivot*m_pend*y3*sin(y1) - 4*Jarm*l_pend*l_pivot*m_pend*y3^2*cos(y1) - 4*Jhinge*l_pend*l_pivot*m_pend*y3^2*cos(y1) - 4*Jl*l_pend*l_pivot*m_pend*y3^2*cos(y1) + 4*g*l_pend*l_pivot^2*m_pend*sin(y1)^2*(m_arm/2 + m_hinge + m_pend)))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 2*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 2*l_pend^2*l_pivot^2*m_pend^2*cos(2*y1)) + (8*l_pend^2*l_pivot^2*m_pend^2*sin(2*y1)*(4*l_pend*l_pivot^3*m_pend^2*y3^2*sin(y1) - 2*g*l_pend*l_pivot^2*m_pend^2*sin(2*y1) - g*l_pend*l_pivot^2*m_arm*m_pend*sin(2*y1) - 2*g*l_pend*l_pivot^2*m_hinge*m_pend*sin(2*y1) + l_pend*l_pivot^3*m_arm*m_pend*y3^2*sin(y1) + 4*C_arm*l_pend*l_pivot*m_pend*y3*cos(y1) + 4*Jarm*l_pend*l_pivot*m_pend*y3^2*sin(y1) + 4*Jhinge*l_pend*l_pivot*m_pend*y3^2*sin(y1) + 4*Jl*l_pend*l_pivot*m_pend*y3^2*sin(y1) + 4*g*l_pend*l_pivot^2*m_pend*cos(y1)*sin(y1)*(m_arm/2 + m_hinge + m_pend)))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 2*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 2*l_pend^2*l_pivot^2*m_pend^2*cos(2*y1))^2, - (2*(2*g*l_pend*l_pivot^2*m_pend^2 + 4*Jarm*g*l_pend*m_pend + 4*Jhinge*g*l_pend*m_pend + 4*Jl*g*l_pend*m_pend + 2*g*l_pend*l_pivot^2*m_pend^2*cos(2*y1) - 4*l_pend*l_pivot^3*m_pend^2*y3^2*cos(y1) - 2*g*l_pend*l_pivot^2*m_hinge*m_pend + g*l_pend*l_pivot^2*m_arm*m_pend*cos(2*y1) + 2*g*l_pend*l_pivot^2*m_hinge*m_pend*cos(2*y1) - l_pend*l_pivot^3*m_arm*m_pend*y3^2*cos(y1) + 4*C_arm*l_pend*l_pivot*m_pend*y3*sin(y1) - 4*Jarm*l_pend*l_pivot*m_pend*y3^2*cos(y1) - 4*Jhinge*l_pend*l_pivot*m_pend*y3^2*cos(y1) - 4*Jl*l_pend*l_pivot*m_pend*y3^2*cos(y1) + 4*g*l_pend*l_pivot^2*m_pend*sin(y1)^2*(m_arm/2 + m_hinge + m_pend)))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 2*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 2*l_pend^2*l_pivot^2*m_pend^2*cos(2*y1)) - (8*l_pend^2*l_pivot^2*m_pend^2*sin(2*y1)*(4*l_pend*l_pivot^3*m_pend^2*y3^2*sin(y1) - 2*g*l_pend*l_pivot^2*m_pend^2*sin(2*y1) - g*l_pend*l_pivot^2*m_arm*m_pend*sin(2*y1) - 2*g*l_pend*l_pivot^2*m_hinge*m_pend*sin(2*y1) + l_pend*l_pivot^3*m_arm*m_pend*y3^2*sin(y1) + 4*C_arm*l_pend*l_pivot*m_pend*y3*cos(y1) + 4*Jarm*l_pend*l_pivot*m_pend*y3^2*sin(y1) + 4*Jhinge*l_pend*l_pivot*m_pend*y3^2*sin(y1) + 4*Jl*l_pend*l_pivot*m_pend*y3^2*sin(y1) + 4*g*l_pend*l_pivot^2*m_pend*cos(y1)*sin(y1)*(m_arm/2 + m_hinge + m_pend)))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 2*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 2*l_pend^2*l_pivot^2*m_pend^2*cos(2*y1))^2, -(2*(4*C_arm*l_pend*l_pivot*m_pend*cos(y1) + 8*l_pend*l_pivot^3*m_pend^2*y3*sin(y1) + 8*Jarm*l_pend*l_pivot*m_pend*y3*sin(y1) + 8*Jhinge*l_pend*l_pivot*m_pend*y3*sin(y1) + 8*Jl*l_pend*l_pivot*m_pend*y3*sin(y1) + 2*l_pend*l_pivot^3*m_arm*m_pend*y3*sin(y1)))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 2*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 2*l_pend^2*l_pivot^2*m_pend^2*cos(2*y1)), -(2*(8*C_pend*Jarm + 8*C_pend*Jhinge + 8*C_pend*Jl + 2*C_pend*l_pivot^2*m_arm + 8*C_pend*l_pivot^2*m_pend))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 2*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 2*l_pend^2*l_pivot^2*m_pend^2*cos(2*y1))];

B_lin =[                                                                                                                                                                                                                                                                                                                      0;
                                                                                                                                                                                                                                                                                                                              0;
 (2*(2*m_pend*l_pend^2 + 8*Jpend))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 4*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 4*l_pend^2*l_pivot^2*m_pend^2*cos(y1)^2);
 (8*l_pend*l_pivot*m_pend*cos(y1))/(16*Jarm*Jpend + 16*Jhinge*Jpend + 16*Jl*Jpend + 2*l_pend^2*l_pivot^2*m_pend^2 + 4*Jarm*l_pend^2*m_pend + 4*Jhinge*l_pend^2*m_pend + 4*Jl*l_pend^2*m_pend + 4*Jpend*l_pivot^2*m_arm + 16*Jpend*l_pivot^2*m_pend + l_pend^2*l_pivot^2*m_arm*m_pend - 2*l_pend^2*l_pivot^2*m_pend^2*cos(2*y1))];
 
A = double(A_lin);
B = double(B_lin);

C = [1 0 0 0; 0 1 0 0];
D = zeros(2,1);

G = ss(A,B,C,D);

G.OutputName={'theta1','theta2'};
G.InputName={'u'};
G.StateName={'theta1','theta2','theta1d','theta2d'};