plot_pause = true;
count = 1;
fileID = fopen('cen2cen_log.txt', 'w');
for i = 0 : .8 : 1.6
    for j = 0 : .8 : 1.6
        mu = [0 0;exp(i) exp(j)];
        sigma = cat(3,[1 0;0 2],[1 .5;.5 1]);
        p = [.5 .5];
        obj = gmdistribution(mu,sigma,p);

        [Y, idx] = random(obj,300);
        [iterO, alphaO, muO, sigmaO] = em_gmm_func(Y, 50);
        fprintf(fileID, '\n\n%d: iteration times = %d\n\n', count, iterO);
        fprintf(fileID, '\n%12s %12s\n','alpha(exp):','alpha(obtained):');
        fprintf(fileID, '%10.3f   %10.3f  \n', [p; alphaO]);

        fprintf(fileID, '\n%12s\t%12s\n', 'mu(exp):', 'mu(obtained):');
        fprintf(fileID, '%6.3f%6.3f   %6.3f   %6.3f \n', [mu; muO]);
        fprintf(fileID, '\n%12s\t%12s\n', 'sigma(exp):', 'sigma(obtained):');
        fprintf(fileID, '%6.3f  %6.3f    %6.3f  %6.3f \n', [sigma; sigmaO]);

        filename = sprintf('cen2cen_%d.dat', count);
        save(filename,'Y','-ascii');
        count = count + 1;

        if plot_pause
                scatter(Y(idx == 1,1),Y(idx == 1,2), '.b');
                hold on;
                scatter(Y(idx == 2,1),Y(idx == 2,2), '.r');
                hold off;
                titlename = sprintf('sigma = [%d 0;0 1] , [1 %.2f;%.2f 1]', i, j, j);
                title(titlename);
                pause;
        end  
    end
end
fclose(fileID);

% length(find(idx==1))

% scatter(Y(idx == 1,1),Y(idx == 1,2), '.b');
% hold on;
% scatter(Y(idx == 2,1),Y(idx == 2,2), '.r');
% hold off;
