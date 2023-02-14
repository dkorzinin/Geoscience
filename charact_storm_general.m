close all, clear all, clc

storm_char = [];
for k=1:1355
    a=num2str(k);
    namefile=['ch_storm',a,'.dat'];
    storm=load(namefile);
%     создаем массив характеристик штормов
    [nn mm] = size(storm);
    t = (nn*3)-3;
    maxh = max(storm(:,1));
    meanh = mean(storm(:,1));
    stdh = std(storm(:,1));
    maxT = max(storm(:,2));
    meanT = mean(storm(:,2));
    stdT = std(storm(:,2));
    meand = mean(storm(:,3));
    stdd = std(storm(:,3));
    month = storm(1,5);
    storm_id = k;
    char = [storm_id month t maxh meanh stdh maxT meanT stdT meand stdd];
    storm_char = [storm_char; char];
%     обнуляем
    char = [];
end

dlmwrite('storm_char_choose.txt',storm_char);