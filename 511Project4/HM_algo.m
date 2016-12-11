% MH algorithm
clear; close all


N = 2000;
X = zeros(N, 1);
X(1) = 0.5;

% target distribution
pd1 = makedist('Beta', 'a', 1, 'b', 8);
pd2 = makedist('Beta', 'a', 9, 'b', 1);

f = @(x) 0.6 * pdf(pd1, x) + 0.4 * pdf(pd2, x);
% t = linspace(0, 1, 5000);
% plot(t, f(t'));

h1 = figure;
for i = 2 : N
    y = X(i-1) + randn(1) * 2;
    u = rand(1);
    if u <= min( f(y) / f(X(i-1)), 1 )
        X(i) = y;
    else
        X(i) = X(i-1);
    end
    
    if  mod(i,200) == 0 
        subplot(2, 5, i / 200);
        hist(X(i - 199:i), 20);
        tl = sprintf('%d: mean = %.2f, var = %.2f\nchi_square = %f',...
            i / 200, mean(X(i - 199:i)), var(X(i - 199:i)),...
            compute_chi_2(X(i - 199:i)));
        title(tl);
    end
end
set(h1, 'Position', [200 400 800 500]);

figure;
hist(X(1001:end), 50);
h2 = figure;
plot(X);
set(h2, 'Position', [250 500 800 500]);
 