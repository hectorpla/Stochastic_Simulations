% Compute the term wj * phi(y_i|u_j,sigma_j) for k components at all sample points,
% at y_i, for i = 1, ..., m
% where wj is weight of jth component and p(yi|u_j,sigma_j) is the 2-D GMM densities 


function w_times_phi = compute_weight_times_phi(y, mu, sigma, alpha)

if size(y, 2) ~= 2
    error('The number of colums of the first argument must be two');
end

m = size(y, 1);
k = length(alpha);
w_times_phi = zeros(m, k);
for j = 1 : k
    for i = 1:m
    w_times_phi(i, j) = 1 / (2 * pi * det(sigma(:,:,j))^.5)...
        * exp( -1/2 * (y(i,:) - mu(j,:)) / sigma(:,:,j) * (y(i,:) - mu(j,:))' );
    end
end

w_times_phi = w_times_phi .* repmat(alpha, m, 1);

end
