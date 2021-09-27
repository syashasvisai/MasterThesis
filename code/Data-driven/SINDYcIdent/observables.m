ind = [];
for j = 1:size(Xi,1)
        A = sum(Xi(j,:));
        B = 0;
        if ~isequal(A,B)
            ind = [ind j];
        end
end
s = {};
for i = 1:length(ind)
    s{i,1} = Epsilon{ind(i),1};
end
Observables = s(2:end,:)

% toLatex = str2sym(Observables);
% Obsv_ = latex(sym(toLatex)) 

