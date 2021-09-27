function xaug = augment_x(x,P)

% P = size(param.A,1);
x1 = x(:,1); x2 = x(:,2); x3 = x(:,3); x4 = x(:,4);

switch P
    case 4
        Psi = []; % 4 just the states
    case 6 
        Psi = [sin(x1).*cos(x1) ones(size(x1,1),1)];  % 6 - sin*cos
%     case 7
        Psi = [sin(x1) cos(x1) ones(size(x1,1),1)];  % 7 - states + sin and cos
%     case 8
        Psi = [sin(x1) cos(x1) sin(x1).*cos(x1) ones(size(x1,1),1)];  % 8 - states + sin,cos and sin*cos
    case 12 
        Psi = [x1.^2 x3.^2 x1.*x2 x1.*x3 x1.*x4 x2.*x3 x3.*x4 ones(size(x1,1),1)];  % 12 - only Poly without x2^2 and x4^2
    case 19
          Psi = [x1.^2 x3.^2 x1.*x2 x1.*x3 x1.*x4 x2.*x3 x3.*x4...
    x1.*sin(x1) x3.*sin(x2) x1.^2.*sin(x1) x3.^2.*sin(x2) sin(x1) cos(x1)...
    sin(x1).*cos(x1) ones(size(x1,1),1)];  % 19
end

xaug = [x1 x2 x3 x4 Psi]';