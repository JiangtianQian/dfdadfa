%% Problem 1(1)
load('Facedata.mat');
tic;
for i = 1 :10
    test(:,i) = double(reshape(facedata{1,i},1,[])');
end
mean_test = mean(test,2);
mean_face = reshape(mean_test,56,46);
for i = 1 : 10
    T(:,i) = test(:,i) - mean_test;
end
C = cov(T');
[eigenvector,~]=eig(C);
V = flip(eigenvector,2);
figure
for i=1:10
    subplot(3,4,i);
    imagesc(reshape(V(:,i),56,46));
end
subplot(3,4,11);
imagesc(mean_face);
title('Q2(1) Mean image of person 1.')
colormap('gray');
toc;
%% Problem 1(4)
load('Facedata.mat');
tic;
for i = 1 :10
    test(:,i) = double(reshape(facedata{1,i},1,[])');
end
mean_test = mean(test,2);
mean_face = reshape(mean_test,56,46);
for i = 1 : 9
    X(:,i) = test(:,i) - mean_test;
end
Lx=X'*X;   
[eigenvector,eigenvalue]=eig(Lx);  
%normalization
V=X * eigenvector;
V = fliplr(V);
UL = -1*normc(V);
figure
for i=1:9  
Eigenface=reshape(UL(:,i),[56,46]);  
subplot(3,4,i);
imagesc(Eigenface); 
end
subplot(3,4,10);
imagesc(mean_face);
title('Q2(4) Mean image of person 1.')
colormap('gray');
toc;
%% Problem 2 (7)
load('Facedata.mat');
f = double(facedata{1,1});
p = reshape((f - mean_face),1,[]) * UL;
mse = zeros(9,1);
m = mean_test;
figure
for i=1:9
    m = m + (p(i) * UL(:,i));
    subplot(3,4,i)
    r = reshape(f,1,[]);
    mse(i) = sum((m-r').^2/2576);
    imagesc(reshape(m,56,46));
    title(sprintf('MSE=%f',mse(i)));
    
end
colormap('gray');
%% problem 4 PCA
%(a)
figure ; 
hold on;
c1=[2 ,2 ,2;1 ,2 ,3]; 
c2=[4 ,5 ,6;3 ,3 ,4]; 
c=[c1,c2];
mean_value = mean(c,2);
cc1=c1 - repmat(mean_value,1 , size (c1 ,2)); 
cc2=c2 - repmat(mean_value,1 , size (c2 ,2)); 
cc=[cc1,cc2];
S=cc * cc'./size(cc,2);
[V,~] = eig(S);
V = flip(V,2);
tmpw=cross([0;0;1], [V(: ,1) ;0]);
w=tmpw(1:2 ,1);
w=w/norm(w);
w0=-(w'*mean_value);
fh=@(x1,x2) w(1)*x1+w(2)*x2+w0; 
ezplot(fh ,[0 ,7 ,0 ,5]) ;
axis equal;
pc=V(:,1)*(V(:,1)'*cc)+repmat(mean_value,1,size(cc,2));
for i=1:size(pc,2)
    plot([c(1,i);pc(1,i)],[c(2,i);pc(2,i)],'black');
end
%(c)
MSE=sum(sum((c - pc).^2,1) ,2)/size(c,2);
%(d)
p1=V(:,1)'*cc1; 
p2=V(:,1)'*cc2; 
pmu1=mean(p1,2); 
pmu2=mean(p2,2); 
pr1=(p1 - pmu1) ; 
pr2=(p2 - pmu2) ; 
pre1=(pr1 * pr1')/size(pr1,2); 
pre2=(pr2 * pr2')/size(pr2,2);
FR = (pmu1 - pmu2) ^2/( pre1+pre2 )
plot(c1(1,:),c1(2,:),'bo',c2(1,:),c2(2,:),'rx'); 
axis equal;
title(sprintf('MSE=%f, FR=%f',MSE,FR));
%% problem 4 LDA
figure ; 
hold on;
c1=[2 ,2 ,2;1 ,2 ,3]; 
c2=[4 ,5 ,6;3 ,3 ,4]; 
c=[c1,c2];
mean_value = mean(c,2);
cc1=c1 - repmat(mean_value,1 , size (c1 ,2)); 
cc2=c2 - repmat(mean_value,1 , size (c2 ,2)); 
cc=[cc1,cc2];
mu1=mean(c1,2);
mu2=mean(c2,2);
Sb = (mu1 - mu2) * (mu1 - mu2)';
Stmp=zeros(size(c1,1)); 
for i=1:size(c1,2)
Stmp=Stmp+(c1(:,i) - mu1) * (c1(:,i) - mu1)'; 
end
Stmp=Stmp./size(c1,2); 
S2=zeros(size(c2,1)); 
for j=1:size(c2,2)
S2=S2+(c2(:,j) - mu2) * (c2(:,j) - mu2)'; 
end
S2=S2./size(c2,2); 
Sw=Stmp+S2;
[V,~]=eigs (Sb,Sw) ;
V=flip(V,2);
V(:,1)=V(:,1)/norm(V(:,1));
tw=cross([0;0;1],[V(:,1);0]); 
w=tw(1:2 ,1) ;
w=w/norm(w); 
w0= -(w' * mean_value);
fh=@(x1,x2) w(1)*x1+w(2)*x2+w0; 
ezplot(fh ,[0 ,6 ,0 ,6]) ;
axis equal;
pc=V(:,1)*(V(:,1)'*cc)+repmat(mean_value,1,size(cc,2));
for i=1:size(pc,2) 
    plot([c(1,i);pc(1,i)],[c(2,i);pc(2,i)],'black');
end
MSE = sum(sum((c - pc).^2,1) ,2)/size(c,2)
pr1=V(:,1)' * cc1; 
pr2=V(:,1)' * cc2; 
pmu1=mean(pr1,2); 
pmu2=mean(pr2,2); 
prc1=(pr1 - pmu1); 
prc2=(pr2 - pmu2); 
ps1=(prc1 * prc1')/size(prc1,2); 
ps2=(prc2 * prc2')/size(prc2,2);
FR = (pmu1 - pmu2) ^2/( ps1+ps2 )
plot(c1(1,:),c1(2,:),'ro',c2(1,:),c2(2,:),'bx');
title(sprintf('MSE=%f, FR=%f',MSE,FR));