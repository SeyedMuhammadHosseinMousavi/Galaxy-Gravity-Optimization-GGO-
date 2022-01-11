%% Galaxy Gravity Optimization(GGO) An Algorithm for Optimization, Inspired by Comets Life Cycle
% Mousavi, Seyed Muhammad Hossein, S. Younes MiriNezhad, and Mir Hossein Dezfoulian. "Galaxy gravity optimization (GGO) an algorithm for optimization, inspired by comets life cycle." 2017 Artificial Intelligence and Signal Processing Conference (AISP). IEEE, 2017.
% Created in (11 Jan 2022).
% ------------------------------------------------ 
% Feel free to ontact me if you find any problem using the code: 
% mosavi.a.i.buali@gmail.com 
% SeyedMuhammadHosseinMousavi 
% My Google Scholar: https://scholar.google.com/citations?user=PtvQvAQAAAAJ&hl=en 
% My GitHub: https://github.com/SeyedMuhammadHosseinMousavi?tab=repositories 
% My ORCID: https://orcid.org/0000-0001-6906-2152 
% My Scopus: https://www.scopus.com/authid/detail.uri?authorId=57193122985 
% My MathWorks: https://www.mathworks.com/matlabcentral/profile/authors/9763916# 
% ------------------------------------------------ 
% Related Paper For Cite:
% Mousavi, Seyed Muhammad Hossein, S. Younes MiriNezhad, and Mir Hossein Dezfoulian. "Galaxy gravity optimization (GGO) an algorithm for optimization, inspired by comets life cycle." 2017 Artificial Intelligence and Signal Processing Conference (AISP). IEEE, 2017.
% Hope it help you, enjoy the code and wish me luck :)

%% Cleaning
clc;
clear;
close all;
warning('off');

%% Basic Parameters
% Cost Function
CostFunction = @(x) Sphere(x);        
% Number of Decision Variables
nVar = 10;            
% Decision Variables Matrix Size
VarSize = [1 nVar]; 
% Lower Bound of Variables
VarMin = -20;  
% Upper Bound of Variables
VarMax = 20;   
%Orbit Lower Bound
Orbitmin = 1;   
%Orbit Upper Bound
Orbitmax = 90;       
% -----------------------------------
%% Galaxy Gravity Optimization(GGO) Main Parameters
% Maximum Number of Iterations
MaxPerigee = 150;   
% Population Size
nPop = 9000;         
% Number of Rocks
nRock = 5000;        
%Number of Rubbles
nRubble = nPop - nRock; 
% Selection Pressure
alpha = 1;            
% Mutation Probability
pOrbitChange = 0.3;    
% Mutation Rate
mu = 0.2;            
% Effective Planets (Gravity)
Jupiter = 1;     %Jupiter
Saturn = 0.7;    %Saturn
Uranus = 0.4;    %Uranus
Neptune = 0.3;   %Neptune
% Rubbles Mean Cost Coefficient
zeta = 0.2;           
ShareSettings;

%% GGO Body
% Initialize Comets
[com,costs,rock,mainorbit]=CreateInitialComets();
% Array to Hold Best Cost Values
BestCost=zeros(MaxPerigee,1);
% Update Total Cost Mass
[com,totalmassbeforelose]=UpdateTotalCostMass(com);
%
for it=1:MaxPerigee
% Mass Loss
com=MassLose(com);
% Gravitational Mutation
[com,RockGravity]=GravitationalMutation(com);
% Mass Add Mutation
com=MassAddMutation(com);
% Update Total Orbits
com=UpdateTotalOrbits(com);
% Update Best Solution Ever Found for orbit
comorbit=[com.sumOrbit];
[bestorbitvalue, BestmainRockOrbitIndex]=max([comorbit]);
BestSol=comorbit(BestmainRockOrbitIndex);
% Update Best Cost for orbit
BestCost(it)=BestSol;
% Show Iteration Information per orbit
disp(['Perigee ' num2str(it) ': Best Orbit Cost = ' num2str(BestCost(it))....
' for Orbit index : ' num2str(BestmainRockOrbitIndex)]);
bestorbitindex(it,1)=BestmainRockOrbitIndex;
mybestorbitvalue(it,1)=bestorbitvalue;
end
roundbestvalue=round(mybestorbitvalue);
roundascend=roundbestvalue/10000;
 
%% Visualizing Results
% figure
% set(gcf, 'Position',  [50, 150, 900, 450])
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
sl=semilogy(BestCost,'LineWidth',1);
sl.Color = 'k';
xlabel('Perigee');
ylabel('Best Orbit Cost');
title('Best Orbit Cost');
subplot(2,2,2)
for i=1:MaxPerigee
itr(i:MaxPerigee,1)=i;
end;
plot(itr,bestorbitindex,'k');
hold on;
title(['Best Orbit Index is for Comet : ' num2str(bestorbitindex(end,1))]);
xlabel('Perigee'); ylabel('Best Orbit Index'); 
subplot(2,2,3)
for i=1:MaxPerigee
itr(i:MaxPerigee,1)=i;
end;
plot(itr,mybestorbitvalue,'k');
hold on;
title(['Best Orbit Value for Comet ' num2str(bestorbitindex(end,1)),' is : ' num2str(roundascend(end,1))]);
xlabel('Perigee'); ylabel('Best Orbit Value');
subplot(2,2,4)
plot(mainorbit,'k');
title('All Orbits');
hold off;
%% Testing the Performance of GGO 
%  Ackley Function
% figure
% set(gcf, 'Position',  [50, 150, 1000, 450])
figure('units','normalized','outerposition',[0 0 1 1])
roundbestvalue=round(mybestorbitvalue);
roundascend=roundbestvalue/10000;
for i=1:MaxPerigee
bestvalueackley(i,1)=Ackley(roundascend(i,1));
end
decent=sort(bestvalueackley,'descend');
subplot(2,2,1)
plot(itr,bestvalueackley,'r.');
hold on;
title(['Best Ackley Test ascending : ' num2str(bestvalueackley(end,1))]);
xlabel('Perigee'); ylabel('Ackley value');
legend('Best Ackley Value ascending')
subplot(2,2,2)
plot(itr,decent,'r-');
hold on;
title(['Best Ackley Test descending : ' num2str(bestvalueackley(1,1))]);
xlabel('Perigee'); ylabel('Ackley value');
legend('Best Ackley Value descending')
hold on;
% --------------------------------------------------------------------
% Rastrigin Function
% figure
% set(gcf, 'Position',  [50, 150, 1000, 450])
for i=1:MaxPerigee
bestrastriginvalue(i,1)=rastrigin(roundascend(i,1));
end
bestrastriginvalue=bestrastriginvalue/10;
decent2=sort(bestrastriginvalue,'descend');
subplot(2,2,3)
plot(itr,bestrastriginvalue,'b-');
hold on;
title(['Best Rastrigin Test ascending : ' num2str(bestrastriginvalue(end,1))]);
xlabel('Perigee'); ylabel('Rastrigin value');
legend('Best Rastrigin Value ascending')
subplot(2,2,4)
plot(itr,decent2,'b-');
hold on;
title(['Best Rastrigin Test descending : ' num2str(bestrastriginvalue(1,1))]);
xlabel('Perigee'); ylabel('Rastrigin value');
legend('Best Rastrigin Value descending')
hold off;
% --------------------------------------------------------------------
% Rosenbrock Function
% figure
% set(gcf, 'Position',  [50, 150, 1000, 450])
figure('units','normalized','outerposition',[0 0 1 1])
for i=1:MaxPerigee
bestrosenbrock2value(i,1)=rosenbrock2([roundascend(i,1);9]);
end
bestrosenbrock2value=bestrosenbrock2value/1000;
decent6=sort(bestrosenbrock2value,'descend');
subplot(2,2,1)
plot(itr,bestrosenbrock2value,'m-');
hold on;
title(['Best Rosenrock Test ascending : ' num2str(bestrosenbrock2value(end,1))]);
xlabel('Perigee'); ylabel('Rosenrock value');
legend('Best Rosenrock Value ascending')
subplot(2,2,2)
plot(itr,decent6,'m-');
hold on;
title(['Best Rosenrock Test descending : ' num2str(bestrosenbrock2value(1,1))]);
xlabel('Perigee'); ylabel('Rosenrock value');
legend('Best Rosenrock Value descending')
hold on;
% --------------------------------------------------------------------
% Beale Function
% figure
% set(gcf, 'Position',  [50, 150, 1000, 450])
for i=1:MaxPerigee
bestbealevalue(i,1)=beale(roundascend(i,1));
end
bestbealevalue=bestbealevalue/1000;
decent4=sort(bestbealevalue,'descend');
subplot(2,2,3)
plot(itr,bestbealevalue,'g-');
hold on;
title(['Best Beale Test ascending : ' num2str(bestbealevalue(end,1))]);
xlabel('Perigee'); ylabel('Beale value');
legend('Best Beale Value ascending')
subplot(2,2,4)
plot(itr,decent4,'g-');hold on;
title(['Best Beale Test descending : ' num2str(bestbealevalue(1,1))]); 
xlabel('Perigee'); ylabel('Beale value');
legend('Best Beale Value descending')
hold off;

%% Performance Statistics
fprintf('Best Orbit Cost Is =  %0.4f.\n',BestCost(end))
fprintf('Best Orbit Index Is =  %0.4f.\n',bestorbitindex(end))
fprintf('Best Orbit Value Is =  %0.4f.\n',roundascend(end))
fprintf('Best Ackley Value Is =  %0.4f.\n',bestvalueackley(end))
fprintf('Best Rastrigin Value Is =  %0.4f.\n',bestrastriginvalue(end))
fprintf('Best Rosenbrock Value Is =  %0.4f.\n',bestrosenbrock2value(end))
fprintf('Best Beale Value Is =  %0.4f.\n',bestbealevalue(end))

