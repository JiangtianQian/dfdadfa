% %change edgelist to number 
% [number,txt,raw] = xlsread('political_EdgeList.xlsx');
% fd = fopen('political_EdgeList.csv');
% T2 = textscan(fd, '%s%s%s%s', 'delimiter', ',','HeaderLines',1);
% fclose(fd);
% %Get unique node names
% U = unique([T2{1}; T2{2}]);
% T2 = [T2{1} T2{2}];
% %Assign node names node numbers
% Un = 1:length(U);
% Tn = zeros(size(T2));
% for n = 1:size(T2,1)
%     Tn(n,1) = find(ismember(U, T2(n,1)));
%     Tn(n,2) = find(ismember(U, T2(n,2)));
% end
% edgeList = [Tn,number];
% % Transfer triads to number
% [triads] = findTriads('political_EdgeList.csv');
% c1 = cellfun(@(x) x,triads(:,1),'UniformOutput',false);
% c2 = cellfun(@(x) x,triads(:,2),'UniformOutput',false);
% c3 = cellfun(@(x) x,triads(:,3),'UniformOutput',false);
% U1 = unique([c1; c2; c3]);
% T1 = [c1 c2 c3];
% Un1 = 1:length(U1);
% Tn1 = zeros(size(T1));
% for n = 1:size(T1,1)
%     Tn1(n,1) = find(ismember(U1, T1(n,1)));
%     Tn1(n,2) = find(ismember(U1, T1(n,2)));
%     Tn1(n,3) = find(ismember(U1, T1(n,3)));
% end
% triads = Tn1;
% %set changed list

edgeList = xlsread('political_edge.xlsx');
triads = xlsread('country.xlsx');

changed = [];
% the value of A
A = 6;
% the value of B
B = 7;

[edgeList, changed] = propBalance(edgeList, triads, A, B, changed);