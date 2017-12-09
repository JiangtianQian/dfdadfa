l = xlsread('test');
l2 = xlsread('test2');
list = xlsread('ar');
source = list(:,1);
target = list(:,2);
G = graph(source,target);
deg = degree(G);

x = l(:,1);
y = l(:,2);
loglog(x,y/4157);
title('Q3 PDF of Degree Distribution')
ylabel('Probability');
xlabel('Degree'); 
figure()

f = 1 - ecdf(deg);
loglog(f);
title('Q3 Rank frequency plot of Degree Distribution')
ylabel('Probability');
xlabel('Degree'); 

%%
%Q3 c
list = xlsread('ar');
source = list(:,1);
target = list(:,2);
G = graph(source,target);
deg = degree(G);
meanValue = mean(deg);
R = exprnd(meanValue,5000,1);
f1 = 1 - ecdf(R);
loglog(f1);
title('Q3 Average Degree of Exponentially-distributed numbers')
ylabel('Probability');
xlabel('Value');

%%
%Q4 
i = 0;
L = 1;
C = 1;
    h1 = WattsStrogatz(100,2,0);
    dis1 = distances(h1);
    L=ave_path_length(dis1);
    adj1 = full(adjacency(h1));
    C = clust_coeff(adj1);   
for p = 0.0001:0.01:1
    i = i + 1;
    h = WattsStrogatz(100,2,p);
    dis = distances(h);
    dist(i,1)=ave_path_length(dis);
    adj = full(adjacency(h));
    clust(i,1) = clust_coeff(adj);
    x(i,1) = p;  
end
scatter(x,dist/L);
hold on
scatter(x,clust/C);
title('Q4')
xlabel('p');
ylabel('L(p)/L(0) & C(p)/C(0)'); 
%%
%Q5
%Scale-free
N = 1000;

for i =1:5
    old(i,1) = i;
    old(i,2) = 2;
    old(i,3) = 0.5;
end
for i = 6:N 
    new(i,1) = i;
end


sum = 10;
i = 1;
k = 6;
s(1,1) = 1;
t(1,1) = 1;
while  ~all(new == 0)
    newTarget = randi([6 N],1,1);
    if new(newTarget,1) ~= 0
        old(k,1) = newTarget;      
        new(newTarget,1) = 0;
        switchlink = rand(k - 1, 1);
        for j = 1:k - 1
           if switchlink(j,1) < old(j,3)
               sum = sum + 1;
               old(j,2) = old(j,2) + 1;
               old(j,3) = old(j,2) / sum;
               
               old(k,2) = old(k,2) + 1;
               old(k,3) = old(k,2) / sum;
        
               s(i,1) = j;
               s(i,2) = newTarget;
               i = i + 1;
           end
        end
        k = k + 1;
    end
end


list = xlsread('q5.xls');
G = graph(list(:,1),list(:,2));

adj2 = full(adjacency(G));
csvwrite('SF.txt',adj2);

%%
N = 2516;
count = 0;
j = 1;
for i = 1:1000
    source(i,1) = 1;
    target(i,1) = 1;
    source(i,2) = 0;
    target(i,2) = 0;
end

while count < N
    newTarget = randi([1 1000],2,1);
    if (source(newTarget(1,1),1) == 1 && target(newTarget(2,1),1) == 1) || (source(newTarget(1,1),2) ~= newTarget(2,1) && source(newTarget(2,1),2) ~= newTarget(1,1))
        switchlink = rand(1, 1) < 0.05;
        if ~switchlink(1,1) == 1
            count = count + 1;
            source(newTarget(1,1),1) = newTarget(1,1);
            source(newTarget(1,1),2) = newTarget(2,1);
            target(newTarget(2,1),1) = newTarget(2,1);
            target(newTarget(2,1),2) = newTarget(1,1);
            s(j,1) = newTarget(1,1);
            s(j,2) = newTarget(2,1);
            j = j + 1;
        end
    end
     
end

list = xlsread('q52222.xls');
G = graph(list(:,1),list(:,2));

adj3 = full(adjacency(G));
csvwrite('ER.txt',adj3);
%%
l = xlsread('q5degree1');
l2 = xlsread('q5degree2');

x1 = l(:,1);
y1 = l(:,2);

x = l2(:,1);
y = l2(:,2);
loglog(x1,y1/5028);
figure(x,y)
%loglog(x,y);
%%
test = xlsread('a');

G = graph(test(:,1),test(:,2));


