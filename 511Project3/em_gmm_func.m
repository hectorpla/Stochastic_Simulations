function [iter, alpha, mu, sigma]  = em_gmm_func(Y, max_iter)

% X = importdata('old_fainthful_geyser_data.txt');
% Y = X(:,2:3);

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

L_history = zeros(100,1);
L_history(2) = computeLogLikelihood(Y, mu, sigma, alpha);
iter = 2;

%% Loop
while abs(L_history(iter) - L_history(iter - 1)) > 1e-4 && iter < max_iter
    
    % E-step
    gammas = computeGammas(Y, mu, sigma, alpha);
    n = sum(gammas);
    
    % M-step
    alpha = n / sum(n);
    
    for j = 1 : k
        mu(j,:) = 1 / n(j) * sum(repmat(gammas(:,j),1,dim) .* Y);
    end
    
    for j = 1 : k
        sigma(:,:,j) = zeros(dim);
        for i = 1 : m
            sigma(:,:,j) = sigma(:,:,j) +...
                gammas(i,j) * (Y(i,:) - mu(j,:))' * (Y(i,:) - mu(j,:));
        end
        sigma(:,:,j) = sigma(:,:,j) / n(j);
    end
        
    % compute log-likelihood
    iter = iter + 1;
    L_history(iter) = computeLogLikelihood(Y, mu, sigma, alpha);
    
end

% Sort centroids: this sort only applies to 2 dimentional random vectors
[mu, row_index] = sortrows(mu);
tmpa = alpha(row_index);
alpha =tmpa;
tmp = cat(3,sigma(:,:,row_index));
sigma = tmp;

end