function [ifbalanced] = isBalanced(edgeList, t)
%UNTITLED2 Summary of this function goes here
edge = [];
j = 0;
for i = 1 : size(edgeList,1)
  if ismember(t(1),edgeList(i,1)) && ismember(t(2),edgeList(i,2))
     edge(1, j) = edgeList(i, 3);
     j = j+1;
  end
end
ifbalanced = edge(1, :) * edge(1, 2) * edge(1, 3);
end