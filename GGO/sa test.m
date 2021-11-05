clc;clear;
FitnessFunction = @ackleyfcn;
%% IMPORTANT NOTE:FOR PLOTTING SA YOU MUST USE OPTIMTOOL AND SPECIFY LB HB AND 
%START POINT FOR EXAMPLE 32.69 AND THEN WAIT UNTIL CHANGE.
FitnessFunction = @rastriginsfcn;
FitnessFunction = @dejong2fcn; %it will called rosenbrock or dejong
FitnessFunction = @eggholder;
FitnessFunction = @multirosenbrock;
FitnessFunction = @dejong5fcn;
FitnessFunction = @simple_fitness;%%its beale

X0 = [0.5 0.5];   % Starting point
lb = [-64 -64];
ub = [64 64];
[x,fval,exitFlag,output] = simulannealbnd(ObjectiveFunction,X0,lb,ub)
fprintf('The number of iterations was : %d\n', output.iterations);
fprintf('The number of function evaluations was : %d\n', output.funccount);
fprintf('The best function value found was : %g\n', fval);
%% IMPORTANT NOTE:FOR PLOTTING SA YOU MUST USE OPTIMTOOL AND SPECIFY LB HB AND 
%START POINT FOR EXAMPLE 32.69 AND THEN WAIT UNTIL CHANGE.