clear all; clc; close all

%声明四种条件的名称
Cond = {'S  1','S  2','S  3','S  4'}; %% condition name

for i = 1 : 26
    % filename of set file
    setname = strcat(num2str(i+1),'_final.set'); 
    %声明数据所在的路径，依据自己的数据路径修改      路径修改
    setpath = 'E:\erp_shunji_final\example_data';
  
    %使用eeglab自带的pop_loadset函数导入数据EEG( EEG.data 16*750*分段）
    EEG = pop_loadset('filename',setname,'filepath',setpath); %% load the data
    EEG = eeg_checkset( EEG );
    
   for j = 1:length(Cond)
        %利用分段函数挑选出当前条件的数据
        EEG_new = pop_epoch( EEG, Cond(j), [-0.5  1], 'newname', 'datasets pruned with ICA', 'epochinfo', 'yes'); %% epoch by conditions, input to EEG_new，分段
        EEG_new = eeg_checkset( EEG_new );
        EEG_new = pop_rmbase( EEG_new, [-500     0]); %% baseline correction for EEG_new，基线
        EEG_new = eeg_checkset( EEG_new );
        %对第i个被试的第j个条件的数据做叠加平均，然后汇总
        %本例数据，汇总后EEG_avg： 被试*条件*通道*时间点  26*4*16*750
        EEG_avg(i,j,:,:) = squeeze(mean(EEG_new.data,3));  
   end
end



%% 各通道4条件波形图
EEG_over = squeeze(mean(EEG_avg(:,:,:,:),1));

for i = 3:8
 
mean_data = squeeze(EEG_over(:,i,:));
times = [-500:2:998];

figure; 
plot(times, mean_data,'linewidth', 0.5); %% plot waveforms for different conditions
%set(gca,'YDir','reverse');  %% reverse Y axis
axis([-200 800 -8 8]);  %% define the region to display
title('Group level data','fontsize',16); 
xlabel('Latency (ms)','fontsize',16);
ylabel('Amplitude (uV)','fontsize',16); 
H_pa = patch([275,275,325,325],[-8, 8,8,-8],[.8 .8 .8]);% patch([Xleft, Xleft, Xright, Xright], [Ydown, Yup, Yup, Ydown],[阴影颜色]);
set(H_pa,'EdgeColor',[.8 .8 .8],'EdgeAlpha',0.5,'FaceAlpha',0.5)%set(H_pa,'EdgeColor',[边框颜色],'EdgeAlpha',边框透明度,'FaceAlpha',阴影透明度
%%
%绘制F3,FZ,F4,C3,Cz，C4通道波形图
EEG_over = squeeze(mean(EEG_avg(:,:,:,:),1));
figure;
for i = 3:8
    mean_data = squeeze(EEG_over(:,i,:));
    times = [-500:2:998];
    subplot(2,3,i-2),plot(times, mean_data,'linewidth', 0.5);
    axis([-200 800 -6 8]),title('Group level data','fontsize',8);
    ylabel('Amplitude (uV)','fontsize',8);
    H_pa = patch([275,275,325,325],[-6, 8,8,-6],[.8 .8 .8]);
    set(H_pa,'EdgeColor',[.8 .8 .8],'EdgeAlpha',0.5,'FaceAlpha',0.5)
end
%axis([-200 800 -8 8]),title('Group level data','fontsize',16);
%xlabel('Latency (ms)','fontsize',16),ylabel('Amplitude (uV)','fontsize',16);
%H_pa = patch([275,275,325,325],[-8, 8,8,-8],[.8 .8 .8]);
%set(H_pa,'EdgeColor',[.8 .8 .8],'EdgeAlpha',0.5,'FaceAlpha',0.5)
    
    
    
 


%% 方差分析，提取每个条件下，每个被试单独/多个通道下的特征电位值
N300_peak = 300; %% define the peaks
N300_interval=find((times>=280)&(times<=320)); %% N300 interval

%EEG_avg： 被试*条件*通道*时间点  10*4*16*750
EEG_s1_n300 = squeeze(EEG_avg(:,1,:,N300_interval));
EEG_s2_n300 = squeeze(EEG_avg(:,2,:,N300_interval));
EEG_s3_n300 = squeeze(EEG_avg(:,3,:,N300_interval));
EEG_s4_n300 = squeeze(EEG_avg(:,4,:,N300_interval));


S1_n300 = squeeze(mean(EEG_s1_n300(:,:,:),3));
S2_n300 = squeeze(mean(EEG_s2_n300(:,:,:),3));
S3_n300 = squeeze(mean(EEG_s3_n300(:,:,:),3));
S4_n300 = squeeze(mean(EEG_s4_n300(:,:,:),3));

F3 = 3;
Fz = 4;
F4 = 5;
C3 = 6;
Cz = 7;
C4 = 8;

F3_s1_n300 = S1_n300(:,F3);
Fz_s1_n300 = S1_n300(:,Fz);
F4_s1_n300 = S1_n300(:,F4);
C3_s1_n300 = S1_n300(:,C3);
Cz_s1_n300 = S1_n300(:,Cz);
C4_s1_n300 = S1_n300(:,C4);

F3_s2_n300 = S2_n300(:,F3);
Fz_s2_n300 = S2_n300(:,Fz);
F4_s2_n300 = S2_n300(:,F4);
C3_s2_n300 = S2_n300(:,C3);
Cz_s2_n300 = S2_n300(:,Cz);
C4_s2_n300 = S2_n300(:,C4);

F3_s3_n300 = S3_n300(:,F3);
Fz_s3_n300 = S3_n300(:,Fz);
F4_s3_n300 = S3_n300(:,F4);
C3_s3_n300 = S3_n300(:,C3);
Cz_s3_n300 = S3_n300(:,Cz);
C4_s3_n300 = S3_n300(:,C4);

F3_s4_n300 = S4_n300(:,F3);
Fz_s4_n300 = S4_n300(:,Fz);
F4_s4_n300 = S4_n300(:,F4);
C3_s4_n300 = S4_n300(:,C3);
Cz_s4_n300 = S4_n300(:,Cz);
C4_s4_n300 = S4_n300(:,C4);

xlswrite('F3_s1_n300.csv',F3_s1_n300);
xlswrite('Fz_s1_n300.csv',Fz_s1_n300);
xlswrite('F4_s1_n300.csv',F4_s1_n300);
xlswrite('C3_s1_n300.csv',C3_s1_n300);
xlswrite('Cz_s1_n300.csv',Cz_s1_n300);
xlswrite('C4_s1_n300.csv',C4_s1_n300);

xlswrite('F3_s2_n300.csv',F3_s2_n300);
xlswrite('Fz_s2_n300.csv',Fz_s2_n300);
xlswrite('F4_s2_n300.csv',F4_s2_n300);
xlswrite('C3_s2_n300.csv',C3_s2_n300);
xlswrite('Cz_s2_n300.csv',Cz_s2_n300);
xlswrite('C4_s2_n300.csv',C4_s2_n300);

xlswrite('F3_s3_n300.csv',F3_s3_n300);
xlswrite('Fz_s3_n300.csv',Fz_s3_n300);
xlswrite('F4_s3_n300.csv',F4_s3_n300);
xlswrite('C3_s3_n300.csv',C3_s3_n300);
xlswrite('Cz_s3_n300.csv',Cz_s3_n300);
xlswrite('C4_s3_n300.csv',C4_s3_n300);

xlswrite('F3_s4_n300.csv',F3_s4_n300);
xlswrite('Fz_s4_n300.csv',Fz_s4_n300);
xlswrite('F4_s4_n300.csv',F4_s4_n300);
xlswrite('C3_s4_n300.csv',C3_s4_n300);
xlswrite('Cz_s4_n300.csv',Cz_s4_n300);
xlswrite('C4_s4_n300.csv',C4_s4_n300);

%% scalp maps of dominant peak for different conditions

N300_peak = 300; %% define the peaks，或者N300_peak=295,间隔为270-320
N300_interval=find((times>=290)&(times<=310)); 

%提取所有被试、所有条件、所有通道N2/P2的平均波幅
%N300_amplitude: 被试*条件*通道   26*4*16
N300_amplitude=squeeze(mean(EEG_avg(:,:,:,N300_interval),4)); %% N2 amplitude for each subject, condition, and channels，对N300信号波幅求平均


%绘制组水平多个条件的地形图
figure; %% divide the panel into 4 rows and 2 colums
%对于每一个条件
for i = 1:4
    %提取第i个条件组平均的所有通道的N2波幅值
    N300_data = mean(N300_amplitude(:,i,:),1); %% average across subjects
    subplot(2,4,i); 
    %画地形图，N300的地形图全部画在左侧
    topoplot(N300_data,EEG.chanlocs); title('N300 Amplitude','fontsize',16); %% plot N2 scalp map (group-level)
  
end

