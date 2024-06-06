function  new_Path_selecting_table = DP_soft_const_path_generating_Multi(u_candidate,Path_selecting_List,parameters_hat,M,V,factor)
global FIM_Cost_Function_switching_mode
global n_sensor
global delta
new_Path_selecting_table =[];
n_size = length(Path_selecting_List);

for i =1:n_size
    Path_selecting_element = Path_selecting_List(i);
    new_Path_selecting_list =[];
    
    for j=1:V
        
        new_Path_selecting_element = Path_selecting_element;    
        new_Path_selecting_element.u_current_input = u_candidate(j,:);        
        x_next = new_Path_selecting_element.X_history(end) + new_Path_selecting_element.u_current_input;       
        new_Path_selecting_element.X_history = [Path_selecting_element.X_history; x_next ];
        
        [new_Path_selecting_element.FIM_current,variance_FI] = FIM_soft_const_computation_discount_Multi( Path_selecting_element.FIM_current, parameters_hat, x_next,factor);
        switch FIM_Cost_Function_switching_mode
            case 1
                FIM_inv = pinv(new_Path_selecting_element.FIM_current);
                MSE = trace(FIM_inv);
            case 2
                trace_list=[];
                for k=1:n_sensor
                    FIM_sensor = new_Path_selecting_element.FIM_current(5*k-4:5*k,5*k-4:5*k);
                    FIM_inv = pinv(FIM_sensor);
                    trace_list = [trace_list trace(FIM_inv)];
                end
                MSE = sum(trace_list);
            case 3
                FIM_inv = pinv(new_Path_selecting_element.FIM_current);
                MSE = trace(FIM_inv);
        end    
        
        new_Path_selecting_element.FIM_total_tr_value = soft_cost_generate(new_Path_selecting_element.FIM_current,MSE,variance_FI,delta);     
        new_Path_selecting_list = [new_Path_selecting_list new_Path_selecting_element];
        
    end
    
    new_Path_selecting_table = [new_Path_selecting_table; new_Path_selecting_list];

end



