mu1=[0;0];
sigma1=[1 1; 1 8];
m1=chol(sigma1);
x1=repmat(mu1,1,400)+m1'*randn(2,400);
mu2=[4;0];
sigma2=[1 1 ; 1 8];
m2=chol(sigma2);
x2=repmat(mu2,1,400)+m2'*randn(2,400);
plot(x1(1,:),x1(2,:),'mx',x2(1,:),x2(2,:),'ko');
axis([-6 10 -8 8]);
title('Question 4');
%%
mu1=[0;0];
sigma1=[1 1; 1 8];
m1=chol(sigma1);
x1=repmat(mu1,1,400)+m1'*randn(2,400);
mu2=[4;0];
sigma2=[2 0 ; 0 2];
m2=chol(sigma2);
x2=repmat(mu2,1,400)+m2'*randn(2,400);
plot(x1(1,:),x1(2,:),'mx',x2(1,:),x2(2,:),'ko');
axis([-6 10 -8 8]);
title('Question 4');
%%
syms x
fun = -exp(-x) - 4*x + 2 == 0;
solve(fun,x)
%%
syms x
fun = 0.5 + 2 *x*x - 2 *x + exp(-x) - 1 == 0;
solve(fun,x);
y = 0.5 + 2 * 0.199 *0.199 - 2*0.199
%%
exp(-0.199)/(-4 *0.199 + 2)
%%
syms x
fun = -exp(-x) - 2 * x + 1 == 0;
solve(fun,x)