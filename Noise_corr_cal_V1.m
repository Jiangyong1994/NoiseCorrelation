topnum=50;
for subj_idx=1:11

    load('roi_V1_response')

    data_lh_attL_de=saved_data_lh_attL{subj_idx};
    data_lh_attR_de=saved_data_lh_attR{subj_idx};
    data_rh_attL_de=saved_data_rh_attL{subj_idx};
    data_rh_attR_de=saved_data_rh_attR{subj_idx};
    cor_x_lh=cord_x_lh{subj_idx};
    cor_y_lh=cord_y_lh{subj_idx};
    slices_lh=cord_z_lh{subj_idx}; 
    cor_x_rh=cord_x_rh{subj_idx};
    cor_y_rh=cord_y_rh{subj_idx};
    slices_rh=cord_z_rh{subj_idx};
    lh_meanresp_attL = squeeze(mean(data_lh_attL_de,1))';
    lh_meanresp_attR = squeeze(mean(data_lh_attR_de,1))';
    lh_att_effect = (lh_meanresp_attR-lh_meanresp_attL);
    rh_meanresp_attL = squeeze(mean(data_rh_attL_de,1))';
    rh_meanresp_attR = squeeze(mean(data_rh_attR_de,1))';
    rh_att_effect = (rh_meanresp_attL-rh_meanresp_attR);
    [~,ind_lh] = sort(lh_att_effect,'descend');
    top_ind_lh = ind_lh(1:topnum);
    [~,ind_rh] = sort(rh_att_effect,'descend');
    top_ind_rh = ind_rh(1:topnum);
    
    
    % lh condition
    
    data_attL_lh_top = data_lh_attL_de(:,top_ind_lh);
    data_attR_lh_top = data_lh_attR_de(:,top_ind_lh);
    cor_x_top = cor_x_lh(top_ind_lh);
    cor_y_top = cor_y_lh(top_ind_lh);
    slices_top = slices_lh(top_ind_lh);
    
  
   
    
    noise_corr_attL= jy_caculate_noise_corr_withinroi(data_attL_lh_top,cor_x_top,cor_y_top,slices_top,3);
    noise_corr_attR= jy_caculate_noise_corr_withinroi(data_attR_lh_top,cor_x_top,cor_y_top,slices_top,3);
   
    
    
    output = [noise_corr_attL, noise_corr_attR ];
    output_list{1}(subj_idx,:)=output;
    % rh condition
    data_attL_rh_top = data_rh_attL_de(:,top_ind_rh);
    data_attR_rh_top = data_rh_attR_de(:,top_ind_rh);
    cor_x_top = cor_x_rh(top_ind_rh);
    cor_y_top = cor_y_rh(top_ind_rh);
    slices_top = slices_rh(top_ind_rh);
    
    
        
    noise_corr_attL= jy_caculate_noise_corr_withinroi(data_attL_rh_top,cor_x_top,cor_y_top,slices_top,3);
    noise_corr_attR= jy_caculate_noise_corr_withinroi(data_attR_rh_top,cor_x_top,cor_y_top,slices_top,3);
   
    output = [noise_corr_attL, noise_corr_attR ];
     
  output_list{2}(subj_idx,:)=output;
    
end

output_lh=output_list{1};output_rh=output_list{2};