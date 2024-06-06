function FI = Fisher_Information_Computation(x_D,x_U,hat_alpha,sigma)

l_ki = 1.0;
l_ri = - log10(norm(x_D-x_U,2));

% l_xi = hat_alpha * (x_U(1)-x_D(1)) / (log(10) * norm(x_D-x_U,2));
% l_yi = hat_alpha * (x_U(2)-x_D(2)) / (log(10) * norm(x_D-x_U,2));
% l_zi = hat_alpha * (x_U(3)-x_D(3)) / (log(10) * norm(x_D-x_U,2));

l_xi = hat_alpha * (x_U(1)-x_D(1)) / (log(10) * norm(x_D-x_U,2)* norm(x_D-x_U,2));
l_yi = hat_alpha * (x_U(2)-x_D(2)) / (log(10) * norm(x_D-x_U,2)* norm(x_D-x_U,2));
l_zi = hat_alpha * (x_U(3)-x_D(3)) / (log(10) * norm(x_D-x_U,2)* norm(x_D-x_U,2));

H = [ l_ki*l_ki  l_ki*l_ri  l_ki*l_xi  l_ki*l_yi l_ki*l_zi;
      l_ri*l_ki  l_ri*l_ri  l_ri*l_xi  l_ri*l_yi l_ri*l_zi;
      l_xi*l_ki  l_xi*l_ri  l_xi*l_xi  l_xi*l_yi l_xi*l_zi;
      l_yi*l_ki  l_yi*l_ri  l_yi*l_xi  l_yi*l_yi l_yi*l_zi;
      l_zi*l_ki  l_zi*l_ri  l_zi*l_xi  l_zi*l_yi l_zi*l_zi];


FI = 1/(sigma^2) * H;