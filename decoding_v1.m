
l_r={'lh.v1_exvivo','rh.v1_exvivo'};
subj={'s1','s2','s3','s4','s5','s6','s7','s8','s9','s10','s11'};
temp='/home/jiangyong/data/LianTianRFS/jiangyong/noise_correlation/';
input_data={};
rootdir=pwd;

topnum=200;
lh_attL_output=zeros(length(subj),1);
lh_attR_output=zeros(length(subj),1);
rh_attL_output=zeros(length(subj),1);
rh_attR_output=zeros(length(subj),1);

load('decoding_v1')
%%
%for subj_idx=11
for   subj_idx=1:length(subj)
    for l_ridx=1:length(l_r)
        

        input_data{l_ridx}{1}=data_attL{subj_idx}{l_ridx};
        input_data{l_ridx}{2}=data_attR{subj_idx}{l_ridx};
    end

    label_matrix=label_matrix_list{subj_idx};
    att_L_idx=find(label_matrix(:,1)==1);
    att_R_idx=find(label_matrix(:,1)==-1);
    vision_left_attL=label_matrix(att_L_idx,2);
    vision_right_attL=label_matrix(att_L_idx,3);
    vision_left_attR=label_matrix(att_R_idx,2);
    vision_right_attR=label_matrix(att_R_idx,3);
    clear  m* o*
    
    
    
    eachruntiral=26;
    runnum=8;
    
    run_average_attL_left_pos=zeros(runnum,topnum);
    run_average_attL_left_neg=zeros(runnum,topnum);
    run_average_attR_left_pos=zeros(runnum,topnum);
    run_average_attR_left_neg=zeros(runnum,topnum);
    run_average_attL_right_pos=zeros(runnum,topnum);
    run_average_attL_right_neg=zeros(runnum,topnum);
    run_average_attR_right_pos=zeros(runnum,topnum);
    run_average_attR_right_neg=zeros(runnum,topnum);
    
    runs_attL_left_pos={};
    runs_attL_left_neg={};
    runs_attR_left_pos={};
    runs_attR_left_neg={};
    
    runs_attL_right_pos={};
    runs_attL_right_neg={};
    runs_attR_right_pos={};
    runs_attR_right_neg={};
    count1=1;
    count2=1;
    
    att_L_idx=find(label_matrix(:,1)==1) ;
    att_R_idx=find(label_matrix(:,1)==-1) ;
    for run=1:runnum
        
        att_L_idx=find(label_matrix((run-1)*26+1:(run)*26,1)==1);
        att_R_idx=find(label_matrix((run-1)*26+1:(run)*26,1)==-1);
        att_L_num=length(att_L_idx);
        att_R_num=length(att_R_idx);
        vision_left_attL=label_matrix(att_L_idx,2);
        vision_right_attL=label_matrix(att_L_idx,3);
        vision_left_attR=label_matrix(att_R_idx,2);
        vision_right_attR=label_matrix(att_R_idx,3);
        
        attL_data=input_data{2}{1}(count1:count1+att_L_num-1,:);
        attR_data=input_data{2}{2}(count2:count2+att_R_num-1,:);
        
        
        
        
        
        runs_attL_left_pos{run}=attL_data(find(vision_left_attL==1),:);
        runs_attL_left_neg{run}=attL_data(find(vision_left_attL==-1),:);
        runs_attR_left_pos{run}=attR_data(find(vision_left_attR==1),:);
        runs_attR_left_neg{run}=attR_data(find(vision_left_attR==-1),:);
        
        run_average_attL_left_pos(run,:)=mean(runs_attL_left_pos{run});
        run_average_attL_left_neg(run,:)=mean(runs_attL_left_neg{run});
        run_average_attR_left_pos(run,:)=mean(runs_attR_left_pos{run});
        run_average_attR_left_neg(run,:)=mean(runs_attR_left_neg{run});
        
        attL_data=input_data{1}{1}(count1:count1+att_L_num-1,:);
        attR_data=input_data{1}{2}(count2:count2+att_R_num-1,:);
        
        
        runs_attL_right_pos{run}=attL_data(find(vision_right_attL==1),:);
        runs_attL_right_neg{run}=attL_data(find(vision_right_attL==-1),:);
        runs_attR_right_pos{run}=attR_data(find(vision_right_attR==1),:);
        runs_attR_right_neg{run}=attR_data(find(vision_right_attR==-1),:);
        
        run_average_attL_right_pos(run,:)=mean(runs_attL_right_pos{run});
        run_average_attL_right_neg(run,:)=mean(runs_attL_right_neg{run});
        run_average_attR_right_pos(run,:)=mean(runs_attR_right_pos{run});
        run_average_attR_right_neg(run,:)=mean(runs_attR_right_neg{run});
        
        
        count1=count1+att_L_num;
        count2=count2+att_R_num;
    end
    
    
    
    
    
    outputM_attL_left=zeros(runnum,1);
    outputM_attL_right=zeros(runnum,1);
    outputM_attR_left=zeros(runnum,1);
    outputM_attR_right=zeros(runnum,1);
    
    run_idx=1:8;
    %%
    for run=1:8
        
        
        data_train_attL_left=[run_average_attL_left_pos(run_idx~=run,:);run_average_attL_left_neg(run_idx~=run,:)];
        data_train_attL_right=[run_average_attL_right_pos(run_idx~=run,:);run_average_attL_right_neg(run_idx~=run,:)];
        
        data_train_attR_left=[run_average_attR_left_pos(run_idx~=run,:);run_average_attR_left_neg(run_idx~=run,:)];
        data_train_attR_right=[run_average_attR_right_pos(run_idx~=run,:);run_average_attR_right_neg(run_idx~=run,:)];
        
        label_train=[1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1];
        
        
        
        data_test_attL_left=[run_average_attL_left_pos(run_idx==run,:);run_average_attL_left_neg(run_idx==run,:)];
        data_test_attL_right=[run_average_attL_right_pos(run_idx==run,:);run_average_attL_right_neg(run_idx==run,:)];
        data_test_attR_left=[run_average_attR_left_pos(run_idx==run,:);run_average_attR_left_neg(run_idx==run,:)];
        data_test_attR_right=[run_average_attR_right_pos(run_idx==run,:);run_average_attR_right_neg(run_idx==run,:)];
        label_test=[1,-1];
        
        options='-t 0 -q';
        
        model1=svmtrain(label_train',data_train_attL_left,options);
        
        model2=svmtrain(label_train',data_train_attL_right,options);
        
        model3=svmtrain(label_train',data_train_attR_left,options);
        
        model4=svmtrain(label_train',data_train_attR_right,options);
        

        label_predict1=svmpredict(label_test', data_test_attL_left, model1,'-q');
        label_predict2=svmpredict(label_test', data_test_attL_right, model2,'-q');
        label_predict3=svmpredict(label_test', data_test_attR_left, model3,'-q');
        label_predict4=svmpredict(label_test', data_test_attR_right, model4,'-q');
        


        
        outputM_attL_left(run)= mean(label_test==label_predict1');
        outputM_attL_right(run)= mean(label_test==label_predict2');
        outputM_attR_left(run)= mean(label_test==label_predict3');
        outputM_attR_right(run)= mean(label_test==label_predict4');
        
    end
    %%
    for att=1:2 % att=1 attL trial att=2 attR trial;
        for which_side=1:2% =1 left side label =2 right side label
            which_head=3-which_side;%1 lh 2 rh
            if att==1
                
                if which_head==1
                    lh_attL_output(subj_idx)=mean(outputM_attL_right);
                elseif which_head==2
                    rh_attL_output(subj_idx)=mean(outputM_attL_left);
                end
            elseif att==2
                
                if which_head==1
                    lh_attR_output(subj_idx)=mean(outputM_attR_right);
                elseif which_head==2
                    rh_attR_output(subj_idx)=mean(outputM_attR_left);
                end
                
            end
            
        end
    end
end
att_output=(lh_attR_output+rh_attL_output)/2;
uatt_output=(lh_attL_output+rh_attR_output)/2;

disp([mean(att_output),mean(uatt_output)])
