function modbus_double_motor(test_name,simulate_connection)
if (nargin<2)
    simulate_connection=true;
end

% get the user name
username=char(java.lang.System.getProperty('user.name'));
com_mapping=readtable('com_mapping.xlsx');
row = com_mapping(strcmp(com_mapping.username, username), :);
if isempty(row)
    error('No COM mapping for user %s. Add it to com_mapping.xlxs',username);
end
com_left=row.left;
com_right=row.right;
test_path=row.folder{1};
fprintf('Username = %s, left COM = %d, right COM = %d, saving folder = %s\n',username,com_left,com_right,test_path);


if not(simulate_connection)
    LeftMotor = OpenDriveConnection(38400,com_left);
    RightMotor = OpenDriveConnection(38400,com_right);
end
disp('connected')

% Mdplc, in params:
% ipa 11000 sono parametri settabili
% ipa 12000 sono parametri in sola lettura

read_ipa=readtable('ipa.xlsx','Sheet','read-only');
write_ipa=readtable('ipa.xlsx','Sheet','read-write');


dt=1;
minuti=60;
ore=60*60;
giorni=24*60*60;

load(test_name);
t=experiment.ref_time;


plot_period=5*minuti;
experiment_name=[test_name,'_',datestr(now,'yyyymmdd_HHMMSS'),'.mat'];

plot_timer=tic;
start_experiment_time=now;
exp_time=0;
icycle=0;
hbox=msgbox('Press ok to exist');
while exp_time<t(end)
    if not(isvalid(hbox))
        break
    end
    cycle_timer=tic;

    icycle=icycle+1;
    act_time=now;
    exp_time=(act_time-start_experiment_time)*giorni;

    experiment.time(icycle)=act_time;

    isp=find(t<=exp_time,1,'last');
    if not(simulate_connection)
        for idx=1:size(write_ipa,1)
            set(LeftMotor.Modbus,write_ipa.Type{idx},write_ipa.IPA(idx),0,experiment.left.(write_ipa.Name(idx)));
            set(RightMotor.Modbus,write_ipa.Type{idx},write_ipa.IPA(idx),0,experiment.right.(write_ipa.Name(idx)));
        end
    end

    for idx=1:size(read_ipa,1)
        if (simulate_connection)
            value=1;
        else
            value=get(LeftMotor.Modbus,read_ipa.Type{idx},read_ipa.IPA(idx),0);
        end
        experiment.left.(read_ipa.Name{idx})(icycle,1)=value;

        if (simulate_connection)
            value=1;
        else
            value=get(RightMotor.Modbus,read_ipa.Type{idx},read_ipa.IPA(idx),0);
        end
        experiment.right.(read_ipa.Name{idx})(icycle,1)=value;

    end
    pause(dt-toc(cycle_timer))

    if toc(plot_timer)>plot_period
        if not(simulate_connection)
            save([test_path,filesep,experiment_name],'experiment');
        end
        plot_timer=tic;
        figure(1)
        tiledlayout(round((size(read_ipa,1)+2)/2),2)
        nexttile
        plot(t/giorni+start_experiment_time,left_speed_target);
        hold on
        plot(act_time,left_speed_target(icycle),'ok');
        datetick('x', 'HH:MM:SS', 'keeplimits')
        ylabel('left Speed setpoint');

        nexttile
        plot(t/giorni+start_experiment_time,left_torque_ref);
        datetick('x', 'HH:MM:SS', 'keeplimits')
        ylabel('left Torque ref');

        for idx=1:size(read_ipa,1)
            nexttile
            plot(experiment.time,experiment.left.(read_ipa.Name{idx}))
            ylabel(['left ',read_ipa.Name{idx}]);
            datetick('x', 'HH:MM:SS', 'keeplimits')
        end

        figure(2)
        tiledlayout(round((size(read_ipa,1)+2)/2),2)
        nexttile
        plot(t/giorni+start_experiment_time,left_speed_target);
        hold on
        plot(act_time,left_speed_target(icycle),'ok');
        datetick('x', 'HH:MM:SS', 'keeplimits')
        ylabel('left Speed setpoint');

        nexttile
        plot(t/giorni+start_experiment_time,right_torque_ref);
        datetick('x', 'HH:MM:SS', 'keeplimits')
        ylabel('right Torque ref');
        for idx=1:size(read_ipa,1)
            nexttile
            plot(experiment.time,experiment.right.(read_ipa.Name{idx}))
            ylabel(['right ',read_ipa.Name{idx}]);
            datetick('x', 'HH:MM:SS', 'keeplimits')
        end
    end

end

if isvalid(hbox)
   close(hbox)
end
if not(simulate_connection)
    for idx=1:2
        set(LeftMotor.Modbus,write_ipa.Type{idx},write_ipa.IPA(idx),0,0);
        set(RightMotor.Modbus,write_ipa.Type{idx},write_ipa.IPA(idx),0,0);
    end

    save([test_path,filesep,experiment_name],'experiment');
end