clear all, close all, clc
load('all_storms.mat') % load .mat file
matrix_all=[];
% 1355
for k=1:1355
    eval(['st=','storm_',num2str(k)]);
    [n m] = size(st);
    numb = k;
    month = st(1,5);
    maxh = max(st(:,1));
    long=(n-1)*3;
    for kk=1:n
        if st(kk,1)==maxh
            % peak time
            peakt=(kk-1)*3;
            % peak point
            peakpoint = kk;
        end
    end
    longabou = long - peakt;
    abou = [];
    for kk=1:n
        if kk > peakpoint
            abou = [abou; st(kk,:)];
        end
    end
    meanabou = mean(abou(:,1));
    medabou = median(abou(:,1));
    stdabou = std(abou(:,1));
    matrix = [numb month maxh long peakt longabou meanabou medabou stdabou];
    matrix_all=[matrix_all;matrix];
    matrix=[];
end
dlmwrite('matrix.txt',matrix_all);