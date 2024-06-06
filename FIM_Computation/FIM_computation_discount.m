function FIM_current = FIM_computation_discount( FIM_current, parameters_hat, x_current_position, factor)
global sigma 


x_D = parameters_hat(3:4);
x_U = x_current_position;
hat_gamma = parameters_hat(1);


FI = Fisher_Information_Computation(x_D,x_U,hat_gamma,sigma);
FIM_current = FIM_current + factor* FI;


