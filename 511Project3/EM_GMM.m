close all; clear;
% Y = importdata('cen2cen_1.dat');
X = importdata('old_fainthful_geyser_data.txt');
Y = X(:,2:3);

m = size(Y,1);
dim = size(Y,2);
k = 2; % making assumption that there are two components of the distribution

%% Initialization

% Randomly choosing k points from the sample as the initial mu
% mu = Y(randi(m,2,1),:);

% Use K-means to find means instead
mu = kmeans(Y,k,10,false);

% Initialize covariance matrix
sigma = cat(3,eye(dim));
for iter = 1 : k - 1
    sigma = cat(3,sigma,eye(dim));
end

% Initialize weights
alpha = ones(1,k) / k;


% plot estimation
    minY1 = min(Y(:,1));
    maxY1 = max(Y(:,1));
    minY2 = min(Y(:,2));
    maxY2 = max(Y(:,2));
    scatter(Y(:,1),Y(:,2), 42, '.b');
    hold on;
    estGMM = gmdistribution(mu,sigma,alpha);
    ezcontour(@(x,y)pdf(estGMM,[x y]),[minY1 maxY1],[minY2 maxY2]);
    hold off;

pause;

L_history = zeros(100,1);
L_history(2) = computeLogLikelihood(Y, mu, sigma, alpha);
iter = 2;

max_iter = 15;
%% Loop
while abs(L_history(iter) - L_history(iter - 1)) > 1e-4 && iter < max_iter
    
    % E-step
    gammas = computeGammas(Y, mu, sigma, alpha);
    n = sum(gammas);
    
    % M-step
    alpha = n / sum(n);
    % disp(alpha);
    
    for j = 1 : k
        mu(j,:) = 1 / n(j) * sum(repmat(gammas(:,j),1,dim) .* Y);
    end   
    % disp(mu);
    
    for j = 1 : k
        sigma(:,:,j) = zeros(dim);
        for i = 1 : m
            sigma(:,:,j) = sigma(:,:,j) +...
                gammas(i,j) * (Y(i,:) - mu(j,:))' * (Y(i,:) - mu(j,:));
        end
        sigma(:,:,j) = sigma(:,:,j) / n(j);
    end
    
    % disp(sigma);
    
    % plot estimation
    scatter(Y(:,1),Y(:,2), 42, '.b');
    hold on;
    estGMM = gmdistribution(mu,sigma,alpha);
    ezcontour(@(x,y)pdf(estGMM,[x y]),[minY1 maxY1],[minY2 maxY2]);
    hold off;
    pause;
    
    % compute log-likelihood
    iter = iter + 1;
    L_history(iter) = computeLogLikelihood(Y, mu, sigma, alpha);
    
end 

% plot likelihood history
figure;
plot(0:iter - 2, L_history(2:iter));

% print results
fprintf('Iteration times: %d\n', iter - 2);
fprintf('alpha:\n');
disp(alpha);
fprintf('mu:\n');
disp(mu);
fprintf('sigma: ');
disp(sigma);
