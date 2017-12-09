function [edgeList changed] = propBalance(edgeList, triads, A, B, changed)
T =[];
len = size(triads);
for i = 1 : len(1)
    if 
    if (ismember(A,triads(:,1)) && ismember(B,triads(:,2))) || (ismember(A,triads(:,2)) && ismember(B,triads(:,1)))
        T = [T; [triads(:,1),triads(:,2),triads(:,3)]];
    end
    
end
end

