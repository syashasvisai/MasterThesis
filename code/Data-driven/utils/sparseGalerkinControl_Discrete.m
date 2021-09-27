function ykplus1 = sparseGalerkinControl_Discrete(t,y,u,p)

if isfield(p,'SelectVars')==0
    p.SelectVars = 1:length(y);
end
polyorder = p.polyorder;
usesine = p.usesine;
ahat = p.ahat;
polysine = p.polysine;
yPool = poolData([y(p.SelectVars)' u],length(p.SelectVars)+1,polyorder,usesine,polysine);
ykplus1 = (yPool*ahat)';