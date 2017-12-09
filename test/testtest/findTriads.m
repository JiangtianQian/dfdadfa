function [Triads sign] = findTriads(fn)
% triads = findTriads(edgeList)
%   This function returns the set of all Triadic relationships given a
%   undirected network edgelist with weights in the Gephi format
%   Source,Target,Type,Weight with one header line
% Input: 
%   edgeList - the filename for the edgelist being used
% Output:
%   triads   - a cell array of 1x3 cell arrays containing the names of the
%              nodes within each triad.
%   sign     - a matrix of 1's and -1's denoting the relationship between
%              the ith node and the i+1 node in that row (and the last value
%              denotes the relationship between the first and last nodes).
%
% Example Output:
%  Triad =                                             sign =
%       'Russian Tsarlag'  'Chrome'  'Death Grips'          -1   1  -1
%
% In this case, we can see that three of my favorite bands have the
% following triadic relationship according to the output,
%
%                       'Russian Tsarlag'
%                              / \
%                             /   \
%                            /     \
%                          -1      -1
%                          /         \
%                         /           \
%                        /             \
%                 'Chrome'----- 1 -----'Death Grips'
%
% From sign(1) we know that the relationship between 'Russian Tsarlag' and
% 'Chrome' is -1. From sign(2) we know that the relationship between
% 'Chrome' and 'Death Grips' is 1. From sign(3) we know that the
% relationship between 'Death Grips' and 'Russian Tsarlag' is -1.
%
% C.Walsh  >:)

    %Load file
    fd = fopen(fn);
    T = textscan(fd, '%s%s%s%s', 'delimiter', ',','HeaderLines',1);
    fclose(fd);
    
    %Get Relationship values
    V = cellfun(@str2num,[T{4}]);
    %Get unique node names
    U = unique([T{1}; T{2}]);
    T = [T{1} T{2}];
    
    %Assign node names node numbers
    Un = 1:length(U);
    Tn = zeros(size(T));
    for n = 1:size(T,1)
        Tn(n,1) = find(ismember(U, T(n,1)));
        Tn(n,2) = find(ismember(U, T(n,2)));
    end
    
    %Extract Triads
    A_explored = [];
    triads = [];
    %Iterate over all nodes
    for A = 1:length(Un)
        %Get children (neighbors) of A
        [r c] = ind2sub(size(Tn), find(Tn == A));
        ind = sub2ind(size(Tn), r, 2.^(2-c));
        children = Tn(ind);
        %Iterate over all children
        for b = 1:length(children)
            B = children(b);
            if sum(ismember(A_explored,B))
                continue;
            end
            %Get grandchildren (B neighbors) of A
            [r c] = ind2sub(size(Tn), find(Tn == B));
            ind = sub2ind(size(Tn), r, 2.^(2-c));
            grandchildren = Tn(ind);
            %Iterate over grandchildren of A (B neighbors)
            for c = 1:length(grandchildren)
                C = grandchildren(c);
               if sum(ismember(A_explored,C)) || C==A
                   continue;
               end
               %Get greatgrandchildren (C neighbors) of A
               [r c] = ind2sub(size(Tn), find(Tn == C));
               ind = sub2ind(size(Tn), r, 2.^(2-c));
               greatgrandchildren = Tn(ind);
               %Is A a neighbor of the grandchild (A greatgranchild of itself)?
               if sum(ismember(greatgrandchildren,A))
                   if isempty(triads)
                       %Add to triad list
                       triads = [triads ; A , B, C];
                   elseif isempty(intersect(perms([A B C]), triads, 'rows'))
                       %Add to triad list
                       triads = [triads ; A , B, C];
                   end
               end
            end
        end
        A_explored = [A_explored , A];
    end
    
    %Convert Node IDs to Node Names
    Triads = cell(size(triads,1),3);
    for k = 1:size(triads,1)
       Triads{k,1} = U{triads(k,1)};
       Triads{k,2} = U{triads(k,2)};
       Triads{k,3} = U{triads(k,3)};
    end
    
    %Get Relationships
    sign = zeros(size(triads,1),3);
    for k = 1:size(Triads,1)
        ind = find(sum(ismember(T, {Triads{k,1} Triads{k,2}}), 2) == 2);
        sign(k,1) = V(ind);
        ind = find(sum(ismember(T, {Triads{k,2} Triads{k,3}}), 2) == 2);
        sign(k,2) = V(ind);
        ind = find(sum(ismember(T, {Triads{k,1} Triads{k,3}}), 2) == 2);
        sign(k,3) = V(ind);
    end
    
end
    


