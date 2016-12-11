% importance Sampling, sampling from gmdistribution

function [I, error] = isMCI(f_handle, dist, left, right, budget, num_I)
if left > right
    fprintf('integral: left should be less than right');
    return
end
N = budget;
I = zeros(num_I, 1);
r = cdf(dist, 10) - cdf(dist, 2); % the prob in the middle
% proposal function
proposal = @(x) pdf(dist, x) / r;


for i = 1 : num_I
    % sample from the proposal
    x_samples = random(dist, N);
    x_samples = x_samples .* (x_samples >= left & x_samples <= right);
    x_acc = x_samples(x_samples > 0);
    % compute weights
    w = 1 ./ proposal(x_acc);
    
    f = f_handle(x_acc);
    I(i) = mean( f .* w );
end
    error = var(I);
end