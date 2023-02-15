close all, clear all, clc

w=load('1979_2020.dat');
[n m]=size(w);

storm=[];
numb=1;
for t=1:n
    if w(t)>1 % wave height exceeding threshold
    storm=[storm;w(t,:)];
    if w(t)>1&w(t+1)<=1 % end of storm
    a=num2str(numb);
    namefile=['storm',a,'.dat'];
    dlmwrite(namefile,storm);
    storm=[];
    numb=numb+1;
    end
    end
end
