function parameters_hat_list = add_parameters_hat(parameters_hat_list,parameters_hat)

    parameters_hat_list.gamma = [parameters_hat_list.gamma; parameters_hat.gamma];
    parameters_hat_list.K = [parameters_hat_list.K; parameters_hat.K];
    parameters_hat_list.x_D_x = [parameters_hat_list.x_D_x parameters_hat.x_D(:,1)];
    parameters_hat_list.x_D_y = [parameters_hat_list.x_D_y parameters_hat.x_D(:,2)];
    parameters_hat_list.x_D_z = [parameters_hat_list.x_D_z parameters_hat.x_D(:,3)];
    