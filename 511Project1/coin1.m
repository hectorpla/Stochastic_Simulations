close all; clear; clc;
heads = [4 4 5 5 7 6 8 5 8 6,...
         6 8 6 8 7 4 5 7 7 6,...
         11 5 6 7 5 6 5 7 5 9,...
         8 7 5 8 8 5 7 8 8 4,...
         6 7 6 7 6 7 5 8 7 8];

scatter(1:50,heads,150, 'x');
axis([0 52 0 12]);
xlabel('number of experments','FontSize',15);
ylabel('number of heads','FontSize',15);

figure;
hist(heads,0:13);
xlabel('number of heads','FontSize',15);
ylabel('times','FontSize',15);

tally = zeros(0,50);
for i = 1 : 50
    tally(i) = sum(heads(1:i)) / i;
end

figure;
plot(1:50, tally, 'r-x','MarkerSize',10);
axis([0 52 3 7]);
xlabel('number of experments','FontSize',15);
ylabel('tally of heads','FontSize',15);