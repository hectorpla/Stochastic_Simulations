% gaussian proposal function test
clear; close all
% dis = gmdistribution([2; 4.6; 7.8], cat(3, 1, .5, .5), [.3, .3, .3]);
% t = 0 : .05 : 12;
% plot(t, pdf(dis, t'));
% figure;
% hist(random(dis, 1000), 50);


% function 2
func2 = @(x) sin(x.^2);
mu = linspace(-2*pi, 2*pi, 10)';
ww = ones(1, 10);
dist2 = gmdistribution(mu, .3, ww);
t = -2 * pi: .05 : 2 * pi;
target = func2(t');
plot(t, pdf(dist2, t'));
figure; plot(t, target ./ pdf(dist2, t'));