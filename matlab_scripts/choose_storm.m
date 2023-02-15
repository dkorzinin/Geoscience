clear all, close all, clc
me_tm=[];
numb=1;
for k=1:2263
    a=num2str(k);
    namefile=['storm',a,'.dat'];
    st=load(namefile);
    [siz miz]=size(st);
% we choose storms with duration is greater than and equal to 12 hours, 
% as well as those storms in which the attenuation stage is distinguished
    if siz>=5 & st(siz,1) < max(st(:,1))
        g=num2str(numb);
        namefile=['ch_storm',g,'.dat'];
        dlmwrite(namefile,st);
        movefile(namefile,'ch_storm')  
        st=[];
        numb=numb+1;
    end
end
 
