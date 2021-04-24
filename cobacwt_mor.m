% Contoh 1 dan Gambar 3 dan Gambar 4 
% Membangkitkan dua sinusoaida yang berubah frekuensi secara step 
% Menerapkan alihragam wavelet kontinyu dan menggambar hasilnya 
  
% clear all; close all; 
plot(x) 
% Setting konstanta 
x=x;
x=x.';
fs = 8020;                           % frekuensi sampling 
N = length(x);                           % panjang sinyal 
%N=1152;
N1 = N/2;                           % jumlah titik wavelet 
% f1 = 10;                            % frekuensi sinusoida pertama dalam Hz 
% f2 = 40;                            % frekuensi sinusoida kedua dalam Hz
 
resol_level = N1/4;                  % jumlah nilai a 
decr_a = .5;                        % penurunan a 
a_init = 4;                         % nilai awal a 
wo = pi*sqrt(2/log2(2));            % faktor skala frekuensi wavelet 
  
% Membangkitkan dua gelombang sinus pada Gambar 3 
tn = (1:N/4)/fs;                 % vektor waktu utk membangkitkan sinus 
b = (1:N)/fs;                    % vektor waktu untuk plotting 
%x = [zeros(N/4,1);sin(2*pi*f1*tn)';sin(2*pi*f2*tn)';zeros(N/4,1)]; 
%x1=load ('relax-1-10.02.20.15.33.53.csv');
%x=x1(:,9);
plot (b,x) 
xlabel('waktu, detik') 
ylabel('amplitude') 
title('Sinyal Sinus 10 dan 40 Hz') 
ti = ((1:N1/2)/fs)*10;           % vektor waktu untuk membangun wavelet 
  
% Menghitung alihragam wavelet kontinyu (wavelet morlet) 
for i = 1:resol_level 
    a(i) = a_init/(1+i*decr_a);     % set skala 
    t = abs(ti/a(i));               % vektor skala untuk wavelet 
    mor = (exp(-t.^2).*cos(wo*t))/sqrt(a(i)); 
    wavelet = [fliplr(mor) mor]     % membuat simetri terhadap nol 
    ip = conv(x, wavelet);          % konvolusi wavelet dan sinyal 
    ex = fix((length(ip)-N)/2);     % menghitung titik tambahan/2 
    CW_Trans(:,i) = ip(ex+1:N+ex,1); 
end 
  
% Plot dalam 3 dimensi 
figure 
d = fliplr(CW_Trans); 
mesh(a,b,CW_Trans) 
xlabel('skala a') 
ylabel('b (detik)') 
zlabel('CWT') 
title('CWT Sinyal Sinus 10 dan 40 Hz') 
rotate3d on 
% view(130,50)