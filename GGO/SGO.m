clc;
clear;
close all;

%% Problem Definition

CostFunction=@(x) Sphere(x);        % Cost Function

nVar=5;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=-10;         % Lower Bound of Variables
VarMax= 10;         % Upper Bound of Variables

Orbitmin=50;       %Orbit Lower Bound
Orbitmax=200;      %Orbit Upper Bound


%% SGO Parameters

MaxPerigee=200;          % Maximum Number of Iterations

nPop=50;            % Population Size
nRock=20;            % Number of Rocks
nRubble=nPop-nRock;   %Number of Rubbles

alpha=1;            % Selection Pressure


pOrbitChange=0.3;    % Mutation Probability
mu=0.1;            % Mutation Rate

Jupiter=1;   %Jupiter
Saturn=0.7;    %Saturn
Uranus=0.4;    %Uranus
Neptune=0.3;   %Neptune



zeta=0.1;           % Rubbles Mean Cost Coefficient

ShareSettings;

%% Initialization

% Initialize Comets
[com,costs,rock,mainorbit]=CreateInitialComets();

% Array to Hold Best Cost Values
BestCost=zeros(MaxPerigee,1);

% UpdateTotalCostMass
[com,totalmassbeforelose]=UpdateTotalCostMass(com);

for it=1:MaxPerigee
    
% Mass Losing
 com=MassLose(com);

% GravitationalMutation
[com,RockGravity]=GravitationalMutation(com);

% MassAddMutation
 com=MassAddMutation(com);

% Update Total Orbits
com=UpdateTotalOrbits(com);

% Update Best Solution Ever Found for mass
   %  comrock=[com.mainRock];
   %  [~, BestmainRockIndex]=max([comrock.Mass]);
   %  BestSol=comrock(BestmainRockIndex);
% Update Best Cost for mass
   %  BestCost(it)=BestSol.Mass;
% Show Iteration Information per mass
  %   disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))....
  %       ' for index : ' num2str(BestmainRockIndex)]);

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
%% Results
% figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,1)
semilogy(BestCost,'LineWidth',2);
xlabel('Perigee');
ylabel('Best Orbit Cost');
title('Best Orbit Cost');
subplot(3,1,2)
% figure;
for i=1:MaxPerigee
itr(i:MaxPerigee,1)=i;
end;
plot(itr,bestorbitindex);hold on;
title(['Best Orbit Index is for Comet : ' num2str(bestorbitindex(end,1))]);
xlabel('Perigee'); ylabel('Best Orbit Index'); 
subplot(3,1,3)
% figure;
for i=1:MaxPerigee
itr(i:MaxPerigee,1)=i;
end;
plot(itr,mybestorbitvalue,'--');hold on;
 title(['Best Orbit Value for Comet ' num2str(bestorbitindex(end,1)),' is : ' num2str(roundascend(end,1))]);
 xlabel('Perigee'); ylabel('Best Orbit Value');
  
 %% Ackley
 figure;
 roundbestvalue=round(mybestorbitvalue);
 roundascend=roundbestvalue/10000;
for i=1:MaxPerigee
bestvalueackley(i,1)=Ackley(roundascend(i,1))
end
 decent=sort(bestvalueackley,'descend');
subplot(2,1,1)
plot(itr,bestvalueackley,'.');hold on;
title(['Best Ackley Test ascending : ' num2str(bestvalueackley(end,1))]);xlabel('Perigee'); ylabel('Ackley value');
legend('Best Ackley Value ascending')
subplot(2,1,2)
plot(itr,decent,'.');hold on;
title(['Best Ackley Test descending : ' num2str(bestvalueackley(1,1))]); xlabel('Perigee'); ylabel('Ackley value');
legend('Best Ackley Value descending')
hold on;
%% rastrigin
% figure;
for i=1:MaxPerigee
bestrastriginvalue(i,1)=rastrigin(roundascend(i,1));
end
bestrastriginvalue=bestrastriginvalue/10;
decent2=sort(bestrastriginvalue,'descend');
subplot(2,1,1)
plot(itr,bestrastriginvalue,'.');hold on;
title(['Best Rastrigin Test ascending : ' num2str(bestrastriginvalue(end,1))]);xlabel('Perigee'); ylabel('Rastrigin value');
legend('Best Rastrigin Value ascending')
subplot(2,1,2)
plot(itr,decent2,'.');hold on;
title(['Best Rastrigin Test descending : ' num2str(bestrastriginvalue(1,1))]); xlabel('Perigee'); ylabel('Rastrigin value');
legend('Best Rastrigin Value descending')
hold on;
%% rosenbrock
% figure;
for i=1:MaxPerigee
bestrosenbrock2value(i,1)=rosenbrock2([roundascend(i,1);9]);
end
bestrosenbrock2value=bestrosenbrock2value/1000;
decent6=sort(bestrosenbrock2value,'descend');
subplot(2,1,1)
plot(itr,bestrosenbrock2value,'.');hold on;
title(['Best Rosenrock Test ascending : ' num2str(bestrosenbrock2value(end,1))]);xlabel('Perigee'); ylabel('Rosenrock value');
legend('Best Rosenrock Value ascending')
subplot(2,1,2)
plot(itr,decent6,'.');hold on;
title(['Best Rosenrock Test descending : ' num2str(bestrosenbrock2value(1,1))]); xlabel('Perigee'); ylabel('Rosenrock value');
legend('Best Rosenrock Value descending')
hold on;
%% Beale
% figure;
for i=1:MaxPerigee
bestbealevalue(i,1)=beale(roundascend(i,1));
end
bestbealevalue=bestbealevalue/1000;
decent4=sort(bestbealevalue,'descend');
subplot(2,1,1)
plot(itr,bestbealevalue,'.');hold on;
title(['Best Beale Test ascending : ' num2str(bestbealevalue(end,1))]);xlabel('Perigee'); ylabel('Beale value');
legend('Best Beale Value ascending')
subplot(2,1,2)
plot(itr,decent4,'.');hold on;
title(['Best Beale Test descending : ' num2str(bestbealevalue(1,1))]); xlabel('Perigee'); ylabel('Beale value');
legend('Best Beale Value descending')
hold on;
%% eggholder
% figure
for i=1:MaxPerigee
besteggholdervalue(i,1)=eggholder2([roundascend(i,1);1]);
end
bestbealevalue=besteggholdervalue/1000;
decent5=sort(besteggholdervalue,'descend');
subplot(2,1,1)
plot(itr,besteggholdervalue,'.');hold on;
title(['Best Eggholder Test ascending : ' num2str(min(besteggholdervalue(end,1)))]);xlabel('Perigee'); ylabel('Eggholder value');
legend('Best Eggholder Value ascending')
subplot(2,1,2)
plot(itr,decent5,'.');hold on;
title(['Best Eggholder Test descending : ' num2str(min(besteggholdervalue))]); xlabel('Perigee'); ylabel('Eggholder value');
legend('Best Eggholder Value descending','Location','southwest');
%% 




