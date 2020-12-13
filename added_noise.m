%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deep learning 02456                                   %
% Adding Canteen noise and small speech                 %
% Final Project                                         %
% Data: 30-11-2020 by Victor R. Holm                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

listing = dir('*Clean*.wav');
[Noise,fs]=audioread('Background_Canteen_16khz.wav');
index = [10,11,12,13,14,15,16,17,18,19,1,2,3,4,5,6,7,8,9,];

for i=1:1 % find and decide noise section
    Low_lim = 10;
    up_lim = 60*2.5;

    %figure
    %subplot(3,1,1)
    t = 0:1/fs:(length(Noise)-1)/fs;
    %plot(t,Noise(:,1))
    %hold on
    %plot([t(find(t==Low_lim)) t(find(t==Low_lim))],[min(Noise(:,1))/2 max(Noise(:,1))/2], 'g')
    %plot([t(find(t==up_lim)) t(find(t==up_lim))],[min(Noise(:,1))/2 max(Noise(:,1))/2], 'r')
    %xlabel('time [s]')

    noise2 = Noise(find(t==Low_lim):find(t==up_lim),:);
    t2 = t(find(t==Low_lim):find(t==up_lim));

    %subplot(3,1,2)
    %plot(t2,noise2(:,1))
    %hold on 
    %plot([t2(1) t2(1)],[min(noise2(:,1)) max(noise2(:,1))],'g')
    %plot([t2((length(noise2)-1)/4) t2((length(noise2)-1)/4)],[min(noise2(:,1)) max(noise2(:,1))],'g')
    %plot([t2((length(noise2)-1)/2) t2((length(noise2)-1)/2)],[min(noise2(:,1)) max(noise2(:,1))],'g')
    %plot([t2((length(noise2)-1)*3/4) t2((length(noise2)-1)*3/4)],[min(noise2(:,1)) max(noise2(:,1))],'g')
    %plot([t2(end) t2(end)],[min(noise2(:,1)) max(noise2(:,1))],'g')

    S = 4;  % six faces
    R = 1;  % each dice is rolled 3 times
    N = 1;  % roll 10 dice at once
    T = 1;  % repeat all 4 times

    data_matrix(1).data = noise2(1:(length(noise2)-1)/4,:);
    data_matrix(2).data = noise2((length(noise2)-1)/4:(length(noise2)-1)/2,:);
    data_matrix(3).data = noise2((length(noise2)-1)/2:(length(noise2)-1)*3/4,:);
    data_matrix(4).data = noise2((length(noise2)-1)*3/4:end,:);

    %subplot(3,1,3)
    %plot(data_matrix(Out(:,:,1)).data(:,1))
end

% adding Canteen noise
for i=1:length(listing)
    clear data fs
    [data,fs]=audioread(listing(i).name);
    
    Out = randi([1 S],[R N T]); % dice, change the dice in the for loop ^
    
    %noise = Noise(3520240:length(data)+3520240-1);
    noise = data_matrix(Out(:,:,1)).data(1:length(data),:);

    figure
    subplot(3,1,1)
    plot(noise)
    title(sprintf('noise signal %d dB'))

    subplot(3,1,2)
    plot(data(:,1))
    title(sprintf('Sound file %s',listing(i).name))

    data_w_noise = data + noise;

    subplot(3,1,3)
    plot(data_w_noise(:,1))
    title('Sound signal with noise')

    G= sprintf('Canteen_%d_16khz.wav',index(i));
    audiowrite(G,data_w_noise,fs)
end
close all

%% Adding small specch
clear all
close all
clc

listing = dir('*Clean*.wav');
[Noise,fs]=audioread('Low_speak_16khz.wav');
index = [10,11,12,13,14,15,16,17,18,19,1,2,3,4,5,6,7,8,9,];
    
SNR = nan(1,length(listing));

for i=1:1 % find and decide noise section
    Low_lim = 17;
    up_lim = 60*3.5;
    
    %[data,fs2]=audioread(listing(i).name);
    t_noise = 0:1/fs:(length(Noise)-1)/fs;
    %t_data = 0:1/fs2:(length(data)-1)/fs2; 
    
    noise2 = Noise(find(t_noise==Low_lim):find(t_noise==up_lim),:);
    t2 = t_noise(find(t_noise==Low_lim):find(t_noise==up_lim));
    
    S = 4;  % six faces
    R = 1;  % each dice is rolled 3 times
    N = 1;  % roll 10 dice at once
    T = 1;  % repeat all 4 times

    data_matrix(1).data = noise2(1:(length(noise2)-1)/4,:);
    data_matrix(2).data = noise2((length(noise2)-1)/4:(length(noise2)-1)/2,:);
    data_matrix(3).data = noise2((length(noise2)-1)/2:(length(noise2)-1)*3/4,:);
    data_matrix(4).data = noise2((length(noise2)-1)*3/4:end,:);
end

% adding low speech noise
for i=1:length(listing)
    clear data fs
    [data,fs]=audioread(listing(i).name);
    
    Out = randi([1 S],[R N T]); % dice, change the dice in the for loop ^
    
    noise = data_matrix(Out(:,:,1)).data(1:length(data),:)*3;
    data_w_noise = data + noise;
    %SNR(i) = snr(data(:,1),noise);
    
    if index(i)==9
        figure
        subplot(3,1,1)
        plot(noise)
        title(sprintf('noise signal'))

        subplot(3,1,2)
        plot(data(:,1))
        title(sprintf('Sound file %s',listing(i).name))

        subplot(3,1,3)
        plot(data_w_noise(:,1))
        title(sprintf('Sound signal with noise with SNR=%d dB',SNR))
    end

    G= sprintf('Background_talk_%d_16khz.wav',index(i));
    audiowrite(G,data_w_noise,fs)
