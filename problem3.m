%% problem 3
I = dlmread('Intensity.txt');
Q = 10;
D = 0.2;
maxTmp = max(I);
maxValue = max(maxTmp);
S = Q*(I/maxValue);
R = log(S)/D;
R(R < 0) = 0;
edgeList = [];
vna = [];
N = 512;
map = zeros(N*N,2);
% Recursive though the whole matrix
for i = 1:N
    for j = 1:N
        Rij = R(i,j);
        if Rij > 0 
            for m = 1 : N
              for n = 1 : N
                % avoid self-loop
                if (m == i && n == j) 
                    continue
                end
                % Find i and j in the influence range
                if abs(m -i) < Rij && abs(n - j) < Rij && I(m,n) > 0
                    source = (i - 1) * N + j;
                    target = (m - 1)* N + n;
                    edgeList = [edgeList; [source , target]];
                    % record the source and target
                    if (map(source,1) == 0 && map(target,1) == 0)
                        map(source,1) = 1;
                        map(target,1) = 1;
                        vna = [vna; [(i-1)*N + j, i,j,(i-1)*N + j]];
                    end
                end
              end
            end
        else
            continue;
        end      
    end
end
