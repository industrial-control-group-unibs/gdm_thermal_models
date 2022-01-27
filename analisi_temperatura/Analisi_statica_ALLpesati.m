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
Id_rms_n=(Id_rms-min(Id_rms))/(max(Id_rms)-min(Id_rms));
Id=experiment.mean_Id.^2;
Id_n=(Id-min(Id))/(max(Id)-min(Id));
Iq_rms=experiment.Iq;
Iq_rms_n=(Iq_rms-min(Iq_rms))/(max(Iq_rms)-min(Iq_rms));
Iq=experiment.mean_Iq.^2;
Iq_n=(Iq-min(Iq))/(max(Iq)-min(Iq));
Iout_rms=experiment.Iout;
Iout=experiment.mean_Iout.^2;
Vout_rms=experiment.Vout;
Vout=experiment.mean_Vout.^2;
vel_rms=experiment.Speed;
vel_rms_n=(vel_rms-min(vel_rms))/(max(vel_rms)-min(vel_rms));
vel=experiment.mean_Speed.^2;
vel_n=(vel-min(vel))/(max(vel)-min(vel));

Temp=T-Te;
Pw_rms=Iout_rms.*Vout_rms;
Pw_rms_n=(Pw_rms-min(Pw_rms))/(max(Pw_rms)-min(Pw_rms));
Pws=Iout.*Vout;
Pws_n=(Pws-min(Pws))/(max(Pws)-min(Pws));

param=[Id_rms_n,Id_n,Iq_rms_n,Iq_n,Pw_rms_n,Pws_n,vel_rms_n,vel_n];

coef=Temp\param;
Stima=coef*param';

figure(1)
plot(t,Temp)
hold on
plot(t,Stima,'--')
legend('Temperature','Stima')

