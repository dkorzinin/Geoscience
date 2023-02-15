clear all, close all, clc
numb=1
mon=[];
for k=1:1355
    a=num2str(k);
    namefile=['ch_storm',a,'.dat'];
    st=load(namefile);
    g=num2str(numb);
    eval(['storm_',num2str(numb),'= st;'])% variable with dynamic name
    numb=numb+1;
end

result = ['save(' char(39) 'all_storms.mat' char(39)];
for ii = 1:(numb-1)
   result = [result ', ' char(39) 'storm_' num2str(ii) char(39)];
end
result = [result ');'];
eval(result);

