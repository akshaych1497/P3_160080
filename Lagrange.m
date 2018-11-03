function yout  = Lagrange( x,y,n,m,xin )
%LAGRANGE Summary of this function goes here
%   Detailed explanation goes here

fstr='0';
for i=1:n
    str='1';
    for j=1:n
        if(j==i)
            continue;
        end
        
        str=strcat(str,sprintf('*((x-%f)/(%f-%f))',x(j),x(i),x(j)));
    end
    lagstr{i}=cellstr(str);
    fstr=strcat(fstr,sprintf('+(%f*',y(i)),lagstr{i},')');
end
L=inline(fstr{1},'x');
for i=1:m
    yout(i)=L(xin(i));
end
fh=str2func(strcat('@(x)',fstr{1}));
figure(1);
plot(x,y,'or');
hold on
fplot(fh,[x(1) x(n)]);
xlabel('x');
ylabel('y');
title('Plot of Lagrange polynomial');
grid;
hold off
legend('Data','Lagrange');
end

