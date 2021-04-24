function [A4,D1,D2,D3,D4] = Wavelet(mySignal,waveletFunction)
[C,L] = wavedec(mySignal,4,waveletFunction);

%Calculation The Coificients Vectors of every Band 
cD1 = detcoef(C,L,1);  
cD2 = detcoef(C,L,2); 
cD3 = detcoef(C,L,3);
cD4 = detcoef(C,L,4); 
cA4 = appcoef(C,L,waveletFunction,4);

%Calculation the Details Vectors of every Band : 
D1 = wrcoef('d',C,L,waveletFunction,1); 
D2 = wrcoef('d',C,L,waveletFunction,2);  
D3 = wrcoef('d',C,L,waveletFunction,3);  
D4 = wrcoef('d',C,L,waveletFunction,4);   
A4 = wrcoef('a',C,L,waveletFunction,4); 