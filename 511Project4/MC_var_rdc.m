% Variance Reduction Methods for Monte Carlo
clear; close all

expected_value = integral(@(x) sin(x)./log(x), 2, 10);

N = 1000;
V = 8;
%% pure MC 
U = V * rand(N, 1) + 2;

f_samples = sin(U) ./ log(U);

M = mean(f_samples);
I = V * M;
% Err = V/sqrt(N) * sqrt( 1/(N-1) * sum((O - M).^2) );
sigma = sqrt( var(M * f_samples) / N );
fprintf('Pure MC gives:\n%f, with error: %f\nExpected value: %f\n',...
    I, sigma, expected_value);
fprintf('------------------------------------------\n');

%% stratification

stratum = [2 3.12 6.25 9.5 10];
weights = [0.2 0.40 0.35 0.05];
weights = ceil(weights / sum(weights));

k = length(weights);
volum = zeros(k, 1);
I_str = zeros(k, 1);
sigma_2_str = zeros(k, 1);

for i = 1 : k
    volum(i) = stratum(i + 1) - stratum(i);
    u = stratum(i) + volum(i) * rand(N * weights(i), 1); 
    f_samples_str = sin(u) ./ log(u); % use the same vector for all loops
    I_str(i) = volum(i) * mean(f_samples_str);
    % test
    fprintf('I(%d) = %f, expected = %f\n', i, I_str(i),...
        integral(@(x) sin(x)./log(x), stratum(i), stratum(i + 1)));
    sigma_2_str(i) = var( volum(i) / (N * weights(i)) * f_samples_str );
end

fprintf('Stratification(Integration) gives:\n%f, with error: %f\n',...
    sum(I_str), sqrt( sum(sigma_2_str) ) );
    
fprintf('------------------------------------------\n');    
%% Importance Sampling
% integrand
g = @(x) sin(x) ./ log(x);

% proposal distribution model
dist = gmdistribution([2.3; 4.6; 7.8], cat(3, .5, .5, .5), [.3, .3, .3]);
r = cdf(dist, 10) - cdf(dist, 2); % the prob in the middle
% proposal function
proposal = @(x) pdf(dist, x) / r;
% sample from the proposal
x_samples = random(dist, N);

% rule out the outrangers
x_samples = x_samples .* (x_samples >= 2 & x_samples <= 10);
x_acc = x_samples(x_samples > 0);

% compute weights
w = 1 ./ proposal(x_acc);
% w = w / sum(w);

f = g(x_acc);

I_is = mean( f .* w );

fprintf('Importance sampling gives:\n%f\n', I_is);





