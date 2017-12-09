round=[5,7,10,12,15];
adj_matrix=zeros(20,20);
result={adj_matrix,adj_matrix,adj_matrix,adj_matrix,adj_matrix};
for j=1:5
    start=[1,1];
    position = {start,start,start,start,start};
    for i=1:round(j)
        for k=1:5
            r=position{k};
        if(rand()<=0.9)
            if (r(1) == 1 && r(2)==1)
                C=rand();
                D=C>0.5;
                if D==1
                    rnew=r+[1 0];
                else
                    rnew=r+[0 1];
                end
            elseif (r(1) == 1 && r(2)==20)
                E=rand();
                F=E>0.5;
                if F==1
                    rnew=r+[1 0];
                else
                    rnew=r+[0 -1];
                end
            elseif (r(1) == 20 && r(2)==1)
                G=rand();
                H=G>0.5;
                if H==1
                    rnew=r+[-1 0];
                else
                    rnew=r+[0 1];
                end
            elseif (r(1) == 20 && r(2)==20)
                I=rand();
                J=I>0.5;
                if J==1
                    rnew=r+[0 -1];
                else
                    rnew=r+[-1 0];
                end
            elseif (r(1) == 20)
                K=rand();
                if K < 1/3
                    rnew=r+[0 -1];
                elseif K>2/3
                    rnew=r+[-1 0];
                else
                    rnew=r+[0 1];
                end                    
            elseif(r(2) == 1)
                L=rand();
                if L < 1/3
                    rnew=r+[1 0];
                elseif L>2/3
                    rnew=r+[-1 0];
                else
                    rnew=r+[0 1];
                end 
            elseif(r(2) == 20)
                M=rand();
                if M < 1/3
                    rnew=r+[-1 0];
                elseif L>2/3
                    rnew=r+[1 0];
                else
                    rnew=r+[0 -1];
                end 
            else
                A=rand(1,2);
                B=A>0.5;
                if B==1
                    rnew=r+[1 0];
                elseif B(1)==1
                    rnew=r+[0 1];
                elseif B(2)==1
                    rnew=r+[-1 0];
                else
                    rnew=r+[0 -1];
                end
            end
        end
        position{k}=rnew;
        count =result{j}(rnew(1),rnew(2));
        count= count +1;
        result{j}(rnew(1),rnew(2))= count;
        end      
    end
end