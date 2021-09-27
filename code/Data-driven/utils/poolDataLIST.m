function yout = poolDataLIST(yin,ahat,nVars,polyorder,usesine,polysine)
% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton
% For Paper, "Discovering Governing Equations from Data: 
%        Sparse Identification of Nonlinear Dynamical Systems"
% by S. L. Brunton, J. L. Proctor, and J. N. Kutz

n = size(yin,1);
sk = 1;
sj = 1;

ind = 1;
% % poly order 0
% yout{ind,1}= ['1'];
% ind = ind+1;

% poly order 1
for i=1:nVars
    yout(ind,1) = yin(i);
    ind = ind+1;
end

if(polyorder>=2)
    % poly order 2
    for i=1:nVars-1
        for j=i:nVars-1
            yout{ind,1}= [yin{i},'.*',yin{j}];
            ind = ind+1;
        end
    end
end

if(polyorder>=3)
    % poly order 3
    for i=1:nVars-1
        for j=i:nVars-1
            for k=j:nVars-1
                yout{ind,1}= [yin{i},'.*',yin{j},'.*',yin{k}];
                ind = ind+1;
            end
        end
    end
end

if(polyorder>=4)
    % poly order 4
    for i=1:nVars-1
        for j=i:nVars-1
            for k=j:nVars-1
                for l=k:nVars-1
                    yout{ind,1}= [yin{i},'.*',yin{j},'.*',yin{k},'.*',yin{l}];
                    ind = ind+1;
                end
            end
        end
    end
end

if(polyorder>=5)
    % poly order 5
    for i=1:nVars-1
        for j=i:nVars-1
            for k=j:nVars-1
                for l=k:nVars-1
                    for m=l:nVars-1
                        yout{ind,1}= [yin{i},'.*',yin{j},'.*',yin{k},'.*',yin{l},'.*',yin{m}];
                        ind = ind+1;
                    end
                end
            end
        end
    end
end

% sin and cos
if(usesine)
    for k=1:sk
        for i = 1:sj 
            yout{ind,1}= ['sin(',num2str(k),'*',yin{i},')'];
            ind = ind + 1;
        end
        for i = 1:sj
            yout{ind,1}= ['cos(',num2str(k),'*',yin{i},')'];
            ind = ind + 1;
        end
    end
end

% sin^2 and cos^2
if(usesine)
    for k=1:sk
        for i = 1:sj 
            yout{ind,1}= ['sin(',num2str(k),'*',yin{i},').^2'];
            ind = ind + 1;
        end
        for i = 1:sj
            yout{ind,1}= ['cos(',num2str(k),'*',yin{i},').^2'];
            ind = ind + 1;
        end
    end
end

% sin*cos
if(usesine)
    for k=1:sk
        for i = 1:sj
            for j = 1:sj
                yout{ind,1}= ['sin(',num2str(k),'*',yin{i},')','.*','cos(',num2str(k),'*',yin{j},')'];
                ind = ind + 1;
            end
        end
    end
end

% ti*sin, ti*cos
if(polysine)
    for i=1:nVars-3
        for k= 1:sk
            for j = 1:sj
                yout{ind,1}= [yin{i},'.*','sin(',num2str(k),'*',yin{j},')'];
                ind = ind + 1;
            end
            for j = 1:sj
                yout{ind,1}= [yin{i},'.*','cos(',num2str(k),'*',yin{j},')'];
                ind = ind + 1;
            end
        end
    end
end

% % ti*tj*sin, ti*tj*cos
% if(polysine)
%     for i=1:nVars-3
%         for j=i:nVars-3
%             for k= 1:sk
%                 for jj = 1:sj
%                     yout{ind,1}= [yin{i},'.*',yin{j},'.*','sin(',num2str(k),'*',yin{jj},')'];
%                     ind = ind + 1;
%                 end
%                 for jj = 1:sj
%                     yout{ind,1}= [yin{i},'.*',yin{j},'.*','cos(',num2str(k),'*',yin{jj},')'];
%                     ind = ind + 1;
%                 end
%             end
%         end
%     end
% end

% % ti*tj*sin^2, ti*tj*cos^2
% if(polysine)
%     for i=1:nVars-1
%         for j=i:nVars-1
%             for k= 1:sk
%                 for jj = 1:sj
%                     yout{ind,1}= [yin{i},'.*',yin{j},'.*','sin(',num2str(k),'*',yin{jj},')^2'];
%                     ind = ind + 1;
%                 end
%                 for jj = 1:sj
%                     yout{ind,1}= [yin{i},'.*',yin{j},'.*','cos(',num2str(k),'*',yin{jj},')^2'];
%                     ind = ind + 1;
%                 end
%             end
%         end
%     end
% end
% 
% % ti*tj*sin^2*cos^2
% if(polysine)
%     for i=1:nVars-1
%         for j=i:nVars-1
%             for k= 1:sk
%                 for jj = 1:sj
%                     yout{ind,1}= [yin{i},'.*',yin{j},'.*','sin(',num2str(k),'*',yin{jj},')^2','.*','cos(',num2str(k),'*',yin{jj},')^2'];
%                     ind = ind + 1;
%                 end
%             end
%         end
%     end
% end


output = yout;
newout(1) = {''};
for k=1:size(ahat,2)%length(yin)
    newout{1,1+k} = [yin{k},'dot'];
end
for k=1:size(ahat,1)
    newout(k+1,1) = output(k);
    for j=1:size(ahat,2)%length(yin)
        newout{k+1,1+j} = ahat(k,j);
    end
end
yout = newout;
