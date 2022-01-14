for idx=1:length(read_ipa)
    value=get(Motor.Modbus,read_ipa{idx,3},read_ipa{idx,2},0);
    fprintf('%s = %f\n',read_ipa{idx,1},value)

end