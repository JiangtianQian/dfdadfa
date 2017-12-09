function F = compute_dfa(data,window,order)
N=length(data);   
n=floor(N/window);
N1=n*window;
Yn=zeros(N1,1);
fitcoef=zeros(n,order+1);
mean1=mean(data(1:N1));
y = cumsum(data(1:N1) - mean1);
if size(y,1) > 1
    y = y';
end
%for i=1:N1,
%    y(i)=sum(data(1:i) - mean1);
%end
for j=1:n
    fitcoef(j,:)=polyfit(1:window,y(((j-1)*window+1):j*window),order);
end
for j=1:n
    Yn(((j-1)*window+1):j*window)=polyval(fitcoef(j,:),1:window);
end
sum1=sum((y'-Yn).^2)/N1;
sum1=sqrt(sum1);
F=sum1;
