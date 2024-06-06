function u_current_control = Random_Control_FIM_Multi(FIM_current, parameters_hat, x_current_position,u_control_space,M,V) 


M = 1;
                        
x_U = x_current_position;

Path_selecting_element = struct('Path_M_Index',[], 'X_history',[x_U], 'u_current_input',[0 0], 'FIM_current',[FIM_current], 'FIM_total_tr_value',[]);
[Path_selecting_List,u_input_list] = initialization_path_searching(Path_selecting_element,u_control_space,M,V);
% disp(Path_selecting_List);


u_current_control = Path_selecting_List(1).u_current_input;









