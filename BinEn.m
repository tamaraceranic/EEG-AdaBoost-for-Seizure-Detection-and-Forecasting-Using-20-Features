function BEN_r = BinEn(timeseries1,timeseries2)
% Skoric T., Mohamoud O., Milovanovic B., Japundzic-Zigon N., Bajic D.,
% Binarized cross-approximate entropy in crowdsensing environment,
% Computers in Biology and Medicine,Volume 80,2017,Pages 137-147,ISSN 0010-4825,https://doi.org/10.1016/j.compbiomed.2016.11.019.

% timeseries1, timeseries2 - for cross-entropy shoud be different time
% series
% r = threshold value
% m = segment size; 
% te = delay, te = 1
% timeseries2=timeseries1;

[n1,n2] = size(timeseries1);
N = max(n1,n2)-4;

x = timeseries1;
y = timeseries2;
clear timeseries1; clear timeseries2;
for i = 1:N+3;
    if x(i+1)-x(i) <= 0
        timeseries1(i) = 0;
    else
        timeseries1(i) = 1;
    end
    if y(i+1)-y(i) <= 0
        timeseries2(i) = 0;
    else
        timeseries2(i) = 1;
    end
end
    

for i = 1:2^4
    for j = 1:4
        HIST1(i,j) = 0;
        HIST2(i,j) = 0;
    end
end


m = 1;
for j = 1:N
    for k = 1:m
        vek1(k) = timeseries1(j+k-1);
        vek2(k) = timeseries2(j+k-1);
    end
    NN1 = bindec(vek1,m)+1;
    NN2 = bindec(vek2,m)+1;
    HIST1(NN1,m) = HIST1(NN1,m) + 1;
    HIST2(NN2,m) = HIST2(NN2,m) + 1;
    if j < N
       HIST1s(NN1,m) = HIST1(NN1,m);
       HIST2s(NN2,m) = HIST2(NN2,m);
    end
end
clear vek1; clear vek2;

m = 2;
for j = 1:N
    for k = 1:m
        vek1(k) = timeseries1(j+k-1);
        vek2(k) = timeseries2(j+k-1);
    end
    NN1 = bindec(vek1,m)+1;
    NN2 = bindec(vek2,m)+1;
    HIST1(NN1,m) = HIST1(NN1,m) + 1;
    HIST2(NN2,m) = HIST2(NN2,m) + 1;
    if j < N
       HIST1s(NN1,m) = HIST1(NN1,m);
       HIST2s(NN2,m) = HIST2(NN2,m);
    end
end
clear vek1; clear vek2;

m = 3;
for j = 1:N
    for k = 1:m
        vek1(k) = timeseries1(j+k-1);
        vek2(k) = timeseries2(j+k-1);
    end
    NN1 = bindec(vek1,m)+1;
    NN2 = bindec(vek2,m)+1;
    HIST1(NN1,m) = HIST1(NN1,m) + 1;
    HIST2(NN2,m) = HIST2(NN2,m) + 1;
    if j < N
       HIST1s(NN1,m) = HIST1(NN1,m);
       HIST2s(NN2,m) = HIST2(NN2,m);
    end
end
clear vek1; clear vek2;

m = 4;
for j = 1:N
    for k = 1:m
        vek1(k) = timeseries1(j+k-1);
        vek2(k) = timeseries2(j+k-1);
    end
    NN1 = bindec(vek1,m)+1;
    NN2 = bindec(vek2,m)+1;
    HIST1(NN1,m) = HIST1(NN1,m) + 1;
    HIST2(NN2,m) = HIST2(NN2,m) + 1;
    if j < N
       HIST1s(NN1,m) = HIST1(NN1,m);
       HIST2s(NN2,m) = HIST2(NN2,m);
    end
end
clear vek1; clear vek2;

for j = 1:2^4
    HISTOGRAM(j,1) = j;
end
HISTOGRAM(:,2:5) = HIST1;
HISTOGRAM(:,6:9) = HIST2;

for i = 1:10
    for j = 1:16
        p(j,i) = 0;
        ps(j,i) = 0;
    end
end
H=[];
m = 1;
% H = xlsread('HDist1My.xlsx');
H = [0, 1; 1, 0];
for r = 0:m-1
    for k = 1:2^m
        sum = 0;
        for n = 1:2^m
            if H(k,n) <= r
                p(k,r+1) = p(k,r+1) + HIST2(n,m);
            end
        end
        p(k,r+1) = p(k,r+1)/(N);
    end
