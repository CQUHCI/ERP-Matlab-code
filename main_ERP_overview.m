clear all; clc; close all

%������������������
Cond = {'S  1','S  2','S  3','S  4'}; %% condition name

for i = 1 : 26
    % filename of set file
    setname = strcat(num2str(i+1),'_final.set'); 
    %�����������ڵ�·���������Լ�������·���޸�      ·���޸�
    setpath = 'E:\erp_shunji_final\example_data';
  
    %ʹ��eeglab�Դ���pop_loadset������������EEG( EEG.data 16*750*�ֶΣ�
    EEG = pop_loadset('filename',setname,'filepath',setpath); %% load the data
    EEG = eeg_checkset( EEG );
    
   for j = 1:length(Cond)
        %���÷ֶκ�����ѡ����ǰ����������
        EEG_new = pop_epoch( EEG, Cond(j), [-0.5  1], 'newname', 'datasets pruned with ICA', 'epochinfo', 'yes'); %% epoch by conditions, input to EEG_new���ֶ�
        EEG_new = eeg_checkset( EEG_new );
        EEG_new = pop_rmbase( EEG_new, [-500     0]); %% baseline correction for EEG_new������
        EEG_new = eeg_checkset( EEG_new );
        %�Ե�i�����Եĵ�j������������������ƽ����Ȼ�����
        %�������ݣ����ܺ�EEG_avg�� ����*����*ͨ��*ʱ���  26*4*16*750
        EEG_avg(i,j,:,:) = squeeze(mean(EEG_new.data,3));  
   end
end



%% ��ͨ��4��������ͼ
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
H_pa = patch([275,275,325,325],[-8, 8,8,-8],[.8 .8 .8]);% patch([Xleft, Xleft, Xright, Xright], [Ydown, Yup, Yup, Ydown],[��Ӱ��ɫ]);
set(H_pa,'EdgeColor',[.8 .8 .8],'EdgeAlpha',0.5,'FaceAlpha',0.5)%set(H_pa,'EdgeColor',[�߿���ɫ],'EdgeAlpha',�߿�͸����,'FaceAlpha',��Ӱ͸����
%%
%����F3,FZ,F4,C3,Cz��C4ͨ������ͼ
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
    
    
    
 


%% �����������ȡÿ�������£�ÿ�����Ե���/���ͨ���µ�������λֵ
N300_peak = 300; %% define the peaks
N300_interval=find((times>=280)&(times<=320)); %% N300 interval

%EEG_avg�� ����*����*ͨ��*ʱ���  10*4*16*750
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

N300_peak = 300; %% define the peaks������N300_peak=295,���Ϊ270-320
N300_interval=find((times>=290)&(times<=310)); 

%��ȡ���б��ԡ���������������ͨ��N2/P2��ƽ������
%N300_amplitude: ����*����*ͨ��   26*4*16
N300_amplitude=squeeze(mean(EEG_avg(:,:,:,N300_interval),4)); %% N2 amplitude for each subject, condition, and channels����N300�źŲ�����ƽ��


%������ˮƽ��������ĵ���ͼ
figure; %% divide the panel into 4 rows and 2 colums
%����ÿһ������
for i = 1:4
    %��ȡ��i��������ƽ��������ͨ����N2����ֵ
    N300_data = mean(N300_amplitude(:,i,:),1); %% average across subjects
    subplot(2,4,i); 
    %������ͼ��N300�ĵ���ͼȫ���������
    topoplot(N300_data,EEG.chanlocs); title('N300 Amplitude','fontsize',16); %% plot N2 scalp map (group-level)
  
end

