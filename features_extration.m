function Features_list_per_segments=features_extration(EEG,fs)

% EEG single-channel 
% fs-sampling frequency
% features_extration-segmented EEG on 20s and extract features per segments
%Features_list_per_segments-extracted 20 features per 20s EEG segments


[Row,N]=size(EEG);
windows1=20*fs;
NO_20s=round(N/(windows1))-1; 


    for mm=1:1:NO_20s %

        recorddata_EEG_20s=EEG((mm-1)*windows1+1:(mm)*windows1); 

     

        recorddata_EEG_20s=do_bandpass_filtering(recorddata_EEG_20s,fs,0.5,30);%%%Jako vazno
   
         Features_list=features_exctration_single_channel_segments(recorddata_EEG_20s, fs);
         Features_list_per_segments(mm,:)=Features_list;
    end



end