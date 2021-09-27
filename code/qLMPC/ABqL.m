function [A,B] = ABqL(Ts,rho,param)
% ABqL calculates system (A) and input (B) matrix for quasiLPV
% representation
% 
% Inputs: * Ts: Sampling time
%         * rho: Scheduling parameter vector: rho = [theta1,theta1d]
%
% Outputs: * A: System matrix A(rho) at current rho, discretised with Ts
%          * B: Input matrix B(rho) at current rho, discretised with Ts

% Pablo S.G. Cisneros, Herbert Werner, ICS TUHH
% Code adapted to requirements from the original file by Pablo S.G.
% Cisneros and Antje Dittmer.
%% Parameters
 
m1 = param.m_arm;
m2 = param.m_pend;
mh = param.m_hinge;
l1 = param.l_pivot;
l2 = param.l_pend;
g_ = param.g;
J_arm = param.Jarm;
J_pend = param.Jpend;
J_motor = param.Jl;
J_sensor = param.Jhinge;
fv1 = param.C_arm;
fv2 =  param.C_pend;

y1 = rho(1);
y3 = rho(2);
% %% M, D, K matrices
M = [ J_arm + J_motor + J_sensor + (l1^2*m1)/4 + l1^2*m2, (l1*l2*m2*cos(y1))/2;
                               (l1*l2*m2*cos(y1))/2, (m2*l2^2)/4 + J_pend];
% 
D = [                      fv1,   0;
    -(l1*l2*m2*y3*sin(y1))/2, fv2];
% 
K = [ (g_*((l1*m1*sin(y1))/2 + l1*m2*sin(y1) + l1*mh*sin(y1)))/pi,            0;
                                                           0, (g_*l2*m2)/2];
% 
%% Calculate Aeval from M,D,K
act = 1;
MaskB = [eye(act);zeros(act)];
Mi = inv(M);
% 
Aeval = [zeros(2) eye(2);...
    -Mi*K -Mi*D];
% 
%% Calculate Beval from M,D,K through fourth order discretization
Beval = [zeros(2,2);Mi]*MaskB;
A2 = Aeval*Aeval;
A3 = Aeval*A2;
%II = eye(4);
Apre = (1.0/24.0)*Ts^4*A3+(1.0/6.0)*Ts^3*A2+0.5*Ts^2*Aeval+Ts*eye(4);

%% Calculate A,B
A = Apre*Aeval + eye(4);
B = Apre*Beval;
end
