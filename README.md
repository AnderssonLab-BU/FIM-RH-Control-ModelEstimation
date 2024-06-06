# FIM-RH-Control-ModelEstimation
A Fisher Information based Receding Horizon Control Method for Signal Strength Model Estimation (2024)


Paper Abstract - 
This paper considers the problem of localizing a
set of nodes in a wireless sensor network when both their
positions and the parameters of the communication model
are unknown. We assume that a single agent moves through
the environment, taking measurements of the Received Signal
Strength (RSS), and seek a controller that optimizes a perfor-
mance metric based on the Fisher Information Matrix (FIM).
We develop a receding horizon (RH) approach that alternates
between estimating the parameter values (using a maximum
likelihood estimator) and determining where to move so as to
maximally inform the estimation problem. The receding horizon
controller solves a multi-stage look ahead problem to determine
the next control to be applied, executes the move, collects
the next measurement, and then re-estimates the parameters
before repeating the sequence. We consider both a Dynamic
Programming (DP) approach to solving the optimal control
problem at each step, and a simplified heuristic based on a
pruning algorithm that significantly reduces the computational
complexity. We also consider a modified cost function that
seeks to balance the information acquired about each of the
parameters to ensure the controller does not focus on a single
value in its optimization. These approaches are compared
against two baselines, one based on a purely random trajectory
and one on a greedy control solution. The simulations indicate
our RH schemes outperform the baselines, while the pruning
algorithm produces significant reductions in computation time
with little effect on overall performance.


Notations:

1.MatLab Code of Receding Horizon Control for Signal Model Estimation.

2.Before running the code, there are several toolboxes needed. Please follow the instruction on command window to install them.

3.To run the code, choose the scenario you like and then open the corresponding "Main..." file on MatLab. (1) Main_RH_DP_Signal_Model_Estimation_online_control is for testing the proposed algorithm. (2) Main_Comparison_Signal_Model_Estimation_online_control is for the comparison of several baseline and our algorithm.
