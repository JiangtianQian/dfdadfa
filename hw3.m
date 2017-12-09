a = 0;
f_sc = 0.3;
N = 20;
simulation_length = 80;
list_spreader = {[1,1,0,0]};
matrix = zeros(20,20);
count = 0;
len = 0;
for i = 1 : simulation_length
    if numel(list_spreader) > 0
        for k = 1 : numel(list_spreader)
            len = numel(list_spreader);
            if rand() <= a && i > 1
                list_spreader(k) = [];
            else
                tmp = list_spreader{k};
                x = tmp(1);
                y = tmp(2);
                
                neighbor = {[x-1,y],[x + 1,y],[x,y+1],[x,y-1]};
                add = 0;
                for j = 1 : 4
                    
                    flag = 0;
                     if neighbor{j}(1) < 1|| neighbor{j}(2) < 1 || neighbor{j}(1) > N || neighbor{j}(2) > N
                          continue
                     else
                         for p = 1 : numel(list_spreader)
                             if list_spreader{p}(1) == neighbor{j}(1) && list_spreader{p}(2) == neighbor{j}(2)
                                 flag = 1;
                                 index = p;
                                 break
                             end
                         end
                        n = 0;
                        
                        if (rand() <= f_sc)
                            count = count + 1;
                            if flag == 1
                                list_spreader{p}(3) = list_spreader{p}(3) + 1;
                                matrix_i = list_spreader{p}(1);
                                matrix_j = list_spreader{p}(2);
                                matrix(matrix_i,matrix_j) = list_spreader{p}(3);
                            else
                            add = add + 1;
                            n = 1;
                            list_spreader{len + add} = [neighbor{j},n,1];
                            matrix_i = neighbor{j}(1);
                            matrix_j = neighbor{j}(2);
                            matrix(matrix_i,matrix_j) = n;
                            end
                         end
                    end
                end 
            end
        end
    end
end
pcolor(matrix)
title('Stochastic algorithm, pa =0, pfsc = 0.3, simulation length 80')
%% Problem 1(2)
clear all;
a = 0.002;
f_sc = 0.3;
N = 20;
simulation_length = 80;
list_spreader = {[1,1,0,0]};
matrix = zeros(20,20);
count = 0;
length = 0;
r = 0;
list_remove = {[0,0,0,0]};
for i = 1 : simulation_length
    if numel(list_spreader) > 0
        for k = 1 : numel(list_spreader)
            length = numel(list_spreader);
            
            if rand() <= a && i > 1
                if k > numel(list_spreader)
                   continue
                end
                r = r + 1;
                list_remove{r} = list_spreader{k};
                list_spreader(k) = [];
            else
                if k > numel(list_spreader)
                   continue
                end
                tmp = list_spreader{k};
                x = tmp(1);
                y = tmp(2);
                neighbor = {[x-1,y],[x + 1,y],[x,y+1],[x,y-1]};
                add = 0;

                for j = 1 : 4

                    flag = 0;
                    flag1 = 0;
                     if neighbor{j}(1) < 1|| neighbor{j}(2) < 1 || neighbor{j}(1) > N || neighbor{j}(2) > N
                          continue
                     else
                         for q = 1 : numel(list_remove)
                             if list_remove{q}(1) == neighbor{j}(1) && list_remove{q}(2) == neighbor{j}(2)
                                 flag1 = 1;
                                 break
                             end
                         end
                         if flag1 == 1
                             continue
                         end
                         for p = 1 : numel(list_spreader)
                             if list_spreader{p}(1) == neighbor{j}(1) && list_spreader{p}(2) == neighbor{j}(2)
                                 flag = 1;
                                 index = p;
                                 break
                             end
                         end

                        n = 0;
                        
                        if (rand() <= f_sc)
                            count = count + 1;
                            if flag == 1
                                list_spreader{p}(3) = list_spreader{p}(3) + 1;
                                matrix_i = list_spreader{p}(1);
                                matrix_j = list_spreader{p}(2);
                                matrix(matrix_i,matrix_j) = list_spreader{p}(3);
                            else
                            add = add + 1;
                            n = 1;
                            list_spreader{length + add} = [neighbor{j},n,1];
                            matrix_i = neighbor{j}(1);
                            matrix_j = neighbor{j}(2);
                            matrix(matrix_i,matrix_j) = n;
                            end
                         end
                    end
                end 
            end
        end
    end
end
pcolor(matrix)
title('Stochastic algorithm, pa =0.002, pfsc = 0.3, simulation length 80')

%% Problem 1(b2)
clear all;
sum = 0;
a = 0;
f_sc = 0.3;
N = 11;
simulation_length = 1000;
for s = 1 : 100
list_spreader = {[1,1,0,0]};
matrix = zeros(20,20);
len = 0;
count = 0;
for i = 1 : simulation_length
    count = count + 1;
    matrix_i = 0;
    matrix_j = 0;
    if numel(list_spreader) > 0
        for k = 1 : numel(list_spreader)
            len = numel(list_spreader);
            if rand() <= a && i > 1
                list_spreader(k) = [];
            else
                tmp = list_spreader{k};
                x = tmp(1);
                y = tmp(2);
                
                neighbor = {[x-1,y],[x + 1,y],[x,y+1],[x,y-1]};
                add = 0;
                for j = 1 : 4 
                    flag = 0;
                     if neighbor{j}(1) < 1|| neighbor{j}(2) < 1 || neighbor{j}(1) > N || neighbor{j}(2) > N
                          continue
                     else
                         for p = 1 : numel(list_spreader)
                             if list_spreader{p}(1) == neighbor{j}(1) && list_spreader{p}(2) == neighbor{j}(2)
                                 flag = 1;
                                 index = p;
                                 break
                             end
                         end
                        n = 0;
                        
                        if (rand() <= f_sc)
                            %count = count + 1;
                            if flag == 1
                                list_spreader{p}(3) = list_spreader{p}(3) + 1;
                                matrix_i = list_spreader{p}(1);
                                matrix_j = list_spreader{p}(2);
                                matrix(matrix_i,matrix_j) = list_spreader{p}(3);
                            else
                            add = add + 1;
                            n = 1;
                            list_spreader{len + add} = [neighbor{j},n,1];
                            matrix_i = neighbor{j}(1);
                            matrix_j = neighbor{j}(2);
                            matrix(matrix_i,matrix_j) = n;
                            end
                         end
                    end
                end 
            end
        end
    end
    if matrix_i == N && matrix_j == N
       break
    end
end
sum = sum + count;
end
ave = sum / 100;
