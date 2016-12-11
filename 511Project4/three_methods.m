clear; close all
func1 = @(x) sin(x) ./ log(x);
func2 = @(x) sin(x.^2);

%% pure MC

[I1, err1] = pureMCI(func1, 2,10, 1000, 50);
[I2, err2] = pureMCI(func2, -2*pi, 2*pi, 1000, 50);
fprintf('pure MC:\nfunction1: I = %f, error = %f\n', I1(1), err1);
fprintf('function2: I = %f, error = %f\n', I1(2), err2);
fprintf('------------------------------------------\n'); 

%% stratified sampling
stratum = [2 3.12 6.25 9.5 10];
weights = [0.2 0.40 0.35 0.05];
[Ist1, err_str1] = straMCI(func1, stratum, weights, 1000, 50);

stratum2 = linspace(-2*pi, 2*pi, 30);
weights2 = ones(29, 1);
[Ist2, err_str2] = straMCI(func2, stratum2, weights2, 1000, 50);

fprintf('Stratified:\nfunction1: I = %f, error = %f\n', Ist1(1), err_str1);
fprintf('function2: I = %f, error = %f\n', Ist2(2), err_str2);
fprintf('------------------------------------------\n');   

%% importance sampling
dist = gmdistribution([2.3; 4.6; 7.8], cat(3, .8, .6, .5), [.3, .3, .3]);
[Iis1, err_is1] = isMCI(func1, dist, 2, 10, 1000, 50);

% mu_pos = [1.5 2.3 2.8 3.4 3.8 4.2 linspace(4.4, 6.2, 10)];
% mu = [sort(-mu_pos) mu_pos];
% mu = mu';
% ww = [ones(1,13) 1.2 1.6 2 2 1.6 1.2 ones(1,13)];
mu = [-2.3 -1.5 1.5 2.3]';
ww = [3 2 2 3];
dist2 = gmdistribution( 0, 5, 1);
[Iis2, err_is2] = isMCI(func2, dist2, -2*pi, 2*pi, 1000, 50);
subplot(2,2,1);hist(I1, 20);
subplot(2,2,2);hist(Iis1, 20);


fprintf('Importance sampling:\nfunction1: I = %f, error = %f\n', Iis1(1), err_is1);
fprintf('function2: I = %f, error = %f\n', Iis2(1), err_is2);

subplot(3,1,1);hist(I1, 20);
title('pure MCI');
subplot(3,1,2);hist(Ist1, 20);
title('stratified MCI');
subplot(3,1,3);hist(Iis1, 20);
title('important sampling MCI');


figure;
subplot(3,1,1);hist(I2, 20);
title('pure MCI');
subplot(3,1,2);hist(Ist2, 20);
title('stratified MCI');
subplot(3,1,3);hist(Iis2, 20);
title('important sampling MCI');