function [Path_selecting_List,u_input_list] = MPC_initialization_soft_const_path_searching(Path_selecting_element,parameters_hat,u_control_space,M,V,factor)
global n_sensor
global delta
             
Path_selecting_List = [];
u_input_list=[];
index_list = randsample(1:V,M);

for i=1:M
    new_Path_selecting_element = Path_selecting_element;    
    new_Path_selecting_element.Path_M_Index = index_list(i);

    u_current_input = u_control_space(index_list(i),:);
    new_Path_selecting_element.u_current_input = u_current_input;
    new_Path_selecting_element.X_history = new_Path_selecting_element.X_history + u_current_input;
    
    
    [new_Path_selecting_element.FIM_current,variance_FI] = FIM_soft_const_computation_discount_Multi(Path_selecting_element.FIM_current, parameters_hat, new_Path_selecting_element.X_history,factor);
        
    trace_list=[];
    for k=1:n_sensor
        FIM_sensor = new_Path_selecting_element.FIM_current(4*k-3:4*k,4*k-3:4*k);
        FIM_inv = pinv(FIM_sensor);
        trace_list = [trace_list trace(FIM_inv)];
    end
    MSE = sum(trace_list);

 
    
    new_Path_selecting_element.FIM_total_tr_value = soft_cost_generate(new_Path_selecting_element.FIM_current,MSE,variance_FI,delta);    
    Path_selecting_List = [Path_selecting_List new_Path_selecting_element];
%   u_input_list=[u_input_list; u_current_input];
end


