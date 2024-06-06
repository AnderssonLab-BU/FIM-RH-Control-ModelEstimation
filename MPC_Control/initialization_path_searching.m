function [Path_selecting_List,u_input_list] = initialization_path_searching(Path_selecting_element,u_control_space,M,V)

             
Path_selecting_List = [];
u_input_list=[];
index_list = randsample(1:V,M);


for i=1:M
    new_Path_selecting_element = Path_selecting_element;    
    new_Path_selecting_element.Path_M_Index = index_list(i);

    u_current_input = u_control_space(index_list(i),:);
    new_Path_selecting_element.u_current_input = u_current_input;    
    new_Path_selecting_element.X_history = new_Path_selecting_element.X_history + u_current_input;
    
    Path_selecting_List = [Path_selecting_List new_Path_selecting_element];
%   u_input_list=[u_input_list; u_current_input];
end


