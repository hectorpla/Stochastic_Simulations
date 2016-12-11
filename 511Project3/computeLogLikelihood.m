% Compute likelihood using output from compute_w_times_phi

function L = computeLogLikelihood(y, mu, sigma, alpha)

w_times_phi = compute_weight_times_phi(y, mu, sigma, alpha);

m = size(w_times_phi, 1);

L = 1/m * sum(log(sum(w_times_phi,2)));

end