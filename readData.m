    [number,txt,raw] = xlsread('political_EdgeList.xlsx');

    %Load file
    fd = fopen('political_EdgeList.csv');
    T = textscan(fd, '%s%s%s%s', 'delimiter', ',','HeaderLines',1);
    fclose(fd);
    
    %Get Relationship values
    V = cellfun(@str2num,[T{4}]);
    %Get unique node names
    U = unique([T{1}; T{2}]);
    T = [T{1} T{2}];
    
    %Assign node names node numbers
    Un = 1:length(U);
    Tn = zeros(size(T));
    for n = 1:size(T,1)
        Tn(n,1) = find(ismember(U, T(n,1)));
        Tn(n,2) = find(ismember(U, T(n,2)));
    end
    edgeList1 = [Tn,number];
    
        [triads sign] = findTriads('political_EdgeList.csv');
    c1 = cellfun(@(x) x,triads(:,1),'UniformOutput',false);
    c2 = cellfun(@(x) x,triads(:,2),'UniformOutput',false);
    c3 = cellfun(@(x) x,triads(:,3),'UniformOutput',false);
    U1 = unique([c1; c2; c3]);
    T1 = [c1 c2 c3];
    Un1 = 1:length(U1);
    Tn1 = zeros(size(T1));
    for n = 1:size(T1,1)
        Tn1(n,1) = find(ismember(U1, T1(n,1)));
        Tn1(n,2) = find(ismember(U1, T1(n,2)));
        Tn1(n,3) = find(ismember(U1, T1(n,3)));
    end
    
    change = []
    
[edgeList changed] = propBalance(edgeList1,Tn1,5,1,changed);
    


    


