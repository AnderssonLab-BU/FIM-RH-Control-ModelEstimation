function parameters_hat = get_estimation_Multi_y_list( x_history,y_history,parameters_hat,running_times)
global n_sensor
global unknown_num
global measure_num 

if running_times >= unknown_num   

x_history_list_1=[];
x_history_list_2=[];
x_history_list_3=[];

for i=1:size(x_history,1)-1
    x_history_elem_1 = repmat(x_history(i+1,1),1,measure_num);
    x_history_list_1 = [x_history_list_1 x_history_elem_1];
    x_history_elem_2 = repmat(x_history(i+1,2),1,measure_num);
    x_history_list_2 = [x_history_list_2 x_history_elem_2];
    x_history_elem_3 = repmat(x_history(i+1,3),1,measure_num);
    x_history_list_3 = [x_history_list_3 x_history_elem_3];
end 

for i=1:n_sensor

% estimated parameters 
hat_gamma = parameters_hat.gamma(i);
hat_K = parameters_hat.K(i);
x_D_hat = parameters_hat.x_D(i,:);

%set up initial parameters
x0.A = [hat_gamma, hat_K];
x0.x_r = x_D_hat;
ydata_matrix = y_history(:,(i-1)*measure_num+1: i*measure_num);
ydata_matrix =  ydata_matrix';
ydata = ydata_matrix(:)';
x_1_list = x_history_list_1;
x_2_list = x_history_list_2;
x_3_list = x_history_list_3;

%run non-linear least square solver
A = optimvar('A',2,'LowerBound',[0,-30],'UpperBound',[20,0]); % gamma and K
x_r = optimvar('x_r',3,'LowerBound',10*[-20,-20 0.0],'UpperBound',10*[20,20 1.0]);
distance = sqrt((x_1_list - x_r(1)).^2 + (x_2_list - x_r(2)).^2+(x_3_list - x_r(3)).^2);
fun = A(2) + (-10) * A(1) * log(distance)/log(10);
obj = sum((fun - ydata).^2);
lsqproblem = optimproblem("Objective",obj);
x0.A = [hat_gamma hat_K];
x0.x_r = x_D_hat;
[sol,~] = solve(lsqproblem,x0);

parameters_hat.gamma(i) = sol.A(1);
parameters_hat.K(i) = sol.A(2);
parameters_hat.x_D(i,:) = [sol.x_r(1) sol.x_r(2) sol.x_r(3)];
end

end
%solution output





