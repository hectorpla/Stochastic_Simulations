close all; clear; clc;
N = 1000;
c = 1.5; % so that the envolope covers the pdf


%% one envelope
%% vectorization of generating candidates

cand = rand(1, N * 10) * 6;
v = rand(1, N * 10);

% find the acceptance
acptIdx = find(v <= betTri(cand)./ c, 1000, 'first');
numCan = acptIdx(end);

x = cand(acptIdx);
hist(x, 50);
xlabel('X','FontSize',15);
ylabel('Frequency','FontSize',15);
title('RN Generated Using Single Uniform Envelope');


disp(numCan);


%% two envelope

% coin toss process to decide in which modal to sample
div_vec = rand(1, N * 10);
betIdx = find(div_vec <= 0.5);
triIdx = find(div_vec > 0.5);

v_2 = rand(1, N * 10);

% generate uniform random num. in each of two envelopes (with heights 1.5 and 0.5)
cand_2 = zeros(1, N * 10);
cand_2(betIdx) = rand(1, size(betIdx,2));
cand_2(triIdx) = 4 + rand(1, size(triIdx,2)) * 2;
% map back
acptBetIdx_tmp = find(v_2(betIdx) <= betTri(cand_2(betIdx))./ 1.5); % index in the new(bet) domain
acptBetIdx = betIdx(acptBetIdx_tmp);
acptTriIdx_tmp = find(v_2(triIdx) <= betTri(cand_2(triIdx))./ 0.75);
acptTriIdx = triIdx(acptTriIdx_tmp);

% find all the accpeted indexes
acptIdx_all = zeros(1, N * 10);
acptIdx_all(acptBetIdx) = 1;
acptIdx_all(acptTriIdx) = 1;

% find the first 1000 accepted indexes
acptIdx_2 = find(acptIdx_all, 1000, 'first'); 
numCan_2 = acptIdx_2(end);

x_2 = cand_2(acptIdx_2);
figure; hist(x_2, 50);
xlabel('X','FontSize',15);
ylabel('Frequency','FontSize',15);
title('RN Generated Using A Combinition of Two Seperate Uniform Envelope')

disp(numCan_2);

xx = sort(x);
find(xx > 3, 1, 'first')
xx2 = sort(x_2);
find(xx2 > 3, 1, 'first')
