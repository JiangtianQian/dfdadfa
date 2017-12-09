
clear;
clc;
close all;
NoC_10x10_400_8KCache_4fDPac =...
    dlmread('NoC_10x10_400_8KCache_4fDPac.txt');



tic
n=[10:500:30510];
F_n=[];
for i=1:length(n)
    F_n = [F_n; compute_dfa(NoC_10x10_400_8KCache_4fDPac(:,2),n(i),1)];
end
n=n';
figure;
loglog(n,F_n,'*r');
xlabel('n')
ylabel('F(n)')
A=polyfit(log(n(1:end)),log(F_n(1:end)),1);
Alpha1=A(1)
D=3-A(1)
set(gca,'FontSize',15)
toc

% clear
% packet_size =... % change to "packet_size" not "inter-arrival times"
%     dlmread('BC-Oct89Ext4.txt');
% tic
% n=[10:500:30510];
% F_n=[];
% for i=1:length(n)
%     F_n = [F_n; compute_dfa(packet_size(:,2),n(i),1)];  % (:,2)
% end
% n=n';
% hold on;
% loglog(n,F_n,'*b');
% xlabel('n')
% ylabel('F(n)')
% A=polyfit(log(n(1:end)),log(F_n(1:end)),1);
% Alpha1=A(1)
% D=3-A(1)
% set(gca,'FontSize',15)
% toc