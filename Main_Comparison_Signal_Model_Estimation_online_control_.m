%% Matlab code for research

clear
% This is the code for A Fisher Information based Receding Horizon Control Method for Signal Strength Model Estimation
% This demo is for testing several different methods

addpath(genpath('Signal_Observation'))
addpath(genpath('MPC_Control'))
addpath(genpath('FIM_Computation'))
addpath(genpath('Estimator'))
addpath(genpath('Map_Generation'))

global Control_Algorithm
global sigma 
global n_sensor
global unknown_num
global measure_num
global delta
global step_num

%% Select Online Motion Planning Methods
Control_Algorithm = 4;
% 1 - Random Search; 
% 2 - Greedy Search; 
% 3 - RH_Tree_Search;
% 4 - RH_DP;
% 5 - RH_DP_Soft_Constraint;


delta =5;
sigma = 0.5*[2.0 2.0 2.0 2.0 2.0];
n_sensor = 5;
unknown_num = 5;
measure_num = 100;


%% Initialization
% Initialize the environment with five sensors
num_step = 30;
Repeating_Num = 1;
estimation_pause_num = 1;
MSE_matrix = [];
RMSE_list_matrix = [];
parameters_hat_list = struct('gamma',[],'K', [],'x_D_x', [],'x_D_y',[],'x_D_z',[]);
MSE_matrix=[];



% Define the real parameters and sensor positions   
gamma = 5;
K = -20;
real_gamma = [gamma gamma+1 gamma-1 gamma+2 gamma-2];
real_K = [K+5 K K-5  K+3  K-3];
x_D = 10*[ 7.0   1.0   0.5;
          -1.0  -10.0  0.8;
          -8.0   6.0   1.0;
           1.0  -3.0   0.3;
          -2.0   8.0   0.0];
real_parameters = struct('gamma',real_gamma,'K', real_K,'x_D', x_D);


% Define estimated parameters 
gamma_hat = 7;
K_hat = -10;
hat_gamma = [gamma_hat gamma_hat gamma_hat gamma_hat gamma_hat]; 
hat_K  =  [K_hat K_hat K_hat K_hat K_hat];
x_D_hat  = zeros(5,3);
parameters_hat = struct('gamma',hat_gamma,'K', hat_K,'x_D', x_D_hat);



%%
%sampling points information
x_initial_position = 10*[10 -10 5]; 
x_history = [x_initial_position];
y_history = [];
u_list = [];
FIM_list=[];
MSE_list=[];
RMSE_list =[];
parameters_hat_list=[];
count_estimation=0;
FIM_current = zeros(5*n_sensor,5*n_sensor);


%% Running online estimation
tic
x_current_position = x_initial_position;
for i  = 1:num_step
    fprintf('\nStarting %d iteration.', i);  
    FIM_current = FIM_computation_Multi(FIM_current, parameters_hat, x_current_position);
    [u_control_space,M,V] = u_control_space_generating(x_current_position);

    switch Control_Algorithm
        case 1
            u_current_control = Random_Control_FIM_Multi(FIM_current, parameters_hat,x_current_position,u_control_space,M,V);
        case 2
            u_current_control = Greedy_Control_FIM_Multi(FIM_current, parameters_hat,x_current_position,u_control_space,M,V);        
        case 3
            u_current_control = MPC_Tree_Control_FIM_Multi(FIM_current, parameters_hat,x_current_position,u_control_space,M,V);
        case 4
            u_current_control = MPC_DP_Control_FIM_Multi(FIM_current, parameters_hat,x_current_position,u_control_space,M,V);
        case 5  
            u_current_control = MPC_DP_soft_const_Control_FIM_Multi(FIM_current, parameters_hat,x_current_position,u_control_space,M,V);
    end
    
    % State Update & signal measurement
    step_num = i;
    x_current_position = x_current_position + u_current_control;
    y_current_observation_list = get_sig_observation_multi_list(x_current_position,real_parameters);    
    u_list = [u_list; u_current_control];
    x_history = [x_history; x_current_position]; 
    y_history = [y_history; y_current_observation_list];
        

    % Running estimator
    if count_estimation == estimation_pause_num
        parameters_hat = get_estimation_Multi_y_list(x_history,y_history,parameters_hat,i);
        count_estimation = 0;
    end
    count_estimation = count_estimation + 1;
    parameters_hat_list = [parameters_hat_list; parameters_hat];
   

    % Update FIM Record  
    trace_list=[];
    for k=1:n_sensor
         FIM_sensor = FIM_current(5*k-4:5*k,5*k-4:5*k);
         FIM_inv = pinv(FIM_sensor);
         trace_list = [trace_list trace(FIM_inv)];
    end

    MSE_elem = sum(trace_list);
    MSE_list = [MSE_list MSE_elem];  
end

fprintf('\n Final MSE bound is %f', MSE_list(end));

toc


%% Plots and Videos
Generating_5_sensor_x_history_3D_Map_2D_projection(real_parameters,parameters_hat,x_history,y_history);

% information_results = struct('real_parameter',real_parameters,'parameters_hat',parameters_hat,'parameters_hat_list',parameters_hat_list,'u_list',u_list,'x_history',x_history, 'y_history', y_history);
% save DP_making_simulation_information_estimater_test_multi_5_sensor_path_history.mat information_results 






