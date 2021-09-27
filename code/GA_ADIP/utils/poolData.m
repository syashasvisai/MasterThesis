function yout = poolData(yin,nVars,polyorder,usesine,polysine)

n = size(yin,1);

ind = 1;

% poly order 1
for i=1:nVars
    yout(:,ind) = yin(:,i);
    ind = ind+1;
end

% % poly order 0
% yout(:,ind) = ones(n,1);
% ind = ind+1;

if(polyorder>=2)
    % poly order 2
    for i=1:nVars
        for j=i:nVars
            yout(:,ind) = yin(:,i).*yin(:,j);
            ind = ind+1;
        end
    end
end

if(polyorder>=3)
    % poly order 3
    for i=1:nVars
        for j=i:nVars
            for k=j:nVars
                yout(:,ind) = yin(:,i).*yin(:,j).*yin(:,k);
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
                    yout(:,ind) = yin(:,i).*yin(:,j).*yin(:,k).*yin(:,l);
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
                        yout(:,ind) = yin(:,i).*yin(:,j).*yin(:,k).*yin(:,l).*yin(:,m);
                        ind = ind+1;
                    end
                end
            end
        end
    end
end

% if(usesine)
%     for k=1:10
%         yout = [yout sin(k*yin) cos(k*yin)];
%     end
% end
% 
% if(polysine)
%     for i=1:nVars
%         for k= 1:10
%             yout = [yout yin(:,i).*sin(k*yin) yin(:,i).*cos(k*yin)];
%         end
%     end
% end

if(usesine)
    for k=1:2
        yout = [yout sin(k*yin(:,1:2)) cos(k*yin(:,1:2))];
    end
end

if(polysine)
    for i=1:nVars
        for k= 1:2
            yout = [yout yin(:,i).*sin(k*yin(:,1:2)) yin(:,i).*cos(k*yin(:,1:2))];
        end
    end
end

if(polysine)
    for i=1:nVars
        for j= 1:nVars
            for k= 1:2
                yout = [yout yin(:,i).*yin(:,j).*sin(k*yin(:,1:2)) yin(:,i).*yin(:,j).*cos(k*yin(:,1:2))];
            end
        end
    end
end