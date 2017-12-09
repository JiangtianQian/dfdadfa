%%
A = xlsread('modularity.xlsx');
scatter(A(:,1),A(:,2));
title('Modularity as a function of # communities');
xlabel('Number of communities');
ylabel('Value of modularity');
%%
figure
hold on
Nb = [97,39,20,12,6,4,3];
Lb = [3,5,7,9,11,13,15];

plot(log(Lb),log(Nb));
xlabel('lb');
ylabel('Nb');
title('Number of boxes Nb versus Lb');