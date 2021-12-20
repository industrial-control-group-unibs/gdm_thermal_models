clear all;clc;close all;
%load("test_20211215_180327.mat"); period=4/24;
%load("test_20211216_180808.mat"); period=4/24;
%load("test_20211216_211704.mat"); period=4/24;
%load("test_20211216_224425.mat"); period=8/24;
%load("test_20211217_105307.mat"); period=1/24;
%load("test_20211217_133237.mat"); period=period/60/60;
%load("test_20211217_155353.mat"); period=period/60/60;
load("test_20211220_174402.mat"); period=period/60/60;
DISABLE_PERIOD_STOP=false;
USE_PERIOD=false;
REMOVE_TEMP_TREND=false || USE_PERIOD;


figure
tl=tiledlayout(3,2);

t_days=(experiment.time-experiment.time(1))';
t_minutes=(t_days)*24*60;

if  USE_PERIOD
    t=mod(t_days,period);
else
    t=t_days;
end

ticks=min(t):(1/24*(5/60)):max(t);

if DISABLE_PERIOD_STOP
    idxs_remove=mod(t_minutes,5)<0.5;
    fields=fieldnames(experiment);
    for ifield=2:length(fields)-1
        experiment.(fields{ifield})(idxs_remove)=nan;
    end
else
    idxs_remove=zeros(length(t_days),1);
end


ax(1)=nexttile;
plot(t,experiment.Speed)
if isfield(experiment,'setpoint_speed')
    hold on
    plot(t,experiment.setpoint_speed)
    legend('Speed','Target speed')
end
xlabel('time');
ylabel('speed [rad/s]')
grid on

set(gca,'Xtick',ticks)
datetick('x', 'HH:MM:SS', 'keeplimits','keepticks')


ax(4)=nexttile;
plot(t,experiment.Vdc)
hold on
plot(t,experiment.Vout/5.47*2)

xlabel('time');
ylabel('Voltage [V] SCALA ERRATA')
set(gca,'Xtick',ticks)
datetick('x', 'HH:MM:SS', 'keeplimits','keepticks')
grid on
legend('VdcLink','Vout')




ax(2)=nexttile;
Iout=experiment.Iout;
plot(t,experiment.Id)
hold on
plot(t,experiment.Iout)
plot(t,experiment.Iq)
if isfield(experiment,'mean_Iq')
    plot(t,experiment.mean_Id,'--')
    plot(t,experiment.mean_Iout,'--')
    plot(t,experiment.mean_Iq,'--')
    legend('Id','Iout','Iq','mean Id','mean Iout','mean Iq')
else
    legend('Id','Iout','Iq')
end
set(gca,'Xtick',ticks)
datetick('x', 'HH:MM:SS', 'keeplimits','keepticks')
grid on

xlabel('time');
ylabel('current [A]')




ax(6)=nexttile;
plot(t,experiment.Id)
set(gca,'Xtick',ticks)
datetick('x', 'HH:MM:SS', 'keeplimits','keepticks')
grid on

xlabel('time');
ylabel('current [A]')
legend('Id')



ax(3)=nexttile;


M=[ones(length(t_days),1) sin(2*pi*t_days) cos(2*pi*t_days)];
par=M\experiment.Temperature;

if REMOVE_TEMP_TREND
    plot(t,experiment.Temperature-M*par)
else
    plot(t,experiment.Temperature)
    hold on
    plot(t,M*par,'--')
    legend('Temperature','Daily Trend')
end
xlabel('time');
ylabel('temperature [°C]')
set(gca,'Xtick',ticks)
datetick('x', 'HH:MM:SS', 'keeplimits','keepticks')
grid on


ax(5)=nexttile;
M=[ones(length(t_days),1) (sin(2*pi/period*t_days)) (cos(2*pi/period*t_days))];

par=M(not(idxs_remove),:)\experiment.Vout(not(idxs_remove),:);

plot(t,experiment.Vout)
hold on
if isfield(experiment,'mean_Vout')
    plot(t,experiment.mean_Vout,'--')
    legend('rms Vout','mean Vout')
else
    legend('Vout')
end
xlabel('time');
ylabel('Voltage [V] SCALA ERRATA')
set(gca,'Xtick',ticks)
datetick('x', 'HH:MM:SS', 'keeplimits','keepticks')
grid on


linkaxes(ax,'x')
xlim([min(t) max(t)])
