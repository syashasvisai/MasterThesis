function dy = sparseGalerkinControl(t,y,u,ahat,polyorder,usesine,polysine)
% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton
% For Paper, "Discovering Governing Equations from Data: 
%        Sparse Identification of Nonlinear Dynamical Systems"
% by S. L. Brunton, J. L. Proctor, and J. N. Kutz

yPool = poolData([y' u],length(y)+1,polyorder,usesine,polysine);
dy = (yPool*ahat)';
