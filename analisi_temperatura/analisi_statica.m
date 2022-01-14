% deltaT=T-trend
% deltaT=[Io Id Iout Io_rms Id_rms Iout_rms (vel)??]*par

load("test_20220111_181745.mat");period=period/60/60;
DISABLE_PERIOD_STOP=false;
USE_PERIOD=false;
REMOVE_TEMP_TREND=false || USE_PERIOD;

t_days=(experiment.time-experiment.time(1))';
t_minutes=(t_days)*24*60;

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

figure(1)
plot(t,Temp)
hold on
plot(t,TempTrend,'--')
legend('Temperature','Temp Trend')

figure(2)
plot(t,dTemp)
legend('deltaT')

param=dTemp\[Id,Iout,Iq,Idm,Ioutm,Iqm,vel,Vdc];

Stima=[Id,Iout,Iq,Idm,Ioutm,Iqm,vel,Vdc]*param';

figure(3)
plot(t,Stima)
legend('deltaT')
