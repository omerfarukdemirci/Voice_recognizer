clear all, close all; clc;

allTheNumbers=[];

for number=1:10
fs=40000;
record = audiorecorder(fs,16,1); % fs is the sampling frequency
disp('Start speaking.');
recordblocking(record, 1);
disp('End of Recording.');
signal = getaudiodata(record); %saving the signal as data
T=1/fs;
df=1;
f=0:df:fs/2;
t=(0:(length(signal)-1))*T;

fx=abs(fft(signal,fs+1)); ffx=fx(1:fs/2+1);
total=zeros(400,1);

for m=1:399
[b,a]=butter(4,[(0.00005+(m-1)*0.0025) (0.00255+(m-1)*0.0025)],'bandpass');
xx=filter(b,a,signal);
fxx=abs(fft(xx,fs+1)); ffxx=fxx(1:fs/2+1);
total(m)=sum(ffxx(1+50*(m-1):51+50*(m-1)).^2);
end

[b,a]=butter(4,[19552/20000 19999/20000],'bandpass');
xx=filter(b,a,signal);
fxx=abs(fft(xx,fs+1)); ffxx=fxx(1:fs/2+1);
total(400)=sum(ffxx(19552:19999).^2);

allTheNumbers=[allTheNumbers total];

pause(1);

end

save allTheNumbers allTheNumbers fs;
