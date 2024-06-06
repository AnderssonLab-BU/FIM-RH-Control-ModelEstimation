function y_current_observation = get_sig_observation(x_current_position,real_parameters)
global sigma


x_D = real_parameters(3:4);
x_U = x_current_position;
gamma = real_parameters(1);
K = real_parameters(2);


y_current_observation =  sig_observation(x_D,x_U,gamma,K,sigma);
% disp(y_current_observation)

