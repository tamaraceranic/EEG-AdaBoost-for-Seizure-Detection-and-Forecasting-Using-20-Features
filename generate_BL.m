function averaged_features_per_segments=generate_BL(EEG,fs)

% EEG single-channel selected from non-seizure group
% fs-sampling frequency


[Row,N]=size(EEG);
windows1=20*fs;
NO_20s=round(N/(windows1))-1; 


    for mm=1:1:NO_20s 
        
        recorddata_EEG_20s=EEG((mm-1)*windows1+1:(mm)*windows1); 


        recorddata_EEG_20s=do_bandpass_filtering(recorddata_EEG_20s,fs,0.5,30);%%%Jako vazno

        [SVD_S,BinEn_S,Skewness_s]=features_exctration_BL(recorddata_EEG_20s, 100);
    
        RES(mm,1:4)=SVD_S;
        RES(mm,5:8)=BinEn_S;
        RES(mm,9:12)=Skewness_s;
    end
    averaged_features_per_segments=mean(RES);
    xlswrite('BL_features.xlsx',averaged_features_per_segments);
end