X = importdata('old_fainthful_geyser_data.txt');
Y = X(:,2:3);
scatter(Y(:,1),Y(:,2),10,'.b')
hold on;

mu = [4.2979 80.2849; 2.0943 54.7500];
sigma = cat(3,[0.1776 0.7631; 0.7631 31.4828],[0.1543 0.9857; 0.9857 34.4075]);
p = [0.3676    0.6324];
mixed = gmdistribution(mu,sigma,p);
h = ezcontour(@(x,y)pdf(mixed,[x y]),[0 6],[30 100]);

g1 = gmdistribution(mu(1,:),sigma(:,:,1), 1);
g2 = gmdistribution(mu(2,:),sigma(:,:,2), 1);
prob1 = pdf(g1, Y);
prob2 = pdf(g2, Y);

eProb(:,1) = p(1) * prob1;
eProb(:,2) = p(2) * prob2;
myProb = compute_weight_times_phi(Y, mu, sigma, p);


p1_m = 1 / (2 * pi * det(sigma(:,:,1))^.5)...
        * exp(-1/2 * (Y(1,:) - mu(1,:)) / sigma(:,:,1) * (Y(1,:) - mu(1,:))')

p1_e = pdf(g1, Y(1,:))

%% verification
mu_t = [0 0]; sigma_t = [1 0;0 2];
gt = gmdistribution(mu_t,sigma_t, 1);
point = [5, 2];

pointmunismu = point - mu_t;
pt_m = 1 / (2 * pi * det(sigma_t)^.5) * exp(-1/2 * pointmunismu / sigma_t * pointmunismu'); 
pt_e = pdf(gt, point);

