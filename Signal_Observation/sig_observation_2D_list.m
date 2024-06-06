function sig_y_matrix = sig_observation_2D_list(x_matrix,x_coordinates,x_U,alpha,beta,noise)

n=size(x_matrix,2);
sig_y_matrix = zeros(size(x_matrix));

for i=1:n
    for j=1:n
        x_D = [x_coordinates(1,i), x_coordinates(2,j)];
        distance=norm(x_D-x_U,2);
        sig_y_matrix(i,j) = alpha*(-10*log10(distance)) + beta + noise;
    end
end