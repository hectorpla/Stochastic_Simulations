X = importdata('old_fainthful_geyser_data.txt');
Y = X(:,2:3);

scatter(Y(:,1),Y(:,2),10,'.')
hold on;

mu = [4.2979 80.2849; 2.0943 54.7500];
sigma = cat(3,[0.1776 0.7631; 0.7631 31.4828],[0.1543 0.9857; 0.9857 34.4075]);
p = [.5 .5];
obj = gmdistribution(mu,sigma,p);

% [Y, idx] = random(obj,300);
% scatter(Y(idx == 1,1),Y(idx == 1,2), '.b');
% hold on;
% scatter(Y(idx == 2,1),Y(idx == 2,2), '.r');
% hold off;

h = ezcontour(@(x,y)pdf(obj,[x y]),[0 6],[30 100]);



save test1.dat Y -ascii