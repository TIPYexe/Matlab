function [x] = SubsDesc(A,b)
%SubsDesc rezolva sisteme de ecuatii liniare superior triunghiulare

%Synopsis (rezumat): [x] = SubsDesc(A,b)

%Input: A = matricea superior triunghiulara
%       b = vectorul termenilor liberi

%Output: x = vectorul solutie

[n,m] = size(A); 
%----- Verifica daca matricea A este patratica
if n~=m
    warning('Matricea nu este patratica')
    x = [];
    return
end

%----- Verficam daca matricea A este superior triunghiulara
for i = 2:n
for j = 1:i-1
    if A(i,j)~=0
        error('Matricea nu este superior triunghiulara')
        x=[];
        return
    end
end
end

%-----Verificam daca sistemul este compatibil determinat
for i= 1:n
    if A(i,i) == 0
        error('Sistemul nu aadmite solutie unica')
        x=[];
        return
    end
end

%----- Verificam daca numarul de elemente al vectorului b este egal cu
% dimensiunea matricei

if n~=length(b)
    error('Vectorul b are un numar de elemente diferit de dim matricei')
    x=[];
    return
end

x(n) = b(n)/A(n,n);
k = n-1;
while k>0
    sum=0;
    for j = k+1:n
        sum = sum + A(k,j)*x(j);
    end
    x(k) = 1/A(k,k) * (b(k) - sum);
    k=k-1;
end
end

