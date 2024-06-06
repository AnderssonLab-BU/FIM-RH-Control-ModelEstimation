function parameters_hat = get_estimation( x_history,y_history,parameters_hat)

% parameters_hat =parameters_hat;


% estimated parameters 
hat_gamma = parameters_hat(1);
hat_K = parameters_hat(2);
x_D_hat = parameters_hat(3:4);

%set up initial parameters
x0.A = [hat_gamma, hat_K];
x0.x_r = x_D_hat;
ydata = y_history;
x_1_list = x_history(2:end,1).';
x_2_list = x_history(2:end,2).';


%run non-linear least square solver
A = optimvar('A',2);
x_r = optimvar('x_r',2);
disp(sqrt((x_1_list - x_r(1)).^2 + (x_2_list - x_r(2)).^2));
% fun = A(2) + A(1)*(-10)*(((x_1_list - x_r(1)).^2 + (x_2_list - x_r(2)).^2));
distance = sqrt((x_1_list - x_r(1)).^2 + (x_2_list - x_r(2)).^2);
fun = A(1) + (-10) * A(2) * log(distance)/log(10);
obj = sum((fun - ydata).^2);
disp(obj); 

lsqproblem = optimproblem("Objective",obj);

x0.A = [hat_gamma hat_K];
x0.x_r = x_D_hat;
[sol,~] = solve(lsqproblem,x0);


%solution output
hat_gamma = sol.A(1);
hat_K = sol.A(2);
x_D_hat = [sol.x_r(1) sol.x_r(2)];
parameters_hat = [hat_gamma hat_K x_D_hat];

