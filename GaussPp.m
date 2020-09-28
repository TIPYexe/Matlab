function [x] = GaussPp(A,b)
%GaussPp rezolva sisteme patratice de ecuatii liniare

%Synopsis: [x] = GaussPp(A,b)
%INPUT: A = matrice patratica
%       b = vectorul termenilor liberi

%OUTPUT: x = vectorul solutie

[n,m] = size(A); 
%----- Verifica daca matricea A este patratica
if n~=m
    warning('Matricea nu este patratica')
    x = [];
    return
end

%----- Verificam daca numarul de elemente al vectorului b este egal cu
% dimensiunea matricei

if n~=length(b)
    error('Vectorul b are un numar de elemente diferit de dim matricei')
    x=[];
    return
end

%----- Verificam daca vectorul b este coloana, daca nu este il transpunem
[t,y] = size(b);
if t==1
    b = transpose(b);
end

%---- Construim matricea extinsa
%Ae = matricea extinsa
    Ae = A;
for i=1:n
    Ae(i,n+1) = b(i);
end

% Alta varianta
% concatenare
    Ae = [A,b];
    
for k = 1:n-1
    maxim = abs(Ae(k,k));
    p = k;
    for j = k:n
        if maxim< abs(Ae(j,k))
            maxim = abs(Ae(j,k));
            p = j;
        end
    end
    
    if maxim==0
        error('Sistemul este incompatibil sau compatibil nedeterminat')
        x=[];
        return
    end
    
% Daca p e diferit de k, interschimb liniile p si k
    if k~=p
        aux = Ae(p, 1:n+1);
        Ae(p, 1:n+1) = Ae(k, 1:n+1);
        Ae(k, 1:n+1) = aux;
    end
    
% sau
%    Ae([k,p], 1:n+1) = Ae([p,k], 1:n+1);
    
%Transformam toate elementele de sub pivot in 0

for l = k+1:n
    mlk = Ae(l,k)/maxim;
    Ae(l, 1:n+1) = Ae(l, 1:n+1) - mlk*Ae(k, 1:n+1);
end

end

if Ae(n,n) == 0
        error('Sistemul este incompatibil sau compatibil nedeterminat')
        x=[];
        return
end

A =  Ae(1:n, 1:n);
b = Ae(1:n, n+1);

x = SubsDesc(A,b);
x = transpose(x);

end

