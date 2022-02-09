% Clear all variables from memory.
clear all;
clc;

% Dimensions of the large marble block.
m = 100;
n = 100;

% Dimensions of the pieces.
y = [1,4,3];
x = [2,2,3];

% Utilities of the pieces.
u = [2,10,11];

function opt_util = christian_segercrantz_dp(m,n,y,x,u)
    if(and(all(m<x),all(n<y)))
        opt_util = 0;
    elseif(all(m<x))
        
    elseif(all(n<y))
        
    end
    

end

% Calling your DP-algorithm, to solve the problem of cutting the m x n block
% into smaller pieces. Assume that y, x, and u are ordered correctly.
% As a fun competition, we will compare your solutions based on performance
% (hence the tic and toc statements).
tic;
opt_util = christian_segercrantz_dp(m,n,y,x,u);
toc;