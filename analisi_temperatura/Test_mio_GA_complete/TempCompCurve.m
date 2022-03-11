function F = TempCompCurve(x,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,t)
%% Calculate temp Curve from newton cooling matrix

%% Variabili conosciute

%Id_rms,Id,Iq_rms,Iq,Pw_rms,Pws,vel_rms,vel

%% incognite
K = x(1);
k_Id_rms = x(2);
k_Id = x(3);
k_Iq_rms = x(4);
k_Iq = x(5);
k_Pw_rms = x(6);
k_Pws = x(7);
k_vel_rms = x(8);
k_vel = x(9);
%% Temperatures Calculations

T= (k_Id_rms*Id_rms + k_Id*Id + k_Iq_rms*Iq_rms + k_Iq*Iq + k_Pw_rms*Pw_rms + k_Pws*Pws + k_vel_rms*vel_rms + k_vel*vel)/K;

F=[T];
end





