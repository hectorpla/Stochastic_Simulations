% Compute gammas using output from compute_w_times_phi

function gammas = computeGammas(y, mu, sigma, alpha)

w_times_phi = compute_weight_times_phi(y, mu, sigma, alpha);

gammas = w_times_phi ./ repmat(sum(w_times_phi, 2), 1, 2);

end