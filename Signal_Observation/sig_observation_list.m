function sig_y = sig_observation_list(x_D,x_U,gamma,K,sigma)

global measure_num

sig_list =zeros(1,measure_num);

for i=1: measure_num
    noise = normrnd(0,sigma^2);
    sig_list(i)= gamma*(-10*log10(norm(x_D-x_U,2))) + K + 1*noise; 
end

sig_y = sig_list;


