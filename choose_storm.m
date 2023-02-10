clear all, close all, clc
me_tm=[];
numb=1;
for k=1:2263
    a=num2str(k);
    namefile=['storm',a,'.dat'];
    st=load(namefile);
    [siz miz]=size(st);
% if max(st(:,1))>=1&siz>=5 %st(:,1) - высота волны; siz - длительность шторма (5 - 12 часов)
if siz>=5 & st(siz,1) < max(st(:,1)) %siz - длительность шторма (5 - 12 часов)
    g=num2str(numb);
    namefile=['ch_storm',g,'.dat'];
    dlmwrite(namefile,st);
    movefile(namefile,'ch_storm')  
    st=[];
    numb=numb+1;
end
end
 