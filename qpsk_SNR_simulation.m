clc;
clearvars;

% QPSK

random_bits = randi([0 1], 1, 1000);

bits_qpsk = reshape(random_bits, 2, []);

symbols = [];

% Convert bit pairs into QPSK symbols
for k = 1:size(bits_qpsk, 2)

    I = 1 - 2*bits_qpsk(1,k);
    Q = 1 - 2*bits_qpsk(2,k);

    symbols(k) = I + 1i*Q;

end


% Show constellation at SNR = 10 dB

snr = 10;

rx = awgn(symbols, snr, 'measured');

scatter(real(rx), imag(rx));
grid on;
xlabel('I');
ylabel('Q');
xline(0);
yline(0);
title('QPSK Constellation');


% Calculate Symbol Error Rate for different SNR values

snrRange = 0:0.01:20;

symbolErrorRate = [];

for s = 1:numel(snrRange)

    snrHere = snrRange(s);

    rxRange = awgn(symbols, snrHere, 'measured');

    detectedSymbols = [];

    % Detect every received symbol
    for k = 1:numel(rxRange)

        if real(rxRange(k)) > 0
            I = 1;
        else
            I = -1;
        end

        if imag(rxRange(k)) > 0
            Q = 1;
        else
            Q = -1;
        end

        detectedSymbols(k) = I + 1i*Q;

    end

    % Count wrong symbols
    count = 0;

    for k = 1:numel(symbols)

        if detectedSymbols(k) ~= symbols(k)
            count = count + 1;
        end

    end

    symbolErrorRate(s) = count / numel(symbols);

end


figure;

plot(snrRange, symbolErrorRate);

xlabel('SNR (dB)');
ylabel('Symbol Error Rate');
title('QPSK SER vs SNR');
grid on;