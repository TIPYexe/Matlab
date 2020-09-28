function [x] = SubsAsc(A,b)
%SubsAsc rezolva sisteme inferior triunghiulare

%Synopsis: [x] = SubsAsc(A,b)

%Input: A = matrice patratica de ordinul n,
%       inferior triunghiulara (aij = 0, i<j)
%       b = vectorul termenilor liberi

%Output: x = solutia sistemului

%------Vericare matrice patratica
[n,m] = size(A);
if n~=m 
    error('Matricea nu este patratica')
    x = [];
    return
end

%--- Verificare daca matricea este inferior triunghiulara
for j = 2:n
    for i = 1:j-1
        if A(i,j)~=0
            error('Matricea nu este inferior triunghiulara')
            x = [];
            return
        end
    end
end
%----Verificare incompatibilitate sistem
for i=1:n
    if A(i,i)==0
        error('Sistemul nu admite solutie unica')
        x = [];
        return
    end
end

%---Rezolvarea sistemului
x(1) = b(1)/A(1,1);
k = 2;
while k<=n
    sum = 0;
    for j = 1:k-1
        sum = sum + A(k,j)*x(j);
    end
    x(k) = 1/A(k,k)*(b(k) - sum);
    k = k + 1;
end
