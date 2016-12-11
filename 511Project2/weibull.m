close all; clear; clc;

%% plot cdf and pdf
a = 2;
q = 0:.01:5; p = 0:.002:1;
f_wb = a * q.^(a - 1).* exp(-q.^ a);
F_wb = 1 - exp(-q.^a);
F_wbInv = (-log(1 - p)).^(1/a);

plot(q,f_wb);
xlabel('X','FontSize',15);
ylabel('fX','FontSize',15);
figure;
plot(q,F_wb);
xlabel('X','FontSize',15);
ylabel('FX','FontSize',15);

%figure; 
% plot(p,F_wbInv);

N = 1000;
x = rand(N,1);
wbX = (-log(1 - x)).^(1/a);
figure;
hist(wbX, 50);
xlabel('X','FontSize',15);
ylabel('Frequency','FontSize',15);

bins = (-log(1 - [.2 .4 .6 .8])).^(1/a); % test | [.5 1 1.5 2]
E = zeros(1, 5);
%% compute the expected values each bins
E(1) = 1 - exp(-bins(1)^a);
for i = 2:4
    E(i) = 1 - exp(-bins(i)^a) - (1 - exp(-bins(i - 1)^a));
end
E(5) = 1 - (1 - exp(-bins(4)^a));
E = E.* N;
disp(E);

%% find the observed values each bins
O = zeros(1,5);

sorted_wbX = sort(wbX);
for i = 1:4
    O(i) = find(sorted_wbX > bins(i), 1, 'first');
    if i > 1
        O(i) = O(i) - sum(O(1:i-1));
    end
end
O(5) = N - sum(O(1:4));
disp(O);

%% calculate the divation

X_2 = ((O - E).^2) ./ E;

% in chi-square table, the X^2 value at 5% for degrees of freedom 4 is 9.488 
if sum(X_2) > 9.488;
    fprintf('Reject: the data is not Weibull distributed\n');
else 
    fprintf('Accept: the data is Weibull distributed (%d) < 9,488\n',sum(X_2));
end


