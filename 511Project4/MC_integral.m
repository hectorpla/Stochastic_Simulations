% MC Integration
clear

% N = 1000;
expected_value = integral2(@(x, y) (x-1).^2 + 100 * (y - x.^2).^2, -1, 1, -1, 1);

N = [10 100 1000 10000 100000];
count = 1;
for n = N
X = 2 * rand(n, 1) - 1;
Y = 2 * rand(n, 1) - 1;

f_sample = (X-1).^2 + 100 * (Y-X.^2).^2;

M = mean( f_sample );
I = 4 * M; % integrate through x,y that belongs to [-1 1]

% refer to the tutorial: equation 10
sigma(count) = sqrt( var(4 * f_sample) / n ); % F(x) = volum * f(x)

fprintf('%d: I = %f, sigma = %f, expected = %f\n', n, I, sigma(count),...
     expected_value);
count = count + 1;
end

scatter(N, sigma);
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');