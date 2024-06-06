function [FIM_current,variance_FI] = FIM_soft_const_computation_discount_Multi( FIM_current, parameters_hat, x_current_position, factor)
global sigma 
global n_sensor
global FIM_Cost_Function_switching_mode


x_U = x_current_position;
switch FIM_Cost_Function_switching_mode
    case 1
        FI_total=zeros(5,5);
    case 2
        FI_total=[];
    case 3
        FI_total=[];
end
FI_trace_list = [];

for i=1:n_sensor
x_D = parameters_hat.x_D(i,:);
hat_gamma = parameters_hat.gamma(i);
FI = Fisher_Information_Computation(x_D,x_U,hat_gamma,sigma(i));
    switch FIM_Cost_Function_switching_mode
        case 1
            FI_total = FI_total + FI;
        case 2
            FI_total =blkdiag(FI_total,FI);
        case 3
            FI_total =blkdiag(FI_total,FI);
    end
FIM_inv = pinv(FI);
FI_trace = trace(FIM_inv);
FI_trace_list = [FI_trace_list FI_trace];
end

variance_FI = var(FI_trace_list);
FIM_current = FIM_current + factor* FI_total;


