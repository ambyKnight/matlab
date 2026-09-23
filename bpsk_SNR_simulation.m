clc , clearvars;

%bpsk

bits = 2*randi([0 1],1,1000)-1; %generation of random bits

snrValues = 0:0.01:10; %change snr max from here
berValues = []; %BER values so i can plot em later

for k=1:numel(snrValues)
    snr=snrValues(k);
    rx= awgn(bits,snr);
    detectedBits= 2*(rx>0)-1;
    ber= mean(detectedBits ~= bits);
    berValues(k)=ber;
end

plot(snrValues,berValues)
xlabel('snr(DB)')
ylabel('BER')
title('BPSK BER vs SNR')
grid on;
