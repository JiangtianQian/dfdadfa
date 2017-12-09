l = xlsread('rab');
scatter(log(l(:,1)),log(l(:,2)));
xlabel('The value of degree');
ylabel('The count of degree');
title('Degree distribution (log/log)');

%loglog(l(:,1),l(:,2));