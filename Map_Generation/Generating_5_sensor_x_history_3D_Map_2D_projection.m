function Generating_5_sensor_x_history_3D_Map_2D_projection(real_parameters,parameters_hat,x_history,y_history)

size_n =size(x_history,1);
x_U_list = x_history;

P_color_real_sensor =[1 0.5 0.6];
P_color_hat_sensor =[0.8 0.6 0.6];
P_color_agent_true = [0.6 0.7 0.8];
P_color_agent1 = [0.8 0.9 0.9];
P_color_agent2 = [0.9 0.8 0.9];
P_color_agent3 = [0.9 0.9 0.8];

%%

r = plot3(real_parameters.x_D(:,2),real_parameters.x_D(:,1),real_parameters.x_D(:,3),'o','MarkerSize',8);
r.MarkerFaceColor=P_color_real_sensor;
r.MarkerEdgeColor=P_color_real_sensor;
hold on

h = plot3(parameters_hat.x_D(:,2),parameters_hat.x_D(:,1),parameters_hat.x_D(:,3),'o','MarkerSize',12);
h.MarkerEdgeColor = P_color_hat_sensor;
hold on

grid on
p=plot3(x_U_list(:,2),x_U_list(:,1),x_U_list(:,3),'-o','LineWidth',2,'Color',P_color_agent_true);
p.MarkerFaceColor = 0.9*P_color_agent_true;
p.MarkerSize = 5;
hold on

x = x_U_list(:,2);
y = x_U_list(:,1);
z = x_U_list(:,3);
plot3(x, 100*ones(size(y)), z, 'LineWidth', 2,'Color',P_color_agent1); % project in x-z axis at y=100
plot3(100*ones(size(x)), y, z, 'LineWidth', 2,'Color',P_color_agent1); % project in y-z axis at x=2
plot3(x, y, 0.1*ones(size(x)), 'LineWidth', 2,'Color',P_color_agent1); % project in y-z axis at z=-2


text(x_U_list(1,2)+5,x_U_list(1,1)+5,x_U_list(1,3)+5,'Start','FontSize', 15);
text(real_parameters.x_D(1,2)+5,real_parameters.x_D(1,1)+5,real_parameters.x_D(1,3)+5,'Sensor1','FontSize', 15);
text(real_parameters.x_D(2,2)+5,real_parameters.x_D(2,1)+5,real_parameters.x_D(2,3)+5,'Sensor2','FontSize', 15);
text(real_parameters.x_D(3,2)+5,real_parameters.x_D(3,1)+5,real_parameters.x_D(3,3)+5,'Sensor3','FontSize', 15);
text(real_parameters.x_D(4,2)+5,real_parameters.x_D(4,1)+5,real_parameters.x_D(4,3)+5,'Sensor4','FontSize', 15);
text(real_parameters.x_D(5,2)+5,real_parameters.x_D(5,1)+5,real_parameters.x_D(5,3)+5,'Sensor5','FontSize', 15);

legend([r,h,p],'Real Sensor','Estimation','Trajectory')

zlim([0.0 100.0])
xlim([-120.0 120.0])
ylim([-120.0 120.0])
view(3)
set(gca,'FontSize',15)





