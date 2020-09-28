function [L,x] = FactCholesky(A,b)
    alfa =  A(1,1);
    [n,n] = size(A);
    
    %Step 1
    if alfa <= 0
        warning("A nu este pozitiv definita");
    end
    
    L(1,1) = sqrt(A(1,1));
    for i=1:n
        L(i,1) = A(i,1)/L(1,1);
    end
    
    %Step 2
    for k=2:n
        sum = 0;
        
        for s=1:k-1
            sum = sum+L(k,s)^2;
        end
        alfa = A(k,k) - sum;
        
        if alfa <= 0
            warning("A nu este pozitiv definita");
        end
        
        L(k,k) = sqrt(alfa);
    
        for i=k+1:n
            sum = 0;
            for s=1:k-1
                sum = sum+L(k,s)*L(i,s);
            end
            
            L(i,k) = (A(i,k) - sum)/L(k,k);
        end
    end
    
    y = SubsAsc(L,b);
    x = SubsDesc(transpose(L),y);
end

