function [u_control_space,M,V] = u_control_space_generating(x_current_position)

one_vertical_speed_list = 3*ones(8,1);
zero_vertical_speed_list = zeros(8,1);
                   
horizon_speed_matrix = 5*  [ 2,  0 ;
                            -2,  0 ;
                             0,  2 ;
                             0, -2 ;
                            1.41,   1.41 ;
                           -1.41,   1.41 ;
                            1.41,  -1.41;
                           -1.41   -1.41 ];                          
u_control_up =[horizon_speed_matrix one_vertical_speed_list];
u_control_horizon =[horizon_speed_matrix zero_vertical_speed_list];
u_control_down =[horizon_speed_matrix (-1)*one_vertical_speed_list];

if x_current_position(3) <= 3
    u_control_down =[horizon_speed_matrix one_vertical_speed_list];
end

u_control_space = [u_control_up;
                   u_control_horizon;
                   u_control_down];
V =size(u_control_space,1);
M =size(u_control_space,1);


