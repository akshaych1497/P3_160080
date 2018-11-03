
fprintf('1. Fit a least square polynimial\n');
fprintf('2. Lagrange polynomials\n');
fprintf('3. Cubic splines\n');
prompt='choose one of the methods mentioned above by entering number 1,2 or 3:';
met=input(prompt);

if(met==1)
    fileID = fopen('input_least.txt');
    c = textscan(fileID,'%d',1);
    a=textscan(fileID,'%f %f');
    fclose(fileID);

    prompt='choose the degree of polynomial: ';
    deg=input(prompt);

    [coeffic,coeffd]=Leastsquare(a{1},a{2},c{1},deg);
    fileID = fopen('output_leastsquare.txt','w');
    fprintf(fileID,'Coefficients: \n');
    fprintf(fileID,'%f\n',coeffic);
    fprintf(fileID,'\nCoefficient of determination \n');
    fprintf(fileID,'%f\n',coeffd);
    fclose(fileID);

elseif(met==2)
    fileID = fopen('input_lagrange.txt');
    c = textscan(fileID,'%d',1);
    a = textscan(fileID,'%f %f',c{1});
    m = textscan(fileID,'%d',1);
    b = textscan(fileID,'%f',m{1});
    fclose(fileID);

    yout=Lagrange(a{1},a{2},c{1},m{1},b{1});
    fileID = fopen('output_lagrange.txt','w');
    fprintf(fileID,'Interpolated values y at given x* \n\n');
    fprintf(fileID,'Lagrange Polynomials \n');
    fprintf(fileID,'%f   %f\n',b{1},yout);
    fclose(fileID);
    
elseif(met==3)
    
    spline_choice = input('What do you want?\n1.Natural Spline\n2.Not-a-Knot Spline\n3.Periodic Spline\n4.Clamped Spline: ');
    if spline_choice == 1
        %Natural Spline
        fileID = fopen('input_naturalsp.txt');
        c = textscan(fileID,'%d',1);
        a = textscan(fileID,'%f %f',c{1});
        m = textscan(fileID,'%d',1);
        b = textscan(fileID,'%f',m{1});
        fclose(fileID);
         yout=natural_Spline(a{1},a{2},c{1},m{1},b{1});
         fileID = fopen('output_naturalspline.txt','w');
         fprintf(fileID,'Interpolated values y at given x* \n\n');
         fprintf(fileID,'Cubic spline \n');
         fprintf(fileID,'%f   %f\n',b{1},yout);
         fclose(fileID);
    elseif spline_choice == 2
        %Not-a-Knot Spline
        data = input('Enter the address of the input file: ','s');
        M = dlmread(data);
        in_data = M(:,1)';
        out_data = M(:,2)';
        NKnot_spl(in_data,out_data,length(in_data)-1);
    elseif spline_choice == 3
        %Periodic Spline
        data = input('Enter the address of the input file: ','s');
        M = dlmread(data);
        in_data = M(:,1)';
        out_data = M(:,2)';
        Periodic_spl(in_data,out_data,length(in_data)-1);
    elseif spline_choice == 4
        %Clamped Spline
        data = input('Enter the address of the input file: ','s');
        M = dlmread(data);
        in_data = M(:,1)';
        out_data = M(:,2)';
        d0 = input('Enter the value of f'' at first point: ');
        dn = input('Enter the value of f'' at last point: ');
        Clamped_spl(in_data,out_data,length(in_data)-1,d0,dn);

    end
   
end
