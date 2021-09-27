function [A,B] = ABqL_GA(Ts,rho,C)
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
m1=C(1); % Mass of arm
m2=C(2); % Mass of pendulum
mh = C(3); % Mass of Hinge
l1  = C(4); % Length of arm
l2 = C(5); % Length of pendulum
g_ = C(6);
J_arm = C(7);
J_pend = C(8);
J_motor = C(9);
J_sensor = C(10);
fv1 = C(11);
fv2 = C(12);

y1 = rho(1);
y3 = rho(2);
% %% M, D, K matrices
M = [ J_arm + J_motor + J_sensor + (l1^2*m1)/4 + l1^2*m2, (l1*l2*m2*cos(y1))/2;
                               (l1*l2*m2*cos(y1))/2, (m2*l2^2)/4 + J_pend];
% 
D = [                      fv1,   0;
    -(l1*l2*m2*y3*sin(y1))/2, fv2];
% 
K = [ (g_*((l1*m1*sin(y1))/2 + l1*m2*sin(y1) + l1*mh*sin(y1)))/pi,      0;
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
