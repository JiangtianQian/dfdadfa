function [edgeList,changed] = propBalance(edgeList, triads, A, B, changed)
    T = zeros(0,3);
    len = length(triads);
    for i = 1 : len
       if ismember(A,triads(i,:))
           if ismember(B,triads(i,:))
               %get C
               indexC = intersect(find(triads(i,:) ~= A),find(triads(i,:) ~= B));
               %get A
               indexA = find(triads(i,:) == A);
               indexB = find(triads(i,:) == B);

               t = zeros(1,3);
               t(1) = triads(i,indexC); %1:C
               t(2) = triads(i,indexA); %2:A
               t(3) = triads(i,indexB); %3:B
               %append to T
               T = [T; t];
           end
       end       
    end
    T = sortrows(T,1); %sort based on C
    
    %Update relationship between A & B
    for i = 1 : size(edgeList,1)
      if ismember(A,edgeList(i,1:2)) && ismember(B,edgeList(i,1:2))
         edgeList(i,3) = -edgeList(i,3);
      end
    end

    len2 = length(T);
    for i = 1 : len2
        t = T(i,:);
        flag = 0;
        for j = 1 : size(changed,1)
            if ismember(t(1),changed(j,:)) && ismember(t(2),changed(j,:)) && ismember(t(3),changed(j,:))    %has been in changed
                flag = 1;
            end
        end
        
        if flag == 1
            continue;
        end
        
        [ifbalanced] = isBalanced(edgeList, t);

        if ifbalanced > 0    %is balance
            changed = [changed; t];
            
        else
            edgeInfo = zeros(0,3);
            edgeInfo(1,1) = t(1);
            edgeInfo(1,2) = t(2);
            edgeInfo(2,1) = t(1);
            edgeInfo(2,2) = t(3);
            
            x = 0;
            y = 0;
            for j = 1 : size(edgeList,1)
                if ismember(t(1),edgeList(j,1:2)) && ismember(t(2),edgeList(j,1:2))
                    x = edgeList(j,3);
                    break;
                end
            end
            for j = 1 : size(edgeList,1)
                if ismember(t(1),edgeList(j,1:2)) && ismember(t(3),edgeList(j,1:2))
                    y = edgeList(j,3);
                    break;
                end
            end
            edgeInfo(1,3) = x;
            edgeInfo(2,3) = y;
            
            edgeInfo(1,4) = edgeInfo(1,1) + edgeInfo(1,2);
            edgeInfo(2,4) = edgeInfo(2,1) + edgeInfo(2,2);
            
            edgeInfo = sortrows(edgeInfo,[3,4]);
            
            flag1 = 0;
            flag2 = 0;
            for j = 1:size(changed,1)
                if ismember(edgeInfo(1,1), changed(j,:)) && ismember(edgeInfo(1,2), changed(j,:))
                    flag1 = 1;
                    break;
                end
            end
            for j = 1:size(changed,1)
                if ismember(edgeInfo(2,1), changed(j,:)) && ismember(edgeInfo(2,2), changed(j,:))
                    flag2 = 1;
                    break;
                end
            end
            
            if flag1 == 0
                [edgeList,changed] = propBalance(edgeList, triads, edgeInfo(1,1) , edgeInfo(1,2), changed);
            elseif flag2 == 0
                 [edgeList,changed] = propBalance(edgeList, triads, edgeInfo(2,1), edgeInfo(2,2), changed);
            end
                
            
        end
    end
end
