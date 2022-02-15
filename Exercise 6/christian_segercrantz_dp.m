function opt_util = christian_segercrantz_dp(m,n,y,x,u)
    %We create the global variables needed
    global sol_mat num
    sol_mat = NaN(m,n);
    num = length(u);
    %We give J(n,m) to the sub-function algorithm
    opt_util = my_dyn_opter(m,n,y,x,u);
    %The sub-function
    function util = my_dyn_opter(m,n,y,x,u)
        %We check if either of the measurements are zero and return 0
        %utility in that case
        if(or(n==0,m==0))
            util = 0;
        %We check if we have already counted J(*,*), and if we have return
        %that as the answer
        elseif(not(isnan(sol_mat(m,n))))
            util = sol_mat(m,n);
        %We check if either of the meassurements of are less then all
        %options and return 0 in that case
        elseif(or(all(m<x),all(n<y)))
            sol_mat(m,n) = 0;
            util = 0;
        %If not, start cutting
        else
             %We create a vector for each of the options
             opt = zeros(1,num);
             %If neither of the measurements are the size of a given
             %dimension o the options, we cut the original piece into
             %pieces that do not yet (potentially) give 
             if(and(all(m>x),all(n>y)))
                 for i = find(and(n-x>0,m-y>0))
                     opt(i) = max(my_dyn_opter(m,n-x(i),y,x,u) + my_dyn_opter(m,x(i),y,x,u), my_dyn_opter(m-y(i),n,y,x,u)+my_dyn_opter(y(i),n,y,x,u));
                 end
             %If one of the measurements match we cut that and continue the
             %algorithm
             else
                 for i = find(and(n-x>=0,m-y>=0))
                     opt(i) = u(i) + max(my_dyn_opter(m,n-x(i),y,x,u), my_dyn_opter(m-y(i),n,y,x,u));
                 end
             end
         %We same our newfound solution and continue
         util = max(opt);
         sol_mat(m,n) = util;  
        end
    end
end