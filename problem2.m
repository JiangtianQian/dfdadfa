%  %change edgelist to number 
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
%[triads1,sign] = findTriads('political_EdgeList.csv');
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
% set changed list

edgeList = xlsread('political_edge.xlsx');

% edgeList2 = edgeList;

triads = xlsread('country.xlsx');
changed = [];
% the value of A
A = 12;
% the value of B
B = 8;

[edgelist,changed] = propBalanced(edgeList, triads, A, B, changed);
% 
% % 
% T =[];
% len = size(triads);
% l1 = len(1);
% for i = 1 : l1
%     if ismember(A,triads(i,:)) && ismember(B, triads(i,:))
%         tmp = [triads(i,1),triads(i,2),triads(i,3)];
%         indexA = find(tmp == A, 1);
%         indexB = find(tmp == B,1);
%         indexC = 6 - indexA -indexB;
%         Tarray = [tmp(1,indexA), tmp(1,indexB) tmp(1,indexC)];
%         T = [T; Tarray];
%     end
% end
% 
% T = sortrows(T,3);
% 
% lenE = size(edgeList);
% lE = lenE(1);
% for i = 1 : lE
%     if ismember(A,edgeList(i,:)) && ismember(B, edgeList(i,:))
%         edgeList(i,3) = -1 * edgeList(i,3);
%     end
% end
% 
% lenT = size(T);
% lT = lenT(1);
% for i = 1 : lT
%    % find A B C and their index
%    tA = find(T(i,:) == A, 1);
%    tB = find(T(i,:) == B, 1);
%    tC = 6 - tA -tB;
%    
%    AA = T(i,tA);
%    BB = T(i,tB);
%    CC = T(i,tC);
%    
%    flagContinue = 0;
%    lenCC = size(changed,1);
%    for cc = 1 : lenCC
%       if ismember(AA,changed(cc,:)) && ismember(BB, changed(cc,:)) && ismember(CC, changed(cc,:))
%         flagContinue = 1;
%       end
%    end
%    if flagContinue == 1
%        continue
%    end
%    
%    lenE = size(edgeList);
%    lE = lenE(1);
%    c = 0;
%    
%    relationAB = 0;
%    relationBC = 0;
%    relationAC = 0;
%    
%    for l = 1 : lE
%         if ismember(AA,edgeList(l,:)) && ismember(BB, edgeList(l,:))
%             relationAB = edgeList(l,3);
%             c = c + 1;
%         end
%         if ismember(BB,edgeList(l,:)) && ismember(CC, edgeList(l,:))
%             relationBC = edgeList(l,3);
%             c = c + 1;
%         end
%         if ismember(AA,edgeList(l,:)) && ismember(CC, edgeList(l,:))
%             relationAC = edgeList(l,3);
%             c = c+ 1;
%         end
%         if c >= 3
%             break
%         end
%         
%    end
%    
%    balanced = relationAB * relationBC * relationAC;
%    if balanced > 0
%        changed = [changed; [AA,BB,CC]];
%    else
%        flag1 = 0; flag2 = 0;
%        lengthC = size(changed,1);
%        tmpABC = [];
%        count = 0;
%        for j = 1 :lengthC
%            if ~(ismember(AA, changed(j,:)) && ismember (CC, changed(j,:)))
%                tmpABC = [tmpABC; [AA, CC, relationAC, AA + CC]];
%                count = count + 1;
%            end
%            if ~(ismember(CC, changed(j,:)) && ismember (BB, changed(j,:)))
%                tmpABC = [tmpABC; [BB, CC, relationBC, BB + CC]];
%                count = count + 1;
%            end
%        end
%        if count == 0
%            continue
%        end
%        tmpABC = sortrows(tmpABC,[3,4]);
%        
%        [edgeList,changed] = propBalance(edgeList, triads, tmpABC(1,1) , tmpABC(1,2), changed);
%     end    
%  end
% 
% 
