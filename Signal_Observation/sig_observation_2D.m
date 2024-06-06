function sig_y = sig_observation_2D(x_D,x_U,alpha,beta,noise)

distance=norm(x_D-x_U,2);
sig_y = alpha*(-10*log10(distance)) + beta + noise;