function [pdf_max,bw_pdf,xi_min,xi_max,xi_delta]=statistics_features_per_segment(recorddata)

     [f,xi,bw] = ksdensity(recorddata);
     
%      f_array=[f_array,max(f)];
     pdf_max=max(f);
     bw_pdf=bw;
     xi_min=min(xi);
     xi_max=max(xi);
     xi_delta=max(xi)-min(xi);


end