end
%SNR_mean=mean(SNR);
%close all

%% Adding Party Noise
clear all
close all
clc

listing = dir('*Clean*.wav');
[Noise,fs]=audioread('Party_noise_16khz.wav');
index = [10,11,12,13,14,15,16,17,18,19,1,2,3,4,5,6,7,8,9,];

SNR = nan(1,length(listing));

for i=1:1 % find and decide noise section
    Low_lim = 10;
    up_lim = 60*3.5;
    
    [data,fs2]=audioread(listing(i).name);
    t_noise = 0:1/fs:(length(Noise)-1)/fs;
    t_data = 0:1/fs2:(length(data)-1)/fs2; 
    
    noise2 = Noise(find(t_noise==Low_lim):find(t_noise==up_lim),:);
    t2 = t_noise(find(t_noise==Low_lim):find(t_noise==up_lim));
    
    figure
    subplot(2,1,1)
    plot(t_noise, Noise)
    title('Støj signal')
    
    subplot(2,1,2)
    plot(t_data,data)
    title('tale signal')
    
    S = 3;  % six faces
    R = 1;  % each dice is rolled 3 times
    N = 1;  % roll 10 dice at once
    T = 1;  % repeat all 4 times

    data_matrix(1).data = noise2(1:(length(noise2)-1)/4,:);
    data_matrix(2).data = noise2((length(noise2)-1)/4:(length(noise2)-1)/2,:);
    data_matrix(3).data = noise2((length(noise2)-1)/2:(length(noise2)-1)*3/4,:);
    data_matrix(4).data = noise2((length(noise2)-1)*3/4:end,:);
end
%
% adding low speech noise
for i=1:length(listing)
    clear data fs
    [data,fs]=audioread(listing(i).name);
    
    Out = randi([1 S],[R N T]); % dice, change the dice in the for loop ^
    
    %noise = data_matrix(Out(:,:,1)).data(1:length(data));
    noise = Noise(1:length(data))*0.5;
    data_w_noise = data + noise;
    SNR(i) = snr(data(:,1),noise);
    
    if index(i)==9
        figure
        subplot(3,1,1)
        plot(noise)
        title(sprintf('noise signal'))

        subplot(3,1,2)
        plot(data(:,1))
        title(sprintf('Sound file %s',listing(i).name))

        subplot(3,1,3)
        plot(data_w_noise(:,1))
        title(sprintf('Sound signal with noise with SNR=%d dB',SNR))
    end

    G= sprintf('PartyNoise_%d_16khz.wav',index(i));
    audiowrite(G,data_w_noise,fs)
end
SNR_mean=mean(SNR);
% close all

%% Adding Car Noise
clear all
close all
clc

listing = dir('*Clean*.wav');
[Noise,fs]=audioread('car_noise_16khz.wav');
index = [10,11,12,13,14,15,16,17,18,19,1,2,3,4,5,6,7,8,9,];

SNR = nan(1,length(listing));

for i=1:1 % find and decide noise section
    Low_lim = 10;
    up_lim = 60*3.5;
    
    [data,fs2]=audioread(listing(i).name);
    t_noise = 0:1/fs:(length(Noise)-1)/fs;
    t_data = 0:1/fs2:(length(data)-1)/fs2; 
    
    noise2 = Noise(find(t_noise==Low_lim):find(t_noise==up_lim),:);
    t2 = t_noise(find(t_noise==Low_lim):find(t_noise==up_lim));
    
    figure
    subplot(2,1,1)
    plot(t_noise, Noise)
    title('Støj signal')
    
    subplot(2,1,2)
    plot(t_data,data)
    title('tale signal')
    
    S = 3;  % six faces
    R = 1;  % each dice is rolled 3 times
    N = 1;  % roll 10 dice at once
    T = 1;  % repeat all 4 times

    data_matrix(1).data = noise2(1:(length(noise2)-1)/4,:);
    data_matrix(2).data = noise2((length(noise2)-1)/4:(length(noise2)-1)/2,:);
    data_matrix(3).data = noise2((length(noise2)-1)/2:(length(noise2)-1)*3/4,:);
    data_matrix(4).data = noise2((length(noise2)-1)*3/4:end,:);
end
%
% adding low speech noise
for i=1:length(listing)
    clear data fs
    [data,fs]=audioread(listing(i).name);
    
    Out = randi([1 S],[R N T]); % dice, change the dice in the for loop ^
    
    %noise = data_matrix(Out(:,:,1)).data(1:length(data));
    noise = Noise(1:length(data))*1.5;
    data_w_noise = data + noise;
    SNR(i) = snr(data(:,1),noise);

    if index(i)==9
        figure
        subplot(3,1,1)
        plot(noise)
        title(sprintf('noise signal'))

        subplot(3,1,2)
        plot(data(:,1))
        title(sprintf('Sound file %s',listing(i).name))

        subplot(3,1,3)
        plot(data_w_noise(:,1))
        title(sprintf('Sound signal with noise with SNR=%d dB',SNR))
    end

    G= sprintf('CarNoise_%d_16khz.wav',index(i));
    audiowrite(G,data_w_noise,fs)
end
SNR_mean=mean(SNR);
% close all



