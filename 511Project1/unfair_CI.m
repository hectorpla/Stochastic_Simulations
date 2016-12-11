close all; clear; clc;

load unfair_coin.out

N = size(unfair_coin,1);
M = 1000;

bootStrap = unfair_coin(randi(N,N,M));

meanBS = mean(bootStrap);
% stem(meanBS);

sortedMean = sort(meanBS);
CI = sortedMean([25 975]);
fprintf('The confidence interval is between:');
disp(CI);

fprintf('The data that fall into CI are:\n');
isCI = find(unfair_coin >= CI(1) & unfair_coin <= CI(2));
disp(unfair_coin(isCI));