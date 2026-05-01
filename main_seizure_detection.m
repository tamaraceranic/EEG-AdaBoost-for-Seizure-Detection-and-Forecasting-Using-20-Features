function [predicted_ouput]=main_seizure_detection(EEG,fs)
% EEG single-channel time series
% fs-sampling frequency
% replace Training_features_detection_annotation.xlsx on own database, last column is annotation.
% predicted_ouput-output based on AdaBoost per 20s EEG

TRAINING=xlsread('Training_features_detection_annotation.xlsx');%replace with features extracted from own dataset+annotation

label_training=TRAINING(:,end);
TRAINING=TRAINING(:,1:end-1);

predicted_ouput=[];


[Row,N]=size(EEG);
windows1=20*fs;
NO_20s=round(N/(windows1))-1; 


    for mm=1:1:NO_20s


        recorddata_EEG_20s=EEG((mm-1)*windows1+1:(mm)*windows1); 

      
        recorddata_EEG_20s=do_bandpass_filtering(recorddata_EEG_20s,fs,0.5,30);

        Features_list=features_exctration_single_channel_segments(recorddata_EEG_20s, fs);
       
     
        [predictied_label]=ai_model_main(TRAINING,label_training,Features_list);
     
        Features_list_all(mm,:)=[Features_list,double(predictied_label)];
        predicted_ouput=[predicted_ouput,predictied_label];

    end
    

end
