function yout = natural_Spline( x,y,n,m,xin )
%SPLINE Summary of this function goes here
%   Detailed explanation goes here

a=zeros(n-2,n-2);
b=zeros(n-2,1);
c=zeros(n-2,1);
for i=2:n-1
    if(i==2)
        a(i-1,i-1)=2*(x(i+1)-x(i-1));
        a(i-1,i)=x(i+1)-x(i);
    elseif(i==n-1)
        a(i-1,i-1)=2*(x(i+1)-x(i-1));
        a(i-1,i-2)=x(i)-x(i-1);
    else
        a(i-1,i-2)=x(i)-x(i-1);
        a(i-1,i-1)=2*(x(i+1)-x(i-1));
        a(i-1,i)=x(i+1)-x(i);
    end
    b(i-1)=6*(((y(i+1)-y(i))/(x(i+1)-x(i)))-((y(i)-y(i-1))/(x(i)-x(i-1))));
end
c=inv(a)*b;
sdd(1)=0;
sdd(n)=0;
for i=2:n-1
    sdd(i)=c(i-1);
end
for i=1:m
    for k=1:n-1
        if((x(k+1)>xin(i))&&(x(k)<xin(i)))
            p=k;
        end
    end
    
    yout(i)=(((((x(p+1)-xin(i))^3)*sdd(p))+(((xin(i)-x(p))^3)*sdd(p+1)))/(6*(x(p+1)-x(p))))+((x(p+1)-xin(i))*((y(p)/(x(p+1)-x(p)))-((x(p+1)-x(p))*sdd(p)/6)))+((xin(i)-x(p))*((y(p+1)/(x(p+1)-x(p)))-((x(p+1)-x(p))*sdd(p+1)/6)));
end
figure(1);
plot(x,y,'or');
hold on
for i=1:m
    firco=sprintf('+(((%f/(%f-%f))-((%f-%f)*%f/6))*(%f-x))',y(i),x(i+1),x(i),x(i+1),x(i),sdd(i),x(i+1));
    secco=sprintf('+(((%f/(%f-%f))-((%f-%f)*%f/6))*(x-%f))',y(i+1),x(i+1),x(i),x(i+1),x(i),sdd(i+1),x(i));
    thco=sprintf('(((((%f-x)^3)*%f)+(((x-%f)^3)*%f))/(6*(%f-%f)))',x(i+1),sdd(i),x(i),sdd(i+1),x(i+1),x(i));
    
    fstr=strcat(thco,firco,secco);
    fh=str2func(strcat('@(x)',fstr));
    fplot(fh,[x(i) x(i+1)],'b');
    hold on
end
xlabel('x');
ylabel('y');
title('Plot of Cubic Spline');
grid;
hold off
legend('Data','Spline');
end

