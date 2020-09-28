function [InvA,DetA] = InvDet(A)

n=size(A, 1);

A_aux=A;
[C,putere]=GaussPivTot(A_aux);
prod=1;

for i=1:n
    prod = prod * C(i,i);
end

for i=1:n
        for j=1:n
            if i~=j
                I(i,j) = 0;
            else
                I(i,j) = 1;
            end
        end
    end
    
    Ae = [A,I];
    
    GaussPivTot(Ae);
    GaussPivTot(A);
    
    for i=1:n
        Inv(:, i)=GaussPivTot(A,Ae(:,i+n));
    end
    InvA=Inv;
    DetA=((-1)^putere)*prod;  
end