% goodness of fit for question 3 project 4
function err = compute_chi_2(X)
    m = length(X);
    
    bins = [0 0.06 0.15 0.8 0.94 1];
    weights = [0.2343 0.2022 0.2172 0.1775 0.1708];
    E = m * weights;
    O = zeros(size(weights));
    
    for i = 1 : 5
        O(i) = length( find(X >= bins(i) & X < bins(i+1)) );    
    end
    
    err = sum( (O - E).^2 ./ E );

end