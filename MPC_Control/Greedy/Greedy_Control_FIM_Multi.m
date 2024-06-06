function u_current_control = Greedy_Control_FIM_Multi( FIM_current, parameters_hat,x_current_position,u_control_space,M,V) 

factor =1.0;
       

Path_selecting_element = struct('Path_M_Index',[], 'X_history',[x_current_position], 'u_current_input',[0 0], 'FIM_current',[FIM_current], 'FIM_total_tr_value',[]);
[Path_selecting_List,~] = initialization_path_searching(Path_selecting_element,u_control_space,M,V);
%disp(Path_selecting_List);

%generate_contnrol_cadidate
u_candidate = u_control_space;
%generate_all_future_state_path
new_Path_selecting_table = Greedy_path_generating_Multi(u_candidate,Path_selecting_List,parameters_hat,M,V,factor);
    
u_current_control = select_best_control_input(new_Path_selecting_table,u_control_space);









