function [ c,coeffd ] = Leastsquare( x,y,n,deg )
%LEASTSQUARE Summary of this function goes here
%   Detailed explanation goes here
A=zeros(deg+1,deg+1);
c=zeros(deg+1,1);
b=zeros(deg+1,1);

for i=1:deg+1
    for j=1:deg+1
        s=0;
        for k=1:n
            s=s+((x(k))^(i+j-2));
        end
        A(i,j)=s;
    end
    s=0;
    for k=1:n
        s=s+(((x(k))^(i-1))*y(k));
    end
    b(i)=s;
end
c=inv(A)*b;
avg=double(sum(y)/n);
st=double(0);
for k=1:n
    st=st+(y(k)-avg)^2;
end
sr=0.0;
for k=1:n
    s=0;
    for i=1:deg+1
        s=s+(c(i)*((x(k))^(i-1)));
    end
    sr=sr+(y(k)-s)^2;
end
fstri='0';
for i=1:deg+1
    fstri=strcat(fstri,sprintf('+(%f*x^(%d))',c(i),i-1));
end
coeffd=((st-sr)/st);
fh=str2func(strcat('@(x)',fstri));
figure(1);
plot(x,y,'or');
hold on
arr=sort(x);
fplot(fh,[arr(1) arr(n)]);
xlabel('x');
ylabel('y');
title('Plot of Least square fitting polynomial');
grid;
hold off
legend('Data','Fitting polynomial');
end

