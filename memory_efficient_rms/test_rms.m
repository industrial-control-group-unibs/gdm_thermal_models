clear all;close all;clc;

n=1000;
t=linspace(0,2*pi,n)';
y=sin(t)+0.1*randn(n,1);

rms_y=rms(y)
%%

brms=BufferRms(10,10,10);

for idx=1:n
    overflow=brms.pushNewData(y(idx));
end
rms_buffer_buffer=brms.rms()
