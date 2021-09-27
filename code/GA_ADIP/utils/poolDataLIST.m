function yout = poolDataLIST(yin,ahat,nVars,polyorder,usesine,polysine)

n = size(yin,1);

ind = 1;
% % poly order 0
% yout{ind,1} = ['1'];
% ind = ind+1;

% poly order 1
for i=1:nVars
    yout(ind,1) = yin(i);
    ind = ind+1;
end

if(polyorder>=2)
    % poly order 2
    for i=1:nVars
        for j=i:nVars
            yout{ind,1} = [yin{i},'.*',yin{j}];
            ind = ind+1;
        end
    end
end

if(polyorder>=3)
    % poly order 3
    for i=1:nVars
        for j=i:nVars
            for k=j:nVars
                yout{ind,1} = [yin{i},yin{j},yin{k}];
                ind = ind+1;
            end
        end
    end
end

if(polyorder>=4)
    % poly order 4
    for i=1:nVars
        for j=i:nVars
            for k=j:nVars
                for l=k:nVars
                    yout{ind,1} = [yin{i},yin{j},yin{k},yin{l}];
                    ind = ind+1;
                end
            end
        end
    end
end

if(polyorder>=5)
    % poly order 5
    for i=1:nVars
        for j=i:nVars
            for k=j:nVars
                for l=k:nVars
                    for m=l:nVars
                        yout{ind,1} = [yin{i},yin{j},yin{k},yin{l},yin{m}];
                        ind = ind+1;
                    end
                end
            end
        end
    end
end
% 
% if(usesine)
%     for k=1:10
%         for i = 1:length(yin) 
%             yout{ind,1} = ['sin(',num2str(k),'*',yin{i},')'];
%             ind = ind + 1;
%         end
%         for i = 1:length(yin)
%             yout{ind,1} = ['cos(',num2str(k),'*',yin{i},')'];
%             ind = ind + 1;
%         end
%     end
% end
% 
% if(polysine)
%     for i=1:nVars
%         for k= 1:10
%             for j = 1:length(yin)
%                 yout{ind,1} = [yin{i},'*','sin(',num2str(k),'*',yin{j},')'];
%                 ind = ind + 1;
%             end
%             for j = 1:length(yin)
%                 yout{ind,1} = [yin{i},'*','cos(',num2str(k),'*',yin{j},')'];
%                 ind = ind + 1;
%             end
%         end
%     end
% end


if(usesine)
    for k=1:2;
        for i = 1:length(yin(:,1:2)) 
            yout{ind,1} = ['sin(',num2str(k),'*',yin{i},')'];
            ind = ind + 1;
        end
        for i = 1:length(yin(:,1:2))
            yout{ind,1} = ['cos(',num2str(k),'*',yin{i},')'];
            ind = ind + 1;
        end
    end
end

if(polysine)
    for i=1:nVars
        for k= 1:2
            for j = 1:length(yin(:,1:2))
                yout{ind,1} = [yin{i},'.*','sin(',num2str(k),'*',yin{j},')'];
                ind = ind + 1;
            end
            for j = 1:length(yin(:,1:2))
                yout{ind,1} = [yin{i},'.*','cos(',num2str(k),'*',yin{j},')'];
                ind = ind + 1;
            end
        end
    end
end

if(polysine)
    for i=1:nVars
        for j=1:nVars
            for k= 1:2
                for jj = 1:length(yin(:,1:2))
                    yout{ind,1} = [yin{i},'.*',yin{j},'.*','sin(',num2str(k),'*',yin{jj},')'];
                    ind = ind + 1;
                end
                for jj = 1:length(yin(:,1:2))
                    yout{ind,1} = [yin{i},'.*',yin{j},'.*','cos(',num2str(k),'*',yin{jj},')'];
                    ind = ind + 1;
                end
            end
        end
    end
end

output = yout;
newout(1) = {''};
for k=1:length(yin)
    newout{1,1+k} = [yin{k},'dot'];
end

for k=1:size(ahat,1)
    newout(k+1,1) = output(k);
    for j=1:length(yin)
        newout{k+1,1+j} = ahat(k,j);
    end
end
yout = newout