clear all
close all
% dTemp=T-Te
% C*(dT/dt)= -k1(T-Te) + k2Iq + K3Iq_rms + k4Id + k5Id_rms + k10Pw +
% k11pw_rms +k20Vel + k21Vel_rms

load("test_20220111_181745.mat");

t_days=(experiment.time-experiment.time(1))';
t_minutes=(t_days)*24*60;
t=t_days;
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

Temp=T-Te;
Pw_rms=Iout_rms.*Vout_rms;
Pws=Iout.*Vout;

param=[vel_rms,vel];

coef=Temp\param;
Stima=coef*param';

figure(1)
plot(t,Temp)
hold on
plot(t,Stima,'--')
legend('Temperature','Stima')

