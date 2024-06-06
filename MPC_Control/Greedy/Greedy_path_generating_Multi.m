function     new_Path_selecting_table = Greedy_path_generating_Multi(u_candidate,Path_selecting_List,parameters_hat,M,V,factor)
global n_sensor   
new_Path_selecting_table =[];
n_size = length(Path_selecting_List);

for i =1:n_size

    Path_selecting_element = Path_selecting_List(i);            
    new_Path_selecting_element = Path_selecting_element;                 
    new_Path_selecting_element.FIM_current = FIM_computation_discount_Multi( Path_selecting_element.FIM_current, parameters_hat,new_Path_selecting_element.X_history, factor);

    trace_list=[];
    for k=1:n_sensor
        FIM_sensor = new_Path_selecting_element.FIM_current(4*k-3:4*k,4*k-3:4*k);
        FIM_inv = pinv(FIM_sensor);
        trace_list = [trace_list trace(FIM_inv)];
    end
    MSE = sum(trace_list);


    new_Path_selecting_element.FIM_total_tr_value = MSE; 
           
    new_Path_selecting_table = [new_Path_selecting_table; new_Path_selecting_element];
%   disp(new_Path_selecting_table);

end



