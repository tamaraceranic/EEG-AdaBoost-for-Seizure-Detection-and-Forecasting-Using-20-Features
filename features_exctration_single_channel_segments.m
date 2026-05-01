function Features_list=features_exctration_single_channel_segments(recorddata_EEG_20s, fs)

    BL=xlsread('BL_features.xlsx');
    
        window=5*fs; % subsegments  duration 5s

        no_window=4;


        for j=1:no_window

                    data_p_bl=recorddata_EEG_20s((j-1)*window+1:(j)*window);

                    [U,S1,V] = svd(data_p_bl);

                    BinEn_chan_bl = BinEn(data_p_bl(1,:),data_p_bl(1,:));

                    [f1,y1,bw] = ksdensity((data_p_bl(:)));

                    Max_pdf(j)=max(f1);

                    Skewn(j)=skewness(data_p_bl(:));
%                     Kurtos(j)=kurtosis(data_p_bl(:));
                    STD_all(j)=std(data_p_bl(:));

                      Bin_En(j)=BinEn_chan_bl;


                     SVD_val(j)=S1(1);


        end




    SVD_S=SVD_val';
    BinEn_S=Bin_En';
    fmax_S=Max_pdf';
    Skewness_s=Skewn';
%     Kurtosis_s=Kurtos';
    STD_all_channel_5s=STD_all';

    SVD_BL=BL(1:1:4);
    BinEn_BL=BL(5:1:8);
    Skewness_BL=BL(9:1:12);


    %% SVD features
    [U,S1,V] = svd(recorddata_EEG_20s);
    feature_1=S1(1);
    feature_2=norm(SVD_S'-SVD_BL);
    feature_3=std(SVD_S');
    feature_4=abs(sum(SVD_S')-sum(SVD_BL));
    %% BinEn features
    feature_5=norm(BinEn_S'-BinEn_BL);
    feature_6=sum(BinEn_S);
    %% Power features

    [Power_delta,Power_teta,Power_alfa,Power_beta]=power_estimation_per_range(fs,recorddata_EEG_20s);

    feature_11=Power_delta;
    feature_12=Power_teta;
    feature_13=Power_alfa;
    feature_14=Power_beta;

    %% statisticals features
    feature_7=sum(Skewness_s);
    feature_8=std(Skewness_s);
    feature_9=norm(Skewness_s'-Skewness_BL);
    feature_10=sum(STD_all_channel_5s);
    feature_15=max(fmax_S);

    [feature_16,feature_17,feature_18,feature_19,feature_20]=statistics_features_per_segment(recorddata_EEG_20s);

     Features_list=[feature_1,feature_2,feature_3,feature_4,feature_5,feature_6,feature_7,feature_8,feature_9,feature_10,feature_11,feature_12,feature_13,feature_14,feature_15,feature_16,feature_17,feature_18,feature_19,feature_20];


end







