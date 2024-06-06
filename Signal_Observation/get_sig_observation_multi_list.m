function y_current_observation = get_sig_observation_multi_list(x_current_position,real_parameters)
global sigma
global n_sensor

y_current_observation = [];

for i =1:n_sensor
x_U = x_current_position;
x_D = real_parameters.x_D(i,:);
gamma = real_parameters.gamma(i);
K = real_parameters.K(i);

y_current_observation_elemt =  sig_observation_list(x_D,x_U,gamma,K,sigma(i));
y_current_observation =[y_current_observation  y_current_observation_elemt];

end



