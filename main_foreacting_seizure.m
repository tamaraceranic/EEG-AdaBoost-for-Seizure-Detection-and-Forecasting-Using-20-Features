function [predicted_ouput]=main_foreacting_seizure(EEG,fs,wl)
% EEG single-channel time series
% fs-sampling frequency
% wl-sliding time window (1 min recommended)
% Replace Training_features_forecasting_annotation_10_predicted_interval.xlsx on own database, last column is annotation.
% Leave-One-Subject-Out (LOSO) validation was used to evaluate model performance in a subject-independent manner, where new subject is used for testing while the remaining subjects are used for training.

no_segments_20s=round((wl*60)/20);
TRAINING=xlsread('Training_features_forecasting_annotation_10_predicted_interval.xlsx');%Replace with features extracted from own dataset+forecasting annotation

label_training=TRAINING(:,end);
TRAINING=TRAINING(:,1:end-1);

predicted_ouput=[];

ann_output=[];

[Row,N]=size(EEG);
windows1=20*fs;
NO_20s=round(N/(windows1))-1; 


    for mm=1:1:NO_20s
        
        temp_seg=mm;
        Features_list_wl=[];
        
        for wt=1:1:no_segments_20s
            
            
            recorddata_EEG_20s=EEG((temp_seg-1)*windows1+1:(temp_seg)*windows1); 


            recorddata_EEG_20s=do_bandpass_filtering(recorddata_EEG_20s,fs,0.5,30);

            Features_list=features_exctration_single_channel_segments(recorddata_EEG_20s, fs);
            Features_list_wl=[Features_list_wl,Features_list];
             temp_seg=mm+1;
        end
        
        [predictied_label]=ai_model_main(TRAINING,label_training,Features_list_wl);
     
        Features_list_all(mm,:)=[Features_list_wl,double(predictied_label)];
        predicted_ouput=[predicted_ouput,predictied_label];

    end

    
end

   
