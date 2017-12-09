function H = MACE(class1,u)
D = diag(mean(abs(class1).^2,2));
XDX = ctranspose(class1) * (D \ class1);
h = (D \ class1) * (XDX \ u);
H = reshape(h, 2576,1);
