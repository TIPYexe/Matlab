function [ interval ] = CautaIntervale( f,a,b,N )
x=linspace(a,b,N+1)
k=0;
    for i=1:N
        if( sign(f(x(i)))~= sign(f(x(i+1))))
            k=k+1;
            interval(k,1)=x(i);
            interval(k,2)=x(i+1);
        elseif f(x(i))==0
            x(i)=x(i)+(b-a)/(2*N);
        end
    end
end

