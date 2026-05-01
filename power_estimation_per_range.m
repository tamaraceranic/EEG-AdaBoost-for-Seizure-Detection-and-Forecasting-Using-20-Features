function [Power_delta,Power_teta,Power_alfa,Power_beta]=power_estimation_per_range(fs,recorddata)

p=round(log2(length(recorddata)));  
 nfft=2^(p-1);
 
detrended_recorddata=recorddata(1:nfft)-mean(recorddata(1:nfft));
[Pxx,f]= pwelch(detrended_recorddata(1:nfft), hann(nfft),ceil(nfft/2),[],fs,'onesided');


 ind_f_DELTA=find(f>= 0.5 & f < 3);
 ind_f_TETA=find(f>= 3 & f < 8);
 ind_f_ALFA=find(f>= 8 & f < 15);
 ind_f_BETA=find(f>= 15 & f < 30);
 
df = f(2) - f(1);
Power_delta=sum(Pxx(ind_f_DELTA)*df);
Power_teta=sum(Pxx(ind_f_TETA)*df);
Power_alfa=sum(Pxx(ind_f_ALFA)*df);
Power_beta=sum(Pxx(ind_f_BETA)*df); 
 
end





