function parameters_hat = get_estimation_Multi_lsqnonlin( x_history,y_history,parameters_hat,running_times)
global n_sensor
global unknown_num

if running_times >= unknown_num    
for i=1:n_sensor

% estimated parameters 
hat_gamma = parameters_hat.gamma(i);
hat_K = parameters_hat.K(i);
x_D_hat = parameters_hat.x_D(i,:);

%set up initial parameters

ydata = y_history(:,i).';
x_1_list = x_history(2:end,1).';
x_2_list = x_history(2:end,2).';

%run non-linear least square solver

fun = @(x) x(1) + (-10) * x(2) * log(sqrt((x_1_list - x(3)).^2 + (x_2_list - x(4)).^2))/log(10) - ydata;
x0=[hat_gamma hat_K x_D_hat];
lb = [0  -30 -10 -10];
ub = [10  0  10  10];
sol = lsqnonlin(fun,x0,lb,ub);

% [sol,~] = solve(lsqproblem,x0,);


parameters_hat.gamma(i) = sol(1);
parameters_hat.K(i) = sol(2);
parameters_hat.x_D(i,:) = [sol(3) sol(4)];


end
end
%solution output



