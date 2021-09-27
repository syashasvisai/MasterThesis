function yout = poolData(yin,nVars,polyorder,usesine,polysine)
% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton
% For Paper, "Discovering Governing Equations from Data: 
%        Sparse Identification of Nonlinear Dynamical Systems"
% by S. L. Brunton, J. L. Proctor, and J. N. Kutz

n = size(yin,1);
sk = 1;
sj = 1; 
% yout = zeros(n,1+nVars+(nVars*(nVars+1)/2)+(nVars*(nVars+1)*(nVars+2)/(2*3))+11);

ind = 1;
% % poly order 0
% yout(:,ind) = ones(n,1);
% ind = ind+1;

% poly order 1
for i=1:nVars
    yout(:,ind) = yin(:,i);
    ind = ind+1;
end

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

if(usesine)
    for k=1:sk
        yout = [yout sin(k*yin(:,1:sj)) cos(k*yin(:,1:sj))];
    end
end

% % sin^2 and cos^2
% if(usesine)
%     for k=1:sk
%         yout = [yout sin(k*yin(:,1:sj)).^2 cos(k*yin(:,1:sj)).^2];
%     end
% end

% % sin*cos
% if(usesine)
%     for k = 1:sk
%         for i = 1:sj
%             for j = 1:sj
%                 yout = [yout sin(k*yin(:,i)).*cos(k*yin(:,j))];
%             end
%         end
%     end
% end
% 
% ti*sin , ti*cos
if(polysine)
    for i=1:nVars-2
        for k= 1:sk
            yout = [yout yin(:,i).*sin(k*yin(:,1:sj)) yin(:,i).*cos(k*yin(:,1:sj))];
        end
    end
end

% % ti*tj*sin, ti*tj*cos
% if(polysine)
%     for i=1:nVars-1
%         for j= i:nVars-1
%             for k= 1:sk
%                 yout = [yout yin(:,i).*yin(:,j).*sin(k*yin(:,1:sj)) yin(:,i).*yin(:,j).*cos(k*yin(:,1:sj))];
%             end
%         end
%     end
% end


% % ti*tj*sin^2, ti*tj*cos^2
% if(polysine)
%     for i=1:nVars-1
%         for j= i:nVars-1
%             for k= 1:sk
%                 yout = [yout yin(:,i).*yin(:,j).*sin(k*yin(:,1:sj)).^2 yin(:,i).*yin(:,j).*cos(k*yin(:,1:sj)).^2];
%             end
%         end
%     end
% end
% 
% % ti*tj*sin^2*cos^2
% if(polysine)
%     for i=1:nVars-1
%         for j= i:nVars-1
%             for k= 1:sk
%                 yout = [yout yin(:,i).*yin(:,j).*sin(k*yin(:,1:sj)).^2.*cos(k*yin(:,1:sj)).^2];
%             end
%         end
%     end
% end