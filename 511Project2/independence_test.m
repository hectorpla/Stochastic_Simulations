close all; clear; clc;

%% find envelope for X~HN(1) (exp(1))
x = 0:.01:10;
hnDis = makedist('Normal');
hnPdf = 2 * pdf(hnDis, x);

plot(x, hnPdf);
hold on;
plot(x, 1.5 * exp(-x), 'r'); % the envelope function is simply 1.5*exp(1)
xlabel('X1','FontSize',15);
ylabel('pdf and its envelope','FontSize',15);

%% RNG X1
N = 1000;
factor = 5;

v = rand(1, N * factor); % test
cand = -log(rand(1, N * factor)); % inverse of exp(1)

acptIdx = find(v <= 2 * pdf(hnDis, cand) ./ exp(-cand) ./ 1.5, 1000, 'first'); % test
X1 = cand(acptIdx);
figure;
hist(X1, 50);
xlabel('X1','FontSize',15);
ylabel('Frequency','FontSize',15);
disp(acptIdx(end));

%% RNG X2
betDis = makedist('Beta','a',2,'b',5);

cand_2 = rand(1,N * factor);
v_2 = 2.5 * rand(1,N * factor);

acptIdx_2 = find(v_2 <= pdf(betDis, cand_2), 1000, 'first');
X2 = cand_2(acptIdx_2);

figure;
hist(X2, 50);
xlabel('X2','FontSize',15);
ylabel('Frequency','FontSize',15);
%% Idependent Test
figure; scatter(X1,X2,'x');
xlabel('X1','FontSize',15);
ylabel('X2','FontSize',15);

% divide two set of random variable into bins
bin1 = zeros(1,6);
bin2 = zeros(1,6);
for i = 0 : 5
    bin1(i + 1) = min(X1) + i * (max(X1) - min(X1)) / 5;
    bin2(i + 1) = min(X2) + i * (max(X2) - min(X2)) / 5;
end

hold on;
for i = 2 : 5
    plot([bin1(i) bin1(i)], [min(X2) max(X2)], '-r')
    plot([min(X1) max(X1)], [bin2(i) bin2(i)], '-r');
end
hold off;

% find frequencies in each 5 bins respectively for X1 and X2 and compute
% expected values in each tile
freq_X1 = zeros(1, 5);
freq_X2 = zeros(1, 5);
for i = 1 : 5
    freq_X1(i) = size(find(X1 >= bin1(i) & X1 < bin1(i + 1)), 2);
    freq_X2(i) = size(find(X2 >= bin2(i) & X2 < bin2(i + 1)), 2);
end
freq_X1(5) = freq_X1(5) + size(find(X1 == max(X1)), 2);
freq_X2(5) = freq_X2(5) + size(find(X2 == max(X2)), 2);

E = zeros(5);
for i = 1 : 5
    for j = 1 : 5
        E(i,j) = freq_X1(i) .* freq_X2(j) / N;
    end
end

% find the joint probabilities in each tile
O = zeros(5);

for i = 1 : 5
    if i == 5
        p1 = X1 >= bin1(i) & X1 <= bin1(i + 1);
    else
        p1 = X1 >= bin1(i) & X1 < bin1(i + 1);
    end
    for j = 1 : 5
        if j == 5
            p2 = X2 >= bin2(j) & X2 <= bin2(j + 1);
        else
            p2 = X2 >= bin2(j) & X2 < bin2(j + 1);
        end 
        O(i,j) = size(find(p1 & p2), 2);
    end
end

%% Chi-Square method to compute

X_sq = sum(sum((O - E).^2 ./ E));

if X_sq > 26.296;
    fprintf('Reject: Two set of RN are not independent.\n');
else 
    fprintf('Accept: Two set of RN are not independent. (%d) < 26.296\n',X_sq);
end