function [x] = GaussPivTotala(A, b)

%GaussPivTotala rezolva sisteme patratice de ec. liniare

%Synopsis [x] = GaussPivTotala(A,b)

%Input: A este matricea patratica asociata sistemului
%       b este vectorul termenilor liberi

%Output: x este vectorul solutie

[n,m] = size(A);
if n~=m
    error('Matricea nu este patratica')
    x=[];
    return
end

%Verificare daca b are aceeasi dimensiune ca A
if length(b)~=n
    error('Vectorul b are o alta dimensiune')
    x=[];
    return
end

if length(b)==size(b,2)
    b=transpose(b);
end

A=[A b];
index=[1:n];
for k = 1:n-1
    var_max = abs(A(k,k));
    p=k;
    m=k;
    for i = k:n
        for j = k:n
            if abs(A(i,j)) > var_max
                var_max = abs(A(i,j));
                p=i;
                m=j;
            end
        end
    end
    if var_max == 0
        error("Sist. incomp./comp. nedeterminat");
        x=[];
        return
    end
    if p ~= k
        A([p,k], :) = A([k,p], :);
    end
    if m ~= k
        A( :,[m,k]) = A( :,[k,m]);
        index([m,k]) = index([k,m]);
    end
    for l = k+1:n
        mlk = A(l,k)/A(k,k);
        A(l,:) = A(l,:) - mlk*A(k, :);
    end
end
    if A(n, n)==0
    error('Sistemul nu admite solutie unica');
    x=[];
    return
    end


y=SubsDesc(A(:,1:n),A(:,n+1));
for i=1:n
    x(index(i))=y(i);
end

end

