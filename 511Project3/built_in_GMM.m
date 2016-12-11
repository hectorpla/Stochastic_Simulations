X = importdata('old_fainthful_geyser_data.txt');
Y = X(:,2:3);

scatter(Y(:,1),Y(:,2),10,'.')
hold on;
pause;

options = statset('Display','final');
obj = gmdistribution.fit(Y,2,'Options',options);

h = ezcontour(@(x,y)pdf(obj,[x y]),[0 6],[30 100]);