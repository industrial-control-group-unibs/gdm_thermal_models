clear all;clc;close all

simulate_connection=true;

if not(simulate_connection)
    Motor = OpenDriveConnection(38400,'6');
end
% Mdplc, in params:
% ipa 11000 sono parametri settabili
% ipa 12000 sono parametri in sola lettura

read_ipa={
    "RMS_Id"      , 12010;
    "RMS_Iq"      , 12012;
    "RMS_Iout"    , 12014;
    "RMS_Vdc"     , 12016;
    "RMS_Vout"    , 12018;
    "RMS_Speed"   , 12020;
    "Temperature" ,   272;
    };

SPEED_SETPOINT=11000;

dt=1;

t=(0:dt:(30*60));
speed_min=5;
speed_max=90;
speed_mean=mean([speed_max speed_min]);
speed_ampl=speed_max-speed_mean;
period=10*60;
speed_target=speed_mean+speed_ampl*sin(2*pi/period*t);

experiment_name=['test_',datestr(now,'yyyymmdd_HHMMSS'),'.mat'];
experiment=[];
for icycle=1:length(t)
    cycle_timer=tic;
    experiment.time(icycle)=now;
    set(Load.Modbus,'ParDword',SPEED_SETPOINT,0,speed_target(idx));
    for idx=1:length(read_ipa)
        if (simulate_connection)
            value=1;
        else
            value=get(Motor.Modbus,'ParDWord',read_ipa{idx,2},0);
        end
        experiment.(read_ipa{idx,1})(icycle,1)=value;
    end
    if not(simulate_connection)
        pause(dt-toc(cycle_timer))
    end
    if mod(idx ,60)==0
        save(experiment_name,'experiment');
    end
end
%
%y=get(Motor.Modbus,'ParDWord',12010,0);
plot(experiment.time,experiment.RMS_Id)

save(experiment_name,'experiment');