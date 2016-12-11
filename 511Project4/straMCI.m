% MC integration utilizing stratification
% output num_I integrations and their variance

function [I, error] = straMCI(f_handle, stratum, weights, budget, num_I)
N = budget;
if length(stratum) ~= length(weights) + 1
    fprintf('len of stratum should be 1 greater than weights\n')
    return
end
k = length(weights);
weights = ceil(weights / sum(weights)); % normalize the weights
volum = zeros(k, 1);
I_str = zeros(num_I, k); % colums: integrations of all components


for i = 1 : k
    volum(i) = stratum(i + 1) - stratum(i);
    u = stratum(i) + volum(i) * rand(N * weights(i), num_I); 
    I_str(:, i) = volum(i) * mean( f_handle( u ) )' ; % need to traspose, not optimal
end

I = sum(I_str, 2);
error = var( I );
end