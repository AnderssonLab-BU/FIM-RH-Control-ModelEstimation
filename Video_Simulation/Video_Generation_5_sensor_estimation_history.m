addpath(genpath('Signal_Observation'))
addpath(genpath('MPC_Control'))
addpath(genpath('FIM_Computation'))
addpath(genpath('Estimator'))
addpath(genpath('Map_Generation'))

% load DP_best_simulation_information_estimater_test_multi_5_sensor_path_history.mat
load DP_information_estimater_test_multi_5_sensor_path_history.mat

real_parameters = information_results.real_parameter;
parameters_hat = information_results.parameters_hat;
x_history = information_results.x_history;
y_history = information_results.y_history;
parameters_hat_list = information_results.parameters_hat_list;



v=VideoWriter('Video_5_sensor_estimation.evi');
open(v);

f = figure;
f.Position = [100 100 1200 1000];

n_steps=size(x_history,1)-1;
for i =1: n_steps
    
    pause(.2)
    Generating_Video_5_sensor_x_history_3D_Map_2D_projection(real_parameters,parameters_hat_list(i,:),x_history(1:i,:),y_history);
    hold off
    frame = getframe(gcf);   
    writeVideo(v,frame);
    
end

close(v);



