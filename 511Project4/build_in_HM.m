clear; close all

% rng default;  % For reproducibility
pd1 = makedist('Beta', 'a', 1, 'b', 8);
pd2 = makedist('Beta', 'a', 9, 'b', 1);

pdf = @(x) 0.6 * pdf(pd1, x) + 0.4 * pdf(pd2, x);% Target distribution
sigma = 0.5;
proppdf = @(x,y) normpdf(y, x, sigma);
proprnd = @(x) x + randn(1) * sigma;
nsamples = 5000;
smpl = mhsample(1,nsamples,'pdf',pdf,'proprnd',proprnd,...
                'proppdf',proppdf);
            
            
compute_chi_2(smpl);
hist(smpl, 80);
figure; hist(smpl(1:1000), 80);