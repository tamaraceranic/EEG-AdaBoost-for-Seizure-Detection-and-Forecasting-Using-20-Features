function [SVD_S,BinEn_S,Skewness_s]=features_exctration_BL(recorddata_EEG_20s, fs)


    window=5*fs; % subsegments 5s

        no_window=4;


        for j=1:no_window

                    data_p_bl=recorddata_EEG_20s((j-1)*window+1:(j)*window);

                    [U,S1,V] = svd(data_p_bl);

                    BinEn_chan_bl = BinEn(data_p_bl(1,:),data_p_bl(1,:));

                    [f1,y1,bw] = ksdensity((data_p_bl(:)));

                    Max_pdf(j)=max(f1);

                    Skewn(j)=skewness(data_p_bl(:));
                    Kurtos(j)=kurtosis(data_p_bl(:));
                    STD_all(j)=std(data_p_bl(:));

                      Bin_En(j)=BinEn_chan_bl;


                     SVD_val(j)=S1(1);


        end


    SVD_S=SVD_val';
    BinEn_S=Bin_En';
%     fmax_S=Max_pdf';
    Skewness_s=Skewn';
   
end