clear all
close all
% dTemp=T-Te
% C*(dT/dt)= -k1(T-Te) + k2Iq + K3Iq_rms + k4Id + k5Id_rms + k10Pw +
% k11pw_rms +k20Vel + k21Vel_rms

load("test_20220111_181745.mat");

t_days=(experiment.time-experiment.time(1))';
t_minutes=(t_days)*24*60;
t=t_minutes;
T=experiment.Temperature;
Te=T(1);
Id_rms=experiment.Id;
Id=experiment.mean_Id.^2;
Iq_rms=experiment.Iq;
Iq=experiment.mean_Iq.^2;
Iout_rms=experiment.Iout;
Iout=experiment.mean_Iout.^2;
Vout_rms=experiment.Vout;
Vout=experiment.mean_Vout.^2;
vel_rms=experiment.Speed;
vel=experiment.mean_Speed.^2;

M=[ones(length(t_days),1) sin(2*pi*t_days) cos(2*pi*t_days)];
par=M\T;

TempTrend=M*par;
dTemp=T-TempTrend;

Temp=T-Te;
Pw_rms=Iout_rms.*Vout_rms;
Pws=Iout.*Vout;

param=[Id_rms,Id,Iq_rms,Iq,Pw_rms,Pws,vel_rms,vel];
 
figure(1)
plot(t,Temp)
hold on 
[VALp,PKp] = findpeaks(dTemp,'MinPeakProminence', 0.5);
plot(t,Temp,t(PKp),Temp(PKp),'r*') 
hold on 
[VALn,PKn] = findpeaks(-dTemp,'MinPeakProminence', 0.5);
plot(t,Temp,t(PKn),Temp(PKn),'b*')

% pause
% 
% Temp1=Temp(1:PKp(1));
% t1=t(1:PKp(1));
% param1=param(1:PKp(1),:);
% coef=Temp1\param1;
% Stima=coef*param1';
% 
% figure(1)
% plot(t1,Temp1)
% hold on
% plot(t1,Stima,'--')
% legend('Temperature','Stima')

