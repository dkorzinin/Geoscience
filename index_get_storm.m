close all, clear all, clc

w=load('1979_2020.dat');

[n m]=size(w);
w = w(1:1000,:)

storm=[];
numb=1;
for t=1:n
    if w(t)>1%превышение высотой волны прогового значений
    storm=[storm;w(t,:)];
    if w(t)>1&w(t+1)<=1
    a=num2str(numb);
    namefile=['storm',a,'.dat'];
    dlmwrite(namefile,storm);
    storm=[];
    numb=numb+1;
    end
    end
end