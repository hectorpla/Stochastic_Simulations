% pure MC Integration
% output num_I integrations and their variance

function [I, error] = pureMCI(f_handle, left, right, budget, num_I)
    N = budget;
    % I = zeros(num_I, 1);
    V = right - left;
    
    if V < 0
        fprintf('arg3 should be greater than arg2\n');
        return;
    end
    
        U = left + V * rand(N, num_I);
        I = V * mean( f_handle(U) );
        I = I';
    
    error = var(I);    
end