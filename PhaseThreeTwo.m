clear all; close all;
load allTheNumbers;
record = audiorecorder(fs,16,1); % fs is the sampling frequency
disp('Start speaking.');
recordblocking(record, 1);
disp('End of Recording.');
signal2 = getaudiodata(record); %saving the signal as data
T=1/fs;
df=1;
f=0:df:fs/2;
t=(0:(length(signal2)-1))*T;

fx2=abs(fft(signal2,fs+1)); ffx2=fx2(1:fs/2+1);
total2=zeros(400,1);

for m=1:399
[d,c]=butter(4,[(0.00005+(m-1)*0.0025) (0.00255+(m-1)*0.0025)],'bandpass');
xx2=filter(d,c,signal2);
fxx2=abs(fft(xx2,fs+1)); ffxx2=fxx2(1:fs/2+1);
total2(m)=sum(ffxx2(1+50*(m-1):51+50*(m-1)).^2);
end

[d,c]=butter(4,[19552/20000 19999/20000],'bandpass');
xx2=filter(d,c,signal2);
fxx2=abs(fft(xx2,fs+1)); ffxx2=fxx2(1:fs/2+1);
total2(400)=sum(ffxx2(19552:19999).^2);

% [h2,ff]=freqz(d,c,fs/2,fs);

%%
numb={'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'};

comp=zeros(1,10);

for i= 1:400
    inn=0; 
    l=0;
    index=0;
    in=[];
    for k=1:10
     inn=abs(allTheNumbers(i,k)-total2(i,1));
     in=[in inn];
    end
    innn=sort(in,'descend');
    for i2=1:10
      for k2=1:10
        if in(k2)<innn(i2)
         comp(k2)=comp(k2)+1;
        end      
      end
    end 
end

for i=1:10
    if comp(i)>comp(k)
        k=i;
    end
end

disp('You said ');
disp(numb(k));