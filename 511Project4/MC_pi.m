% MC to estimate pi/4
clear; close all;
n = 100;

Pi = zeros(50,1);
for i = 1 : 50
   Pi(i) = length( find( sum(rand(n,2).^2, 2) <= 1 ) );
end

Pi = Pi / n;
hist(Pi,10);
% mean(Pi)
% var(Pi)

%% Variance Plot
numpoints = 20;
Var = zeros(numpoints,1);
N = floor( logspace(2,6,numpoints) );

count = 1;
for j = N
    for i = 1 : 50
       Pi(i) = length( find( sum(rand(j,2).^2, 2) <= 1 ) );
    end
    Var(count) = var(Pi / j);
    fprintf('%d: %f\n', j, Var(count));
    count = count + 1;
end

figure;
scatter(N, Var);
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');
    