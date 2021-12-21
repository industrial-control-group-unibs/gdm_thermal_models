clear all;clc;close all
simulate_connection=false;

if not(simulate_connection)
    Motor = OpenDriveConnection(38400,'3');
end
disp('connected')
% Mdplc, in params:
% ipa 11000 sono parametri settabili
% ipa 12000 sono parametri in sola lettura

read_ipa={
    "Iq"          , 12010, 'PARFLOAT';
    "Id"          , 12012, 'PARFLOAT';
    "Iout"        , 12014, 'PARFLOAT';
    "Vdc"         , 12016, 'PARFLOAT';
    "Vout"        , 12018, 'PARFLOAT';
    "Speed"       , 12020, 'PARFLOAT';
    "mean_Iq"     , 12024, 'PARFLOAT';
    "mean_Id"     , 12026, 'PARFLOAT';
    "mean_Iout"   , 12028, 'PARFLOAT';
    "mean_Vdc"    , 12030, 'PARFLOAT';
    "mean_Vout"   , 12032, 'PARFLOAT';
    "mean_Speed"  , 12034, 'PARFLOAT';
    "Temperature" , 12022, 'PARFLOAT';
    };

SPEED_SETPOINT=11000;

dt=1;
minuti=60;
ore=60*60;
giorni=24*60*60;
t=(0:dt:48*ore)';

speed_max=210;
speed_min=-speed_max;

%speed_max=120;
%speed_min=20;

speed_mean=mean([speed_max speed_min]);
speed_ampl=speed_max-speed_mean;
period=12*ore;

plot_period=5*minuti;
speed_target=speed_mean+speed_ampl*sin(2*pi/period*t);

%switch_off_for_measure=(mod(t,5*minuti)>=5);
%speed_target=speed_target.*switch_off_for_measure;

experiment_name=['test_',datestr(now,'yyyymmdd_HHMMSS'),'.mat'];
experiment=[];

plot_timer=tic;
start_experiment_time=now;
exp_time=0;
icycle=0;
while exp_time<t(end)
    
    cycle_timer=tic;

    icycle=icycle+1;
    act_time=now;
    exp_time=(act_time-start_experiment_time)*giorni;
    
    experiment.time(icycle)=act_time;

    isp=find(t<=exp_time,1,'last');
    if not(simulate_connection)
        set(Motor.Modbus,'ParFloat',SPEED_SETPOINT,0,speed_target(isp));
    end
    experiment.setpoint_speed(icycle)=speed_target(isp);
    for idx=1:length(read_ipa)
        if (simulate_connection)
            value=1;
        else
           value=get(Motor.Modbus,read_ipa{idx,3},read_ipa{idx,2},0);
        end
        experiment.(read_ipa{idx,1})(icycle,1)=value;
    end
    pause(dt-toc(cycle_timer))
    
    if toc(plot_timer)>plot_period
        save(experiment_name,'experiment','period');
        plot_timer=tic;
        tiledlayout((length(read_ipa)+1)/2,2)
        nexttile
        plot(t/giorni+start_experiment_time,speed_target);
        hold on
        plot(act_time,speed_target(icycle),'ok');
        datetick('x', 'HH:MM:SS', 'keeplimits')
        ylabel('Speed setpoint');
        for idx=1:length(read_ipa)
            nexttile
            plot(experiment.time,experiment.(read_ipa{idx,1}))
            ylabel(read_ipa{idx,1});
            datetick('x', 'HH:MM:SS', 'keeplimits')
        end
    end

end
set(Motor.Modbus,'ParFloat',SPEED_SETPOINT,0,0.0)
save(experiment_name,'experiment','period');