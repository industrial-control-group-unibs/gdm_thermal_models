clear all; close all;
%% Data Managment and sections

load("test_20220111_181745.mat");period=period/60/60;
DISABLE_PERIOD_STOP=false;
USE_PERIOD=false;
REMOVE_TEMP_TREND=false || USE_PERIOD;

t_days=(experiment.time-experiment.time(1))';
t_minutes=(t_days)*24*60;
tempi=t_minutes;
t=t_minutes;

%Sections
M=[ones(length(t_days),1) sin(2*pi*t_days) cos(2*pi*t_days)];
T=experiment.Temperature;
Te=T(1);
par=M\T;
TempTrend=M*par;
dTemp=T-TempTrend;
Temp=T-Te;
figure(1)
plot(t,Temp)
hold on 
[VALp,PKp] = findpeaks(dTemp,'MinPeakProminence', 0.5);
plot(t,Temp,t(PKp),Temp(PKp),'r*') 
hold on 
[VALn,PKn] = findpeaks(-dTemp,'MinPeakProminence', 0.5);
plot(t,Temp,t(PKn),Temp(PKn),'b*')
%% 

tempi=tempi(1:PKp(1));
t=t(1:PKp(1));
T=(T-min(T))/(max(T)-min(T));
T=T(1:PKp(1));
Id_rms=experiment.Id;
Id_rms=(Id_rms-min(Id_rms))/(max(Id_rms)-min(Id_rms));
Id_rms=Id_rms(1:PKp(1));
Id=experiment.mean_Id.^2;
Id=(Id-min(Id))/(max(Id)-min(Id));
Id=Id(1:PKp(1));
Iq_rms=experiment.Iq;
Iq_rms=(Iq_rms-min(Iq_rms))/(max(Iq_rms)-min(Iq_rms));
Iq_rms=Iq_rms(1:PKp(1));
Iq=experiment.mean_Iq.^2;
Iq=(Iq-min(Iq))/(max(Iq)-min(Iq));
Iq=Iq(1:PKp(1));
Iout_rms=experiment.Iout;
Iout=experiment.mean_Iout.^2;
Vout_rms=experiment.Vout;
Vout=experiment.mean_Vout.^2;
vel_rms=experiment.Speed;
vel_rms=(vel_rms-min(vel_rms))/(max(vel_rms)-min(vel_rms));
vel_rms=vel_rms(1:PKp(1));
vel=experiment.mean_Speed.^2;
vel=(vel-min(vel))/(max(vel)-min(vel));
vel=vel(1:PKp(1));
Pw_rms=Iout_rms.*Vout_rms;
Pw_rms=(Pw_rms-min(Pw_rms))/(max(Pw_rms)-min(Pw_rms));
Pw_rms=Pw_rms(1:PKp(1));
Pws=Iout.*Vout;
Pws=(Pws-min(Pws))/(max(Pws)-min(Pws));
Pws=Pws(1:PKp(1));

% Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,

%% Plot the Desired Curve
figure('Position',[50 35 800 520],'Tag','Initial point')
plot(t,T,'*');
title('Target Curve','FontSize',12); 
xlabel('Time (min)'); ylabel('Temperature (degree)')

%% Sample Temperature Curve for arbitrary indices
Tnew = TempCurve(tempi,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,[1 1 1 1 1 1 1 1 1]);

%% Add New Curve to Plot
hold on; plot(tempi,Tnew,'-or');

%%
% We would like to find the optimal indices that result in a torque
% curve closest to our desired curve.  Our initial guess of [1 1 1 1 1 1]
% did not yield a good fit, and there are a lot of
% possible combinations for this fitting.  We will use an
% optimization routine, the Genetic Algorithm, to find the optimal indices
% for our problem. 

%% Bounds on our Vector of Indices
%  lb     = [ 0, 0, 0, 0, -1, 0.8 25 100 25 200 25 400 25 600];
%  ub     = [ 300, 300000, 300, 300000, 0, 1.2 28 300 28 400 28 500 28 900];
% Tb=24+273.15;
% Ta=28+273.15;
 lb     = [ -inf -inf -inf -inf -inf -inf -inf -inf];
 ub     = [ inf inf inf inf inf inf inf inf inf];

%% Create Handle to Custom Output Function
custOutput = @(a1,a2,a3)ThOptimPlot(a1,a2,a3,tempi,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,T);

%% Set Options for Optimization
      ga_pop_size = 10000;
      ga_generations = 100000;
      ga_options = optimoptions(@ga,'PopulationSize',ga_pop_size,'Generations',ga_generations,...
          'FunctionTolerance',1e-25,'PlotFcns',@gaplotbestf,'OutputFcns',custOutput,'SelectionFcn',@selectiontournament, ...
                        'FitnessScalingFcn',@fitscalingprop);  %per grafico
    
% ga_options = gaoptimset('CrossoverFrac',0.5,'PopulationSize',100,...
%     'StallGen',125,'Generations',250,...
%     'PlotFcns',@gaplotbestf); %,'OutputFcns',custOutput____ da aggiungere per i plot

%% Run the Genetic Algorithm
% Note: The Genetic Algorithm is based on stochastic methods, meaning that
% we are not guaranteed to find the same solution every time.
% Rrun "rng(45)" at the Command Line to 
% set the seed for the random number generator.
rng(1)
[xOpt,fVal] = ga(@(x)objectiveFunction(x,tempi,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,T),...
    9,[],[],[],[],lb,ub,[],ga_options);

%% Inspect the Solution Vector to see that All Values are Integers
disp('Integer Solution Returned by GA:')
disp(xOpt)
Temperature = TempCurve(tempi,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,xOpt);
figure
plot(tempi,T,'*')
hold on; 
plot(tempi,Temperature,'-or');