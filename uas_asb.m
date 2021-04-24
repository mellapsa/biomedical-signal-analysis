clc; clear all;
%% Pre Processing
%Load File
x  = load ('ASB_UAS.mat');
x  = x.x';
fs = 8020;                % frekuensi sampling 
N  = length(x);           % panjang sinyal 
N1 = 1000;                % jumlah titik wavelet 
wo = pi*sqrt(2/log2(2));  % faktor skala frekuensi wavelet 
b  = (1:N)/fs;            % vektor waktu untuk plotting 
ti = ((1:N1/2)/fs)*10;    % vektor waktu untuk membangun wavelet 
resol_level = 128;        % jumlah titik skala
decr_a = .5;              % penurunan a 
a_init = 4;               % nilai awal a 

%% Plotting

figure('Name','Raw Signal')
plot (b,x)
title('Sinyal Suara Jantung')
xlabel('Time (s)') 
ylabel('Amplitude') 
ylim ([-3e4 3e4]);

%% Analisis Morfologi 1

figure('Name','Raw Signal')
plot (b,x)
title('S1 (Loop)')
xlabel('Time (s)') 
ylabel('Amplitude') 
ylim ([-3e4 3e4]);
xlim ([0 0.3]);
%% Analisis Morfologi 2

figure('Name','Raw Signal')
plot (b,x)
title('S2 (Doop)')
xlabel('Time (s)') 
ylabel('Amplitude') 
ylim ([-3e4 3e4]);
xlim ([0.4 0.7]);

%% Proses Komputasi Mexican Hat
 
for i = 1:resol_level 
    a(i) = a_init/(1+i*decr_a);     % set skala 
    t = abs(ti/a(i));               % vektor skala untuk wavelet 
        % Pilih Mother Wavelet
        mw=(1-(2*(t.^2))).*exp(-t.^2);              % Mexican Hat
    wavelet = [fliplr(mw) mw];      % membuat simetri terhadap nol 
    ip = conv(x, mw);               % konvolusi wavelet dan sinyal 
    ex = fix((length(ip)-N)/2);     % menghitung titik tambahan/2 
    CW_Trans(:,i) = ip(1,ex+1:N+ex); 
end  

% Plot Hasil Transformasi Mexican Hat

figure('Name','Wavelet Transformation')
% subplot(2,1,1)
    d = fliplr(CW_Trans); 
    mesh(a,b,CW_Trans) 
        xlabel('Scale') 
        ylabel('Time (s)') 
        zlabel('CWT') 
        title('CWT with Mexican Hat Mother Wavelet') 
        view (90,-90) %Scalogram View
    rotate3d on 
    
%% Proses Komputasi Morlet
 
for i = 1:resol_level 
    a(i) = a_init/(1+i*decr_a);     % set skala 
    t = abs(ti/a(i));               % vektor skala untuk wavelet 
        % Pilih Mother Wavelet
        mw = (exp(-t.^2).*cos(wo*t))/sqrt(a(i));    % Morlet
    wavelet = [fliplr(mw) mw];      % membuat simetri terhadap nol 
    ip = conv(x, mw);               % konvolusi wavelet dan sinyal 
    ex = fix((length(ip)-N)/2);     % menghitung titik tambahan/2 
    CW_Trans(:,i) = ip(1,ex+1:N+ex); 
end  

%% Plot Hasil Transformasi Morlet
figure
% subplot(2,1,2)
    d = fliplr(CW_Trans); 
    mesh(a,b,CW_Trans) 
        xlabel('Scale') 
        ylabel('Time (s)') 
        zlabel('CWT') 
        title('CWT with Morlet Mother Wavelet') 
        view (90,-90) %Scalogram View
% Plot dalam 3 dimensi 
figure 
d = fliplr(CW_Trans); 
mesh(a,b,CW_Trans) 
xlabel('skala a') 
ylabel('b (detik)') 
zlabel('CWT') 
title('CWT Sinyal Sinus 10 dan 40 Hz') 
rotate3d on 
% Plot dalam 3 dimensi 
figure 
d = fliplr(CW_Trans); 
mesh(a,b,CW_Trans) 
xlabel('skala a') 
ylabel('b (detik)') 
zlabel('CWT') 
title('CWT Sinyal Sinus 10 dan 40 Hz') 
rotate3d on 
