[Triads, sign] = findTriads('political_EdgeList.csv');
length = size(sign,1);
count = 0;
for i = 1:length
    result = sign(i, 1) * sign(i, 2) * sign(i, 3);
    if result < 0
        count = count + 1;
    end
end