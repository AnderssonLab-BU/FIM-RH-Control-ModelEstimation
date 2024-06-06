function parameters_hat = get_estimation_Multi( x_history,y_history,parameters_hat,running_times)
global n_sensor
global unknown_num

if running_times >= unknown_num   
    
for i=1:n_sensor

% estimated parameters 
hat_gamma = parameters_hat.gamma(i);
hat_K = parameters_hat.K(i);
x_D_hat = parameters_hat.x_D(i,:);

%set up initial parameters
x0.A = [hat_gamma, hat_K];
x0.x_r = x_D_hat;
ydata = y_history(:,i).';
x_1_list = x_history(2:end,1).';
x_2_list = x_history(2:end,2).';

%run non-linear least square solver
A = optimvar('A',2);
x_r = optimvar('x_r',2);
distance = sqrt((x_1_list - x_r(1)).^2 + (x_2_list - x_r(2)).^2);
fun = A(2) + (-10) * A(1) * log(distance)/log(10);
obj = sum((fun - ydata).^2);
lsqproblem = optimproblem("Objective",obj);
x0.A = [hat_gamma hat_K];
x0.x_r = x_D_hat;
[sol,~] = solve(lsqproblem,x0);

parameters_hat.gamma(i) = sol.A(1);
parameters_hat.K(i) = sol.A(2);
parameters_hat.x_D(i,:) = [sol.x_r(1) sol.x_r(2)];

end

end
%solution output





