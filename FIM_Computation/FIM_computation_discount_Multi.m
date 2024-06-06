function FIM_current = FIM_computation_discount_Multi( FIM_current, parameters_hat, x_current_position, factor)
global sigma 
global n_sensor


x_U = x_current_position;


FI_total=[];

for i=1:n_sensor
x_D = parameters_hat.x_D(i,:);
hat_gamma = parameters_hat.gamma(i);
FI = Fisher_Information_Computation(x_D,x_U,hat_gamma,sigma(i));


FI_total =blkdiag(FI_total,FI);


end

FIM_current = FIM_current + factor* FI_total;
