function [L,S,H,g] = HSqLd(N,q,R_,p,xk,Xk,Ts,ref,param)
% HSqLd calculate matrices L, S, H and g for Lemke's algorithm
%
% Inputs: * N: number of samples optimization (N = 40)
%         * q: diag Q state weighting matrix stage cost l(x,u) = x'Qx + u'Ru
%         * R_: R_ = kron(eye(N),R), R input weighting matrix stage cost
%         * xk: quasiLPV KF state estimates
%         * Xk: Xko(= L*xk+S*U) delayed by one sample timestep
%         * Ts: sample time
%         * ref: Reference signal
%         * us: steady state input
%
% Outputs: * L: stacked matrix L for state trajectory Xk = L x_k + S U_k
%          * S: stacked matrix S for state trajectory
%          * H: Hessian: H = 2*(S'*Q*S+R_)
%          * g: Derivative dJk/dUk: g = 2*S'*Q*(L*xk-ref) - 2*(R_*Usp);

% Pablo S.G. Cisneros, Herbert Werner, ICS TUHH

nx = length(xk);  ni = 1; %;

p1 = [xk(1);Xk(1:nx:end)]; %rho1 = x(1)
p2 = [xk(3);Xk(3:nx:end)]; %rho2 = x(3)

%%%%%%%%% Build L, S matrices Xk = L*xk+S*Uk%%
[Aj,Bj] = ABqL(Ts,[p1(1),p2(1)],param);

L = zeros(nx*N,nx);
S = zeros(nx*N,ni*N);
L(1:nx,1:nx) = Aj;
S(1:nx,1:ni) = Bj;

for idx = 1:N-1
    [Aj,Bj] = ABqL(Ts,[p1(idx+1),p2(idx+1)],param);
    L(idx*nx+1:(idx+1)*nx,1:nx) = Aj*L((idx-1)*nx+1:idx*nx,1:nx);
    S(idx*nx+1:(idx+1)*nx,1:(idx+1)*ni) = [Aj*S((idx-1)*nx+1:idx*nx,1:idx*ni),Bj];
end

%%%%%%%%%%% Compute product S'*Q_%%%%%%%%%%%%%
% this is done for efficiency
q_repeat = [repmat(q,1,N-1),p];
SQ = bsxfun(@times, S', q_repeat);

%%%%%%%%%%% Compute Hessian H, derivative g = dJk/dUk %%
% min Jk(Uk) s.t. h1(Uk) = 0, h2(Uk) < 0, at current estimate xl
% <=> min( x'H(xl)x + g(xl)x s.t. dh1(xl)x+h1(xl)=0, dh2(xl)x+h2(xl)< 0
% with 
% Jk = (Lx+SUk-Xss)'Q(Lx+SUk-Xss) +(Uk-Uss)'R(Uk-Uss) + Psi
% dJk/dUk = 2S'Q (Lx+SUk-Xss) + 2R(Uk-Uss) 
H = 2*(SQ*S+R_);
g = 2*SQ*(L*xk-ref);

end

