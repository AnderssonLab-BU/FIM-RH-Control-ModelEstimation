function Path_selecting_List = pruning_tree_search_FIM(new_Path_selecting_table)


Path_selecting_List = [];
M = size(new_Path_selecting_table,1);

for i =1: M
     Path_selecting_list = new_Path_selecting_table(i,:);
     min_val = Path_selecting_list(1).FIM_total_tr_value;
     for j =1 : length(Path_selecting_list)
         if(Path_selecting_list(j).FIM_total_tr_value <= min_val)
            min_val = Path_selecting_list(j).FIM_total_tr_value;
            Path_selecting_elem = Path_selecting_list(j);
         end
     end
     
     Path_selecting_List = [Path_selecting_List Path_selecting_elem];
end
 


