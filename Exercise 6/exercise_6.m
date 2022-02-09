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




% Calling your DP-algorithm, to solve the problem of cutting the m x n block
% into smaller pieces. Assume that y, x, and u are ordered correctly.
% As a fun competition, we will compare your solutions based on performance
% (hence the tic and toc statements).
tic;
opt_util = christian_segercrantz_dp(m,n,y,x,u);
toc;
opt_util
function opt_util = christian_segercrantz_dp(m,n,y,x,u)
    global sol_mat num
    sol_mat = NaN(m,n);
    num = length(u);
    opt_util = my_dyn_opter(m,n,y,x,u);
    function util = my_dyn_opter(m,n,y,x,u)
        if(or(n==0,m==0))
            util = 0;
        elseif(not(isnan(sol_mat(m,n))))
            util = sol_mat(m,n);
        elseif(or(all(m<x),all(n<y)))
            sol_mat(m,n) = 0;
            util = 0;
        else
             opt = zeros(1,num);
             if(and(all(m>x),all(n>y)))
                 for i = find(and(n-x>0,m-y>0))
                     opt(i) = max(my_dyn_opter(m,n-x(i),y,x,u) + my_dyn_opter(m,x(i),y,x,u), my_dyn_opter(m-y(i),n,y,x,u)+my_dyn_opter(y(i),n,y,x,u));
                 end
             else
                 for i = find(and(n-x>=0,m-y>=0))
                     opt(i) = u(i) + max(my_dyn_opter(m,n-x(i),y,x,u), my_dyn_opter(m-y(i),n,y,x,u));
                 end
             end
         util = max(opt);
         sol_mat(m,n) = util;  
        end
    end
end