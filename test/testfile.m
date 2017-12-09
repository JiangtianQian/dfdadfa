edgeList = xlsread('political_edge.xlsx');

triads = xlsread('country.xlsx');
changed = [];
% the value of A
A = 14;
% the value of B
B = 5;
%function [edgeList, changed] = propBalanced(edgeList, triads, A, B, changed)
    T =[];
    len = size(triads);
    l1 = len(1);
    for i = 1 : 1 :l1
        if ismember(A,triads(i,:)) && ismember(B, triads(i,:))
            tmp = [triads(i,1),triads(i,2),triads(i,3)];
            indexA = find(tmp == A, 1);
            indexB = find(tmp == B,1);
            indexC = 6 - indexA -indexB;
            Tarray = [tmp(1,indexA), tmp(1,indexB) tmp(1,indexC)];
            T = [T; Tarray];
        end
    end
    
    if size(T,1) > 0
        T = sortrows(T,3);
    end
    

    lenE = size(edgeList);
    lE = lenE(1);
    for i = 1 : lE
        if ismember(A,edgeList(i,:)) && ismember(B, edgeList(i,:))
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
       c = 0;

       relationAB = 0;
       relationBC = 0;
       relationAC = 0;
       flagAB = 0;
       flagBC = 0;
       flagAC = 0;
       

       for l = 1 : lE
            if ismember(AA,edgeList(l,:)) && ismember(BB, edgeList(l,:))
                relationAB = edgeList(l,3);
                flagAB = 1;
            end
            if ismember(BB,edgeList(l,:)) && ismember(CC, edgeList(l,:))
                relationBC = edgeList(l,3);
                flagBC = 1;
            end
            if ismember(AA,edgeList(l,:)) && ismember(CC, edgeList(l,:))
                relationAC = edgeList(l,3);
                flagAC = 1;
            end
            if flagAB == 1 && flagBC == 1 && flagAC == 1 
                break
            end
       end

       balanced = relationAB * relationBC * relationAC;
       if balanced > 0
           changed = [changed; [AA,BB,CC]];
       else
           lengthC = size(changed,1);
           tmpABC1 = [];
           tmpABC2 = [];
%            flag1 = 0; 
%            flag2 = 0;
           if size(changed,1) == 0
               continue
           end
           for j = 1 :lengthC
               if ~ismember(AA, changed(j,:)) ||  ~ismember(CC, changed(j,:))
                   tmpABC1 = [tmpABC1; [AA, CC, relationAC, AA + CC]];
                   break
               end
           end 
%            if flag1 == 0
%                tmpABC1 = sortrows(tmpABC1,[3,4]);
%                [edgeList,changed] = propBalanced(edgeList, triads, tmpABC1(1,1) , tmpABC1(1,2), changed);
%            end
           
           for j = 1 :lengthC
               if ~ismember(BB, changed(j,:)) ||  ~ismember(CC, changed(j,:))
                   tmpABC2 = [tmpABC2; [BB, CC, relationBC, BB + CC]];
                   break
               end
           end
           
           tmpp = [tmpABC1; tmpABC2];
           if size(tmpp) == 0
               continue
           end
           tmpp = sortrows(tmpp,[3,4]);
           [edgeList,changed] = propBalanced(edgeList, triads, tmpp(1,1) , tmpp(1,2), changed);
%            if flag2 == 0
%                tmpABC2 = sortrows(tmpABC2,[3,4]);
%                [edgeList,changed] = propBalanced(edgeList, triads, tmpABC2(1,1) , tmpABC2(1,2), changed);
%            else
%                continue
%            end   
        end    
    end
    %end