end
clear H;

m = 2;
% H = xlsread('HDist2My.xlsx');

H=[0	1	1	2;
1	0	2	1;
1	2	0	1;
2	1	1	0];


for r = 0:m-1
    for k = 1:2^m
        sum = 0;
        for n = 1:2^m
            if H(k,n) <= r
                p(k,r+2) = p(k,r+2) + HIST2(n,m);
            end
        end
        p(k,r+2) = p(k,r+2)/(N);
    end
end
clear H;

m = 3;
% H = xlsread('HDist3My.xlsx');
H = [0	1	1	2	1	2	2	3;
1	0	2	1	2	1	3	2;
1	2	0	1	2	3	1	2;
2	1	1	0	3	2	2	1;
1	2	2	3	0	1	1	2;
2	1	3	2	1	0	2	1;
2	3	1	2	1	2	0	1;
3	2	2	1	2	1	1	0];

for r = 0:m-1
    for k = 1:2^m
        sum = 0;
        for n = 1:2^m
            if H(k,n) <= r
                p(k,r+4) = p(k,r+4) + HIST2(n,m);
            end
        end
        p(k,r+4) = p(k,r+4)/(N);
    end
end
clear H;

m = 4;
% H = xlsread('HDist4My.xlsx');
H = [0	1	1	2	1	2	2	3	1	2	2	3	2	3	3	4;
1	0	2	1	2	1	3	2	2	1	3	2	3	2	4	3;
1	2	0	1	2	3	1	2	2	3	1	2	3	4	2	3;
2	1	1	0	3	2	2	1	3	2	2	1	4	3	3	2;
1	2	2	3	0	1	1	2	2	3	3	4	1	2	2	3;
2	1	3	2	1	0	2	1	3	2	4	3	2	1	3	2;
2	3	1	2	1	2	0	1	3	4	2	3	2	3	1	2;
3	2	2	1	2	1	1	0	4	3	3	2	3	2	2	1;
1	2	2	3	2	3	3	4	0	1	1	2	1	2	2	3;
2	1	3	2	3	2	4	3	1	0	2	1	2	1	3	2;
2	3	1	2	3	4	2	3	1	2	0	1	2	3	1	2;
3	2	2	1	4	3	3	2	2	1	1	0	3	2	2	1;
2	3	3	4	1	2	2	3	1	2	2	3	0	1	1	2;
3	2	4	3	2	1	3	2	2	1	3	2	1	0	2	1;
3	4	2	3	2	3	1	2	2	3	1	2	1	2	0	1;
4	3	3	2	3	2	2	1	3	2	2	1	2	1	1	0
];

for r = 0:m-1
    for k = 1:2^m
        sum = 0;
        for n = 1:2^m
            if H(k,n) <= r
                p(k,r+7) = p(k,r+7) + HIST2(n,m);
            end
        end
        p(k,r+7) = p(k,r+7)/(N);
    end
end
clear H;

for i = 1:16
    PP(i,1) = i;
end
PP(:,2:11) = p;

jj = 0;
for m = 1:4
    for r = 0:m-1
        jj = jj + 1;
        SUM1 = 0;
        SUM2 = 0;
        SUM3 = 0;
        for i = 1:2^m
            if p(i,jj) > 0
                SUM1 = SUM1 + HIST1(i,m);
                SUM2 = SUM2 + HIST1(i,m)*log(p(i,jj));
                SUM3 = SUM3 + HIST1(i,m)*(p(i,jj));
            end
        end
        FI(m,r+1) = SUM2/SUM1;
        PSI(m,r+1) = SUM3/SUM1;
    end
end

for m = 1:3
    for r = 1:m
        A(m,r) = FI(m,r) - FI(m+1,r);
        S(m,r) = log(PSI(m,r)/PSI(m+1,r));
    end
end

% for i = 1:4
%     for j = 1:6
%         BEN(i,j) = 1;
%     end
% end
% BEN(1,2) = 2;
% BEN(1,3) = 2;
% BEN(1,4) = 3;
% BEN(1,5) = 3;
% BEN(1,6) = 3;
% BEN(2,3) = 2;
% BEN(2,5) = 2;
% BEN(2,6) = 3;

jj = 0;
for m = 1:3
    for r = 1:m
        jj = jj + 1;
        BEN(1,jj) = A(m,r);
        BEN(2,jj) = S(m,r);
    end
end
BEN_r=BEN(2,2);