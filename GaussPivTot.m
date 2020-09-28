function [x,t] = GaussPivTot(A, b)
  
  if(nargin==2)
      [o,nefolosit] = size(b);
        if o==1
            b = transpose(b);
        end

    A = [A,b];
  end
  
  putere=0;
  [n,m] = size(A);
  x_indice = 1:n;
  
  for k = 1 : n - 1
    p=k;
    m=k;
    for i = k : n
      for j = k : n
        if abs(A(i, j)) > abs(A(p, m))
          p=i;
          m=j;
        end 
      end 
    end 
    
    if A(p,m) == 0
      disp('Sistem incompatibil sau sistem compatibil nedeterminat');
      return;
    end 
    
    if (p~=k)
      A([p,k], :) = A([k,p], :);
      putere=putere+1;
    end 
    
    if (m~=k)
      A(:,[m,k])=A(:,[k,m]);
      x_indice([m,k])=x_indice([k,m]);
      putere=putere+1;
    end 
    
    for l=k+1:n
      A(l, :)=A(l, :)-((A(l,k)/A(k,k))*A(k, :));
    end 
    
  end 
  
  if(nargin==2)
    if A(n,n)==0
        disp('Sistem incompatibil sau sistem compatibil nedeterminat');
        return;
    end
    y = SubsDesc(A(1: n, 1: n), A(:, n + 1));
  
    for i = 1: n
        x(x_indice(i)) = y(i);
    end
  else 
      x=A;
      t=putere;
  end 
end