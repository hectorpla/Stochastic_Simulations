close all; clear; clc;
N = 1000;
c = 1.5; % so that the envolope covers the pdf

u = zeros(1,N);
i = 1;
numCan = 0;

while i <= N
    numCan = numCan + 1;
    % generate a candidate variable
    u_t = rand(1,1) * 6;
    
    % skip the gap 
    if betTri(u_t) == 0
        continue;
    end
    
    % accept or reject
    v = rand(1,1);
    if v <= betTri(u_t) / c
        u(i) = u_t;
    else
        continue;
    end
        
    i = i + 1;
end

hist(u,50);
fprintf('Candidates number: %d', numCan);