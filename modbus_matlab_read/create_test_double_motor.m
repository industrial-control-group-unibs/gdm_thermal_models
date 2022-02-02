clear all;clc;close all



dt=1;
minuti=60;
ore=60*60;
giorni=24*60*60;
write_ipa=readtable('ipa.xlsx','Sheet','read-write');
plot_period=5*minuti;

test_number=2;

switch test_number
    case 1
        test_name='test1';
        t=(0:dt:48*ore)';
        period_left=12*ore;
        period_right=8.5*ore;

        % left
        speed_max=210;
        speed_min=-speed_max;
        speed_mean=mean([speed_max speed_min]);
        speed_ampl=speed_max-speed_mean;
        left.(write_ipa.Name{1})=speed_mean+speed_ampl*sin(2*pi/period_left*t);
        left.(write_ipa.Name{2})=0*ones(length(t),1);
        left.(write_ipa.Name{3})=1*ones(length(t),1);

        % right
        torque_max=3;
        torque_min=-torque_max;
        torque_mean=mean([torque_max torque_min]);
        torque_ampl=torque_max-torque_mean;
        right.(write_ipa.Name{1})=0*ones(length(t),1);
        right.(write_ipa.Name{2})=torque_mean+torque_ampl*sin(2*pi/period_right*t);
        right.(write_ipa.Name{3})=0*ones(length(t),1);
    case 2
        test_name='test_short';
        t=(0:dt:4*minuti)';
        period_left=1*minuti;
        period_right=2*minuti;

        % left
        speed_max=210;
        speed_min=-speed_max;
        speed_mean=mean([speed_max speed_min]);
        speed_ampl=speed_max-speed_mean;
        left.(write_ipa.Name{1})=speed_mean+speed_ampl*sin(2*pi/period_left*t);
        left.(write_ipa.Name{2})=0*ones(length(t),1);
        left.(write_ipa.Name{3})=1*ones(length(t),1);

        % right
        torque_max=3;
        torque_min=-torque_max;
        torque_mean=mean([torque_max torque_min]);
        torque_ampl=torque_max-torque_mean;
        right.(write_ipa.Name{1})=0*ones(length(t),1);
        right.(write_ipa.Name{2})=torque_mean+torque_ampl*sin(2*pi/period_right*t);
        right.(write_ipa.Name{3})=0*ones(length(t),1);
end
experiment.left=left;
experiment.right=right;
experiment.test_name=test_name;
experiment.ref_time=t;

username=char(java.lang.System.getProperty('user.name'));
com_mapping=readtable('com_mapping.xlsx');
row = com_mapping(strcmp(com_mapping.username, username), :);
if isempty(row)
    error('No COM mapping for user %s. Add it to com_mapping.xlxs',username);
end
test_path=row.folder{1};
save([test_path,filesep,test_name],'experiment')