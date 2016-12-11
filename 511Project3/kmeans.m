% k-means 

function mu = kmeans(X, K, max_iter, plotProgress)

    % K = 2; max_iter = 10;
    [m, ~] = size(X);
    mu = X(randi(m,K,1),:);

    distances = zeros(m, K);
    if plotProgress
    plot(X(:,1),X(:,2),'.b'); hold on;
    plot(mu(:,1),mu(:,2), 'xr', 'MarkerSize',10,'LineWidth', 3); hold off;
    end

    for i = 1 : max_iter
        % assign points to centorids
        for j = 1 : K
            distances(:,j) = sum( (X - repmat(mu(j,:), m,1)).^2 , 2);
        end

        [~, idx] = min(distances, [], 2);

        % compute new centroid
        for j = 1 : K
            len = length(find(idx == j));
            mu(j,:) = sum(X(idx == j,:)) / len;
        end

        if plotProgress
        plot(X(:,1),X(:,2),'.b'); hold on;
        plot(mu(:,1),mu(:,2), 'xr', 'MarkerSize',10,'LineWidth', 3); hold off;
        pause;
        end
    end
end