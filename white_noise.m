%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deep learning 02456                                   %
% White noise script                                    %
% Final Project                                         %
% Data: 30-11-2020 by Victor R. Holm                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

listing = dir('*Clean*.wav');
flag = 0;               % plot flag
db=[-37 -38 -39 -40 -41 -42 -43 -44];
SNR_mean = nan(1,length(db));
SNR = nan(1,length(listing));

index = [10, 11, 12, 13, 14,15,16,17,18,19,1,2,3,4,5,6,7,8,9];
for j=1:length(db)
    clear SNR
    for i=1:length(listing)
        clear data fs
        [data,fs]=audioread(listing(i).name);
        
        noise = wgn(length(data),1,db(j));
        data_w_noise = data + noise;
        SNR(i) = snr(data(:,1),noise);
        
        if index(i)==9
            figure
            subplot(3,1,1)
            plot(noise)
            title(sprintf('noise signal %d dB',db(j)))
            
            subplot(3,1,2)
            plot(data(:,1))
            title(sprintf('Sound file %s',listing(i).name))
            
            subplot(3,1,3)
            plot(data_w_noise(:,1))
            title(sprintf('Sound signal with noise with SNR=%d dB',SNR))
        end
        
        G= sprintf('WN%ddb_%d_16khz.wav',abs(db(j)),index(i));
        %audiowrite(G,data_w_noise,fs)
        close all
    end
    SNR_mean(j)=mean(SNR);
end





