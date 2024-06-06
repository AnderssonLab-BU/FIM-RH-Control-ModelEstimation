function u_current_control = MPC_DP_Control_FIM_Multi( FIM_current, parameters_hat,x_current_position,u_control_space,M,V) 

T = 5;
factor = 0.9;


Path_selecting_element = struct('Path_M_Index',[], 'X_history',[x_current_position], 'u_current_input',[0 0], 'FIM_current',[FIM_current], 'FIM_total_tr_value',[]);
[Path_selecting_List,~] = MPC_initialization_path_searching(Path_selecting_element,parameters_hat,u_control_space,M,V,factor);

for i =1:T    
    Path_selecting_List = DP_path_generating_Multi(u_control_space,Path_selecting_List,parameters_hat,M,V,factor);
  
end

u_current_control = select_best_control_input(Path_selecting_List,u_control_space);











