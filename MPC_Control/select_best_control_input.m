function u_current_control = select_best_control_input(Path_selecting_List,u_input_list)


num_col=size(Path_selecting_List,2);
num_row=size(Path_selecting_List,1);

min_index = Path_selecting_List(1,1).Path_M_Index;
min_val = Path_selecting_List(1,1).FIM_total_tr_value;

for i =1:num_row
    for j = 1:num_col
        if Path_selecting_List(i,j).FIM_total_tr_value <= min_val
            min_val = Path_selecting_List(i,j).FIM_total_tr_value;
            min_index = Path_selecting_List(i,j).Path_M_Index;
        end                
    end
end


u_current_control = u_input_list(min_index,:);