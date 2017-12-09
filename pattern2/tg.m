%% Problem 1(1)
load('Facedata.mat');
tic;
for i = 1 :10
    set(:,i) = double(reshape(facedata{1,i},1,[])');
end
mean_value = mean(set,2);
mean_shape = reshape(mean_value,56,46);
for i = 1 : 10
    S(:,i) = set(:,i) - mean_value;
end
Conv = cov(S');
[eigenvector,~]=eig(Conv);
Val = flip(eigenvector,2);
figure
for i=1:10
    subplot(3,4,i);
    imagesc(reshape(Val(:,i),56,46));
end
subplot(3,4,11);
imagesc(mean_shape);
title('Mean image.')
colormap('gray');
toc;
%% Problem 1(4)
load('Facedata.mat');
tic;
for i = 1 :10
    set(:,i) = double(reshape(facedata{1,i},1,[])');
end
mean_value = mean(set,2);
mean_shape = reshape(mean_value,56,46);
for i = 1 : 9
    S(:,i) = set(:,i) - mean_value;
end
P=S'*S;   
[eigenvector,eigenvalue]=eig(P);  
%normalization
Vec = S * eigenvector;
Vec = fliplr(Vec);
norm = -1*normc(Vec);
figure
for i=1:9  
Eigenface=reshape(norm(:,i),[56,46]);  
subplot(3,4,i);
imagesc(Eigenface); 
end
subplot(3,4,10);
imagesc(mean_shape);
title('Mean image')
colormap('gray');
toc;
%% Problem 2 (7)
load('Facedata.mat');
df = double(facedata{1,1});
rs = reshape((df - mean_shape),1,[]) * norm;
e = zeros(9,1);
mnv = mean_value;
figure
for i=1:9
    mnv = mnv + (rs(i) * norm(:,i));
    subplot(3,4,i)
    rsh = reshape(df,1,[]);
    e(i) = sum((mnv-rsh').^2/2576);
    imagesc(reshape(mnv,56,46));
    title(sprintf('MSE=%f',e(i)));
    
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
c11=c1 - repmat(mean_value,1 , size (c1 ,2)); 
c22=c2 - repmat(mean_value,1 , size (c2 ,2)); 
setc=[c11,c22];
S=setc * setc'./size(setc,2);
[E,~] = eig(S);
E = flip(E,2);
C=cross([0;0;1], [E(: ,1) ;0]);
Cr=C(1:2 ,1);
Cr=Cr/norm(Cr);
w=-Cr'*mean_value;
pr=@(x1,x2) Cr(1)*x1+Cr(2)*x2+w; 
ezplot(pr ,[0 ,7 ,0 ,5]) ;
axis equal;
pv=E(:,1)*(E(:,1)'*setc)+repmat(mean_value,1,size(setc,2));
for i=1:size(pv,2)
    plot([c(1,i);pv(1,i)],[c(2,i);pv(2,i)],'black');
end
%(c)
e=sum(sum((c - pv).^2,1) ,2)/size(c,2);
%(d)
p1=E(:,1)'*c11; 
p2=E(:,1)'*c22; 
m1=mean(p1,2); 
m2=mean(p2,2); 
v1=(p1 - m1) ; 
v2=(p2 - m2) ; 
r1=(v1 * v1')/size(v1,2); 
r2=(v2 * v2')/size(v2,2);
V = (m1 - m2) ^2/( r1+r2 )
plot(c1(1,:),c1(2,:),'bx',c2(1,:),c2(2,:),'ro'); 
axis equal;
title(sprintf('MSE=%f, FR=%f',e,V));
%% problem 4 LDA
figure ; 
hold on;
c1=[2 ,2 ,2;1 ,2 ,3]; 
c2=[4 ,5 ,6;3 ,3 ,4]; 
c=[c1,c2];
mean_value = mean(c,2);
c11=c1 - repmat(mean_value,1 , size (c1 ,2)); 
c22=c2 - repmat(mean_value,1 , size (c2 ,2)); 
setc=[c11,c22];
m1=mean(c1,2);
m2=mean(c2,2);
SP = (m1 - m2) * (m1 - m2)';
Z1=zeros(size(c1,1)); 
for i=1:size(c1,2)
Z1=Z1+(c1(:,i) - m1) * (c1(:,i) - m1)'; 
end
Z1=Z1./size(c1,2); 
Z2=zeros(size(c2,1)); 
for j=1:size(c2,2)
Z2=Z2+(c2(:,j) - m2) * (c2(:,j) - m2)'; 
end
Z2=Z2./size(c2,2); 
Z=Z1+Z2;
[S,~]=eigs (SP,Z) ;
S=flip(S,2);
S(:,1)=S(:,1)/norm(S(:,1));
cro=cross([0;0;1],[S(:,1);0]); 
cr=cro(1:2 ,1) ;
cr=cr/norm(cr); 
w= -(cr' * mean_value);
pr=@(x1,x2) cr(1)*x1+cr(2)*x2+w; 
ezplot(pr ,[0 ,6 ,0 ,6]) ;
axis equal;
V=S(:,1)*(S(:,1)'*setc)+repmat(mean_value,1,size(setc,2));
for i=1:size(V,2) 
    plot([c(1,i);V(1,i)],[c(2,i);V(2,i)],'black');
end
e = sum(sum((c - V).^2,1) ,2)/size(c,2)
p1=S(:,1)' * c11; 
p2=S(:,1)' * c22; 
m1=mean(p1,2); 
m2=mean(p2,2); 
v1=(p1 - m1); 
v2=(p2 - m2); 
r1=(v1 * v1')/size(v1,2); 
r2=(v2 * v2')/size(v2,2);
rslt = (m1 - m2) ^2/( r1+r2 )
plot(c1(1,:),c1(2,:),'bx',c2(1,:),c2(2,:),'ro');
title(sprintf('FR=%f, MSE=%f',rslt,e));


