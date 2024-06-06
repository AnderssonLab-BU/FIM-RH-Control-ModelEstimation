function FIM_total_tr_value = soft_cost_generate(FIM_current,MSE,variance_FI,delta)
global step_num
global n_sensor

Location_list = [];
list= diag(FIM_current);
for i=1:n_sensor
    Location_list = [Location_list list(5*i-2:5*i)];
end
disp(Location_list)


soft_case = 2;

switch soft_case
    case 1
%         beta = 1.1;
%         FIM_total_tr_value = MSE*(1 + delta*variance_FI);
%         FIM_total_tr_value = MSE*(1 + delta*variance_FI*(beta^step_num));
%         plus = delta*variance_FI*(beta^step_num);
%         FIM_total_tr_value = MSE + plus;
        
    case 2
        variance = var(Location_list);       
        plus = delta*variance;
        FIM_total_tr_value = MSE + plus;
end
        
fprintf('\n MSE is %f and soft punishment is %f ', [MSE plus]);









