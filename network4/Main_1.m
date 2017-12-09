function Main_1()
load('Facedata.mat');
for i = 1 :10
   class1(:,i) = double(reshape(fft2(facedata{1,i}),2576,1));
    class2(:,i) = double(reshape(facedata{1,i},2576,1));
end
u = ones(10,1);
H1 = MACE(class1,u);
H2 = ECP_SDF(class2,u);
figure;
for i = 1 :3
    R2 = fftshift(real(ifft2(fft2(reshape(H2,[56,46])).*conj(double(fft2(facedata{1,i}))))));
    subplot(2,3,i);
    surf(1:46,1:56,R2);
    title(['ECP-SDF ', num2str(i)]);
    subplot(2,3,i+3);
    R1 = real(fftshift(ifft2(reshape(H1,[56,46]).*conj(fft2(double(facedata{1,i}))))));
    surf(1:46,1:56,R1*2575);
    title(['MACE ', num2str(i)]);
end