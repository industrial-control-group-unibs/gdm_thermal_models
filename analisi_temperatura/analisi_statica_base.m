clear all
close all
% deltaT=T-trend
% deltaT=[Io Id Iout Io_rms Id_rms Iout_rms (vel)??]*par

load("test_20220111_181745.mat");period=period/60/60;
DISABLE_PERIOD_STOP=false;
USE_PERIOD=false;
REMOVE_TEMP_TREND=false || USE_PERIOD;

t_days=(experiment.time-experiment.time(1))';
t_minutes=(t_days)*24*60;
t=t_days;

Id=experiment.Id;
Iout=experiment.Iout;
Iq=experiment.Iq;
Temp=experiment.Temperature;
Idm=experiment.mean_Id.^2;
Ioutm=experiment.mean_Iout.^2;
Iqm=experiment.mean_Iq.^2;
vel=experiment.Speed;
Vdc=experiment.Vdc;

M=[ones(length(t_days),1) sin(2*pi*t_days) cos(2*pi*t_days)];
par=M\Temp;

TempTrend=M*par;
dTemp=Temp-TempTrend;

% figure(1)
% plot(t,Temp)
% hold on
% plot(t,TempTrend,'--')
% legend('Temperature','Temp Trend')

%param=dTemp\[Id,Iout,Iq,Idm,Ioutm,Iqm];        %,vel,Vdc];

%Stima=[Id,Iout,Iq,Idm,Ioutm,Iqm]*param';      %,vel,Vdc];

figure(2)
plot(t,dTemp)
hold on 
[VALp,PKp] = findpeaks(dTemp,'MinPeakProminence', 0.5);
plot(t,dTemp,t(PKp),dTemp(PKp),'r*')
hold on 
[VALn,PKn] = findpeaks(-dTemp,'MinPeakProminence', 0.5);
plot(t,dTemp,t(PKn),dTemp(PKn),'b*')

% figure(3)
% plot(t,dTemp)
% hold on
% B = 1/20*ones(20,1);
% dTemp = filter(B,1,dTemp);
% TF = islocalmin(dTemp,'MinSeparation',0.03,'SamplePoints',t);
% plot(t,dTemp,t(TF),dTemp(TF),'r*')
%hold on
%plot(t,Stima,'--')
%legend('deltaT','stima')
