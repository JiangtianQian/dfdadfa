function [ifbalanced] = isBalanced(edgeList, t)
%UNTITLED2 Summary of this function goes here
e1 = 0;
e2 = 0;
e3 = 0;
for i = 1 : size(edgeList,1)
  if ismember(t(1),edgeList(i,1:2)) && ismember(t(2),edgeList(i,1:2))
     e1 = edgeList(i, 3);
  end
  if ismember(t(3),edgeList(i,1:2)) && ismember(t(2),edgeList(i,1:2))
     e2 = edgeList(i, 3);
  end
  if ismember(t(1),edgeList(i,1:2)) && ismember(t(3),edgeList(i,1:2))
     e3 = edgeList(i, 3);
  end
end
ifbalanced = e1 *e2 *e3;
end
