function dy = sparseGalerkin(t,y,ahat,polyorder,usesine,polysine)

yPool = poolData(y',length(y),polyorder,usesine,polysine);
dy = (yPool*ahat)';