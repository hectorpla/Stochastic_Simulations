close all; clear; clc;

load NJGAS.dat

N = size(NJGAS,1);
M = 1000;

bootStrap = NJGAS(randi(N,N,M));

meanBS = mean(bootStrap);
% stem(meanBS);

sortedMean = sort(meanBS);
CI = sortedMean([25 975]);
fprintf('The confidence interval is between:');
disp(CI);

fprintf('The data that fall into CI are:\n');
isCI = find(NJGAS >= CI(1) & NJGAS <= CI(2));
disp(NJGAS(isCI));

