function [edgeList, changed] = propBalanced(edgeList, triads, A, B, changed)
T =[];
len = size(triads);
l1 = len(1);
for i = 1 : l1
    if ismember(A,triads(i,:)) && ismember(B, triads(i,:))
        tmp = [triads(i,1),triads(i,2),triads(i,3)];
        indexA = find(tmp == A, 1);
        indexB = find(tmp == B,1);
        indexC = 6 - indexA -indexB;
        Tarray = [tmp(1,indexA), tmp(1,indexB) tmp(1,indexC)];
        T = [T; Tarray];
    end
end

T = sortrows(T,3);

lenE = size(edgeList);
lE = lenE(1);
for i = 1 : lE
    if ismember(A,edgeList(i,1:2)) && ismember(B, edgeList(i,1:2))
        edgeList(i,3) = -1 * edgeList(i,3);
    end
end

lenT = size(T);
lT = lenT(1);
for i = 1 : lT
   % find A B C and their index
   tA = find(T(i,:) == A, 1);
   tB = find(T(i,:) == B, 1);
   tC = 6 - tA -tB;
   
   AA = T(i,tA);
   BB = T(i,tB);
   CC = T(i,tC);
   
   flagContinue = 0;
   lenCC = size(changed,1);
   for cc = 1 : lenCC
      if ismember(AA,changed(cc,:)) && ismember(BB, changed(cc,:)) && ismember(CC, changed(cc,:))
        flagContinue = 1;
      end
   end
   if flagContinue == 1
       continue
   end
   
   lenE = size(edgeList);
   lE = lenE(1);
   
   relationAB = 0;
   relationBC = 0;
   relationAC = 0;
   flag1 = 0;
   flag2 = 0;
   flag3 = 0;
   
   
   for l = 1 : lE
        if ismember(AA,edgeList(l,1:2)) && ismember(BB, edgeList(l,1:2))
            relationAB = edgeList(l,3);
            flag1 = 1;
        end
        if ismember(BB,edgeList(l,1:2)) && ismember(CC, edgeList(l,1:2))
            relationBC = edgeList(l,3);
            flag2 = 1;
        end
        if ismember(AA,edgeList(l,1:2)) && ismember(CC, edgeList(l,1:2))
            relationAC = edgeList(l,3);
            flag3 = 1;
        end
        if flag1 == 1 && flag2 == 1 && flag3 == 1
            break
        end
        
   end
   
   balanced = relationAB * relationBC * relationAC;
   if balanced > 0
       changed = [changed; [AA,BB,CC]];
   else  
           tmpABC = zeros(0,3);
           for j = 1 : size(edgeList,1)
               if ismember(CC,edgeList(j,1:2)) && ismember(BB,edgeList(j,1:2))
                   sign1 = edgeList(j,3);
                   break;
               end
           end
           for j = 1 : size(edgeList,1)
               if ismember(CC,edgeList(j,1:2)) && ismember(AA,edgeList(j,1:2))
                  sign2 = edgeList(j,3);
                  break;
               end
           end
                tmpABC(1,1) = CC;
                tmpABC(1,2) = BB;
                tmpABC(1,3) = sign1;
                tmpABC(1,4) = CC + BB;            
                tmpABC(2,1) = CC;
                tmpABC(2,2) = AA;
                tmpABC(2,3) = sign2;
                tmpABC(2,4) = CC + AA;

                tmpABC = sortrows(tmpABC,[3,4]);

                flag1 = 0;
                flag2 = 0;
                for j = 1:size(changed,1)
                    if ismember(CC, changed(j,:)) && ismember(BB, changed(j,:))
                        flag1 = 1;
                        break;
                    end
                end
                for j = 1:size(changed,1)
                    if ismember(CC, changed(j,:)) && ismember(AA, changed(j,:))
                        flag2 = 1;
                        break;
                    end
                end
                if flag1 == 0
                    [edgeList,changed] = propBalance(edgeList, triads, tmpABC(1,1) , tmpABC(1,2), changed);
                elseif flag2 == 0
                     [edgeList,changed] = propBalance(edgeList, triads, tmpABC(2,1), tmpABC(2,2), changed);
                end
   end
end
end