clear all
%%
control_path='/Users/liut7/Library/CloudStorage/Box-Box/VWFAPlasticityPaper/forMarlene_OneDrive/Spatial organization of the visual cortex/Peak_Tina/Controls'
control_order={'C12','626','307','853','828','631','731','C20','C18','C11','256','C16',... %12
   'C07','C19', '712','228','701','957','917','C14','719','809','440','153','039'}  % 12+13=25 '523'  
control_names={'C1','C2','C3','C4','C5','C6','C7','C8','C9','C10','C11','C12','C13','C14','C15','C16','C17','C18','C19','C20','C21','C22','C23','C24','C25'}

% go to this folder
cd '/Users/liut7/Library/CloudStorage/Box-Box/VWFAPlasticityPaper/forMarlene_OneDrive/Spatial organization of the visual cortex/Peak_Tina/Controls'

for i = 1:length(control_order) %25
    A = importdata([control_order{i} '.txt' ],' ',1);
    temp=real(A.data);
    controls(:,:,i)=temp;
end

patients_path='/Users/liut7/Library/CloudStorage/Box-Box/VWFAPlasticityPaper/forMarlene_OneDrive/Spatial organization of the visual cortex/Peak_Tina/Patients'
patient_order={'KN_ROI','SN_ROI','TC2016_ROI','TC2017_ROI','TC2019_ROI','UD1_ROI','UD2_ROI','UD3_ROI','UD4_ROI','UD5_ROI','OT2014_ROI','OT2017_ROI','OT2018_ROI'}
cd '/Users/liut7/Library/CloudStorage/Box-Box/VWFAPlasticityPaper/forMarlene_OneDrive/Spatial organization of the visual cortex/Peak_Tina/Patients'

% To use the 'importdata' function, ensure that each patient's data has the same dimensions (17 ROIs/rows × 5 columns). 
% x y z coordinate = 1 for ROIs that are resected, not covered, or not found in the patients. See Figure S2 for details. 

for i = 1:length(patient_order)
    B = importdata([patient_order{i} '.txt' ],' ',1);
    temp=real(B.data);
    patients(:,:,i)=temp;
end


% Remove any artificially inserted rows (with x y z coordinates = 1) that were added to standardize the dimensions.
patients([1,3:5,7,9,11,16],:,1)=NaN; %KN

% SN has all 17 ROIs

patients([1,3,5,7,9,11,14:16],:,3)=NaN; %TC2016
patients([1,3,5,7,9,11,14,16],:,4)=NaN; %TC2017
patients([1,3,5,7,9,11,16],:,5)=NaN; %TC2019

patients([1:4,6,8,10,12,15,17],:,6)=NaN; %UD_CL1: no bilateral FFA, bilateral STS, rPPA, rTOS, rPF, Broca, rEVC
patients([2,4,6,8,10,12,15,17],:,7)=NaN; %UD_CL2: no rFFA, rSTS, rPPA, rTOS, rPF, Broca, rEVC
patients([2,4,6,8,10,12,15,17],:,8)=NaN; %UD_CL3: no rFFA, rSTS, rPPA, rTOS, rPF, Broca, rEVC
patients([2,4,6,8,10,12,17],:,9)=NaN; %UD_CL4: no rFFA, rSTS, rPPA, rTOS, rPF, rEVC
patients([2,4,6,8,10,12,17],:,10)=NaN; %UD_CL5: no rFFA, rSTS, rPPA, rTOS, rPF, rEVC

patients([15],:,11:13)=NaN; %OT_CL1-CL3

 %% crawford test
% include only ventral ROIs for medial-lateral analysis: ffa (1-2) PPA (5-6) pF (11-12) vwfa (13) and EVC (16-17)
controls([3,4,7,8,9,10,14,15],:,:)=NaN;
patients([3,4,7,8,9,10,14,15],:,:)=NaN; 

%% just x (medial-lateral)
for i = 1:length(control_order)  
    select = ~isnan(controls(:,1,i)) ;  % if nan exists in controls
    temp_control = controls(select(:,1),1,i) ; % 25 controls  
    temp_controlGroup = controls(select(:,1),1,:) ; 
    Spatial_cor(i,1) = corr(temp_control,nanmean(temp_controlGroup(:,1,i~=1:length(control_order)),3));    
    % Spatial_cor(i,1) for each control vs. mean control meanR
end
for p = 1:length(patient_order)  
    select = ~isnan(patients(:,1,p)) ;  
    temp_control = controls(select(:,1),1,:) ;  
    temp_patient = patients(select(:,1),1,p) ;  
    Spatial_cor(p,2) = corr(temp_patient,nanmean(temp_control,3));
    % Spatial_cor(i,2)for patient vs mean control mean R
    for t=1:length(control_order)
        control_crawford(t,p) = corr(temp_control(:,1,t),nanmean(temp_control(:,1,t~=1:length(control_order)),3));
    end
end
 
%% crawford
%% for each patients - the correlation of the controls to themselves will be based only on the rois avilable for this patient.
Spatial_cor_fisher=(0.5*log((1+Spatial_cor)./(1-Spatial_cor)));%fisher
control_crawford_fisher=(0.5*log((1+control_crawford)./(1-control_crawford)));%fisher
for s=1:length(control_order)
    %t_crawford(s,2)=(Spatial_cor_fisher(s,2)-nanmean(control_crawford_fisher(:,s)))./ (nanstd(control_crawford_fisher(:,s)*sqrt((length(control_order)+1)/length(control_order))))
    t_crawford(s,1)=(Spatial_cor_fisher(s,1)-nanmean(Spatial_cor_fisher(s~=1:length(control_order),1)))./ (nanstd(Spatial_cor_fisher(:,1)*sqrt((length(control_order)+1)/(length(control_order)-1))));
end
for s=1:length(patient_order)
    t_crawford(s,2)=(Spatial_cor_fisher(s,2)-nanmean(control_crawford_fisher(:,s)))./ (nanstd(control_crawford_fisher(:,s)*sqrt((length(control_order)+1)/length(control_order))));
end

% each control vs. the rest of 24 controls, df = 23
p_crawford(:,1)=(1-tcdf(abs(t_crawford(:,1)),23));
[h,h1,h2,p_crawford_fdr(:,1)]=fdr_bh(p_crawford(:,1),.05,'pdep','yes');

% each patient vs. 25 controls, df = 24
p_crawford(:,2)=(1-tcdf(abs(t_crawford(:,2)),24));
[h,h1,h2,p_crawford_fdr(:,2)]=fdr_bh(p_crawford(:,2),.05,'pdep','yes');

%% control figure

control_order={'C12','626','307','853','828','631','731','C20','C18','C11','256','C16',... %12
   'C07','C19', '712','228','701','957','917','C14','719','809','440','153','039'}  % 12+13=25
control_names={'C1','C2','C3','C4','C5','C6','C7','C8','C9','C10','C11','C12','C13','C14','C15','C16','C17','C18','C19','C20','C21','C22','C23','C24','C25'}

marker_size = 300
FigHandle = figure('Position', [100, 100, 1800, 350]);
critical_value=2.069;
for s=1:length(control_order)
    if and(t_crawford(s,1)>-critical_value,t_crawford(s,1)<critical_value)
        scatter(s,t_crawford(s,1),marker_size,'black','filled')
        hold on 
    else
        scatter(s,t_crawford(s,1),marker_size,'red','filled')
        hold on
    end
end
xlim([0 26]);
ylim([-7 7])
xticks(1:25);
xticklabels(control_names);
set(gca, 'FontSize', 24);
set(gca, 'tickdir', 'out');
box off
%set(gca,'xtick',[])
xticks(1:25);
xticklabels(control_names);
yticks([-7 0 7])
ylabel('t score');
line([0,26],[critical_value,critical_value],'color',[0 0 0],'LineWidth',2)
line([0,26],[-critical_value,-critical_value],'color',[0 0 0],'LineWidth',2)
line([0,26],[0,0],'color',[0.5 0.5 0.5],'LineWidth',1)
% title('controls','FontSize',28)
%  savefig('crawford_control_ventral.fig')
 saveas(gcf,'crawford_control_ventral','epsc')

%% patient
patient_order={'KN_ROI','SN_ROI','TC2016_ROI','TC2017_ROI','TC2019_ROI','UD1_ROI','UD2_ROI','UD3_ROI','UD4_ROI','UD5_ROI','OT2014_ROI','OT2017_ROI','OT2018_ROI'}
pat_names={'KN','SN','TC1','TC2','TC3','UD1','UD2','UD3','UD4','UD5','OT1','OT2','OT3'}

FigHandle = figure('Position', [100, 100, 1000, 350]);
critical_value=2.064; 

for p=1:length(patient_order)
    if and(t_crawford(p,2)>-critical_value,t_crawford(p,2)<critical_value)
        scatter(p,t_crawford(p,2),marker_size,'black','filled')
        hold on
    else
        scatter(p,t_crawford(p,2),marker_size,'red','filled')
        hold on
    end
end
xlim([0 14])
ylim([-7 7])
xticks(1:13)
xticklabels(pat_names)
yticks([-7 0 7])

set(gca, 'FontSize', 25);
set(gca, 'tickdir', 'out');
box off
ylabel('t score')
line([0,14],[critical_value,critical_value],'color',[0 0 0],'LineWidth',2)
line([0,14],[-critical_value,-critical_value],'color',[0 0 0],'LineWidth',2)
line([0,14],[0,0],'color',[0.5 0.5 0.5],'LineWidth',1)
title('patients','FontSize',28)
savefig('crawford_patient.fig')
saveas(gcf,'crawford_patient','epsc')


%% raw coordinates in each of the 25 controls
rois_title={'lFFA','rFFA','lSTS','rSTS','lPPA','rPPA','lTOS','rTOS','lLOC','rLOC','lPF','rPF','VWFA','STG','IFG','lEVC','rEVC'};

c={'m','m',[1 .5 1],[1 .5 1],[0 .8 0],[0 .8 0],'g','g','c','c',[0 0.7 1],[0 0.7 1],[1 140/255 0],[1 0.8 0.2],[1 1 0],[0.8,0.8,0.8],[0.8,0.8,0.8]}
control_order={'C12','626','307','853','828','631','731','C20','C18','C11','256','C16',...
   'C07','C19', '712','228','701','957','917','C14','719','809','440','153','039'}

marker_size=120;
FigHandle = figure('Position', [100, 100, 1200, 800]);
for i=1:25
    subplot(5,5,i)
    for r=1:1
        scatter(controls(r,1,i),controls(r,2,i),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.1);
        xlim([-24 100]);
        xticks([-24, 38, 100]);
        xticklabels([0, 88, 176]);
        ylim([-120 40]);
        yticks([-100, -40, 20]);
        yticklabels([10, 70, 130]);
        set(gca, 'FontSize', 16);
        hold on
        set(gca, 'tickdir', 'out');
        % box off
        ax = gca;
        ax.XAxis.TickLength = [0 0];
        ax.YAxis.TickLength = [0 0];
        set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
        xlabel(' RH  <------>  LH','FontSize', 16);
        ylabel('P  <--->  A','FontSize', 16);
        title(['C' num2str(i)], 'FontSize',20)

    end
end

% savefig('controlEach_ventral.fig')
% saveas(gcf,'controlEach_ventral','epsc')


%% meanControls
rois_title={'lFFA','rFFA','lSTS','rSTS','lPPA','rPPA','lTOS','rTOS','lLOC','rLOC','lPF','rPF','VWFA','STG','IFG','lEVC','rEVC'};
c={'m','m',[1 .5 1],[1 .5 1],[0 .8 0],[0 .8 0],'g','g','c','c',[0 0.7 1],[0 0.7 1],[1 140/255 0],[1 0.8 0.2],[1 1 0],[0.8,0.8,0.8],[0.8,0.8,0.8]}
 
FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(meanX(1,r,1),meanY(1,r,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end

%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title('Controls (n=25)','FontSize',34)
box off
savefig('controlAverage.fig')
saveas(gcf,'controlAverage','epsc')

%% plot color bar v1
FigHandle = figure('Position', [100, 100, 200, 800]); marker_size=400;
c_bar={'r','m',[0 .8 0],'g','c',[0 0.7 1],[1 0.6 0],[1 0.8 0.2],[1 1 0],[0.8,0.8,0.8]}
rois_label={'FFA','STS','PPA','TOS','LOC','PF','VWFA','STG','IFG','EVC'};

for r=1:10
   scatter(c_bar_location(r,1),c_bar_locaion(r,2),marker_size,c_bar{r},'filled','MarkerEdgeColor','black','LineWidth',1)
   text(c_bar_location(r,1)+0.2,c_bar_location(r,2),rois_label(r),'FontSize',22,'Color','k')    

    hold on
end 
axis off

%% plot color bar v2
FigHandle = figure('Position', [100, 100, 800, 200]); marker_size=400;
rois_label={'FFA','STS','PPA','TOS','LOC','PF','VWFA','STG','IFG','EVC'};

for r=1:17
   scatter(c_bar_location(1,r),c_bar_location(2,r),marker_size,c_bar{r},'filled','MarkerEdgeColor','black','LineWidth',1)
   text(c_bar_location(1,r)+0.1,c_bar_location(2,r),rois_label(r),'FontSize',20,'Color','k')    
    hold on
end 
axis off

%% Patient ROI figures

% PPA darker green, TOS lighter green
% LOC cyan, PF blue
% VWFA-Wer-broca dark to light: orange to yellow
c={'m','m',[1 .5 1],[1 .5 1],[0 .8 0],[0 .8 0],'g','g','c','c',[0 0.7 1],[0 0.7 1],[1 140/255 0],[1 0.8 0.2],[1 1 0],[0.8,0.8,0.8],[0.8,0.8,0.8]}
rois_title={'lFFA','rFFA','lSTS','rSTS','lPPA','rPPA','lTOS','rTOS','lLOC','rLOC','lPF','rPF','VWFA','STG','IFG','lEVC','rEVC'};

% KN
test=readtable('KN_ROI.txt');
testArray=table2array(test(:,[2:4]))
testArray([1,3:5,7,9,11,16],:)=NaN; %TC2017

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'KN (age: 11y)'}, 'FontSize',34)
savefig('spatialROI_KN_11y.fig')
saveas(gcf,'spatialROI_KN_11y','epsc')

%% SN
% PPA darker green, TOS lighter green
% LOC cyan, PF blue
% VWFA-WEr-broca dark to light: orange to yellow

  test=readtable('SN_ROI.txt');
testArray=table2array(test(:,[2:4])) % X Y Z

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'SN (age: 12y6m)'}, 'FontSize',34)
savefig('spatialROI_SN_12y6m.fig')
 saveas(gcf,'spatialROI_SN_12y6m','epsc')

%% TC different number of ROIs across sessions
% patients([1,3,5,7,9,11,14:16],:,3)=NaN; %TC2016
% patients([1,3,5,7,9,11,14,16],:,2)=NaN; %TC2017
% patients([1,3,5,7,9,11,16],:,3)=NaN; %TC2019
clear fig
test=readtable('TC2016_ROI.txt');
testArray=table2array(test(:,[2:4]))
testArray([1,3,5,7,9,11,14:16],:)=NaN; %TC2016
 

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'TC (age: 13y3m)'}, 'FontSize',34)
savefig('spatialROI_TC_13y3m.fig')
saveas(gcf,'spatialROI_TC_13y3m','epsc')

% TC2017
clear fig
test=readtable('TC2017_ROI.txt');
testArray=table2array(test(:,[2:4]))
testArray([1,3,5,7,9,11,14,16],:)=NaN; %TC2017

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'TC (age: 13y11m)'}, 'FontSize',34)
savefig('spatialROI_TC_13y11m.fig')
saveas(gcf,'spatialROI_TC_13y11m','epsc')

% TC 2019 (7 ROIs defined)
clear fig
test=readtable('TC2019_ROI.txt');
testArray=table2array(test(:,[2:4]))
testArray([1,3,5,7,9,11,16],:)=NaN; %TC2019

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'TC (age: 15y9m)'}, 'FontSize',34)
savefig('spatialROI_TC_15y9m.fig')
saveas(gcf,'spatialROI_TC_15y9m','epsc')

%% OT (2014-2018) same ROIs across sessions
% OT 2014
 test=readtable('OT2014_ROI.txt');
testArray=table2array(test(:,[2:4]))
testArray([15],:)=NaN; 

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'OT (age: 14y8m)'}, 'FontSize',34)
savefig('spatialROI_OT_14y8m.fig')
saveas(gcf,'spatialROI_OT_14y8m','epsc')

% OT 2017
 test=readtable('OT2017_ROI.txt');
testArray=table2array(test(:,[2:4]))
testArray([15],:)=NaN; 

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'OT (age: 17y7m)'}, 'FontSize',34)
savefig('spatialROI_OT_17y7m.fig')
saveas(gcf,'spatialROI_OT_17y7m','epsc')

% OT 2018 
 test=readtable('OT2018_ROI.txt')
testArray=table2array(test(:,[2:4]))
testArray([15],:)=NaN; 

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'OT (18y5m)'}, 'FontSize',34)
savefig('spatialROI_OT_18y5m.fig')
saveas(gcf,'spatialROI_OT_18y5m','epsc')

% UD_CL1
test=readtable('UD1_ROI.txt')
testArray=table2array(test(:,[2:4]));
testArray([1:4,6,8,10,12,15,17],:)=NaN;  
% testArray([3,4,7,8,11,12,14,15],:)=NaN; %just ventral ROIs: ffa PPA loc vwfa and EVC

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'UD (7y10m)'}, 'FontSize',34)
savefig('spatialROI_UD_7y10m.fig')
saveas(gcf,'spatialROI_UD_7y10m','epsc')

% UD_CL2
test=readtable('UD2_ROI.txt')
testArray=table2array(test(:,[2:4]));
testArray([2,4,6,8,10,12,15,17],:)=NaN;  
% testArray([3,4,7,8,11,12,14,15],:)=NaN; %just ventral ROIs: ffa PPA loc vwfa and EVC


FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'UD (8y4m)'}, 'FontSize',34)
savefig('spatialROI_UD_8y4m.fig')
saveas(gcf,'spatialROI_UD_8y4m','epsc')


% UD_CL3 
test=readtable('UD3_ROI.txt')
testArray=table2array(test(:,[2:4]));
testArray([2,4,6,8,10,12,15, 17],:)=NaN;  
 % testArray([3,4,7,8,11,12,14,15],:)=NaN; %just ventral ROIs: ffa PPA loc vwfa and EVC

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'UD (8y10m)'}, 'FontSize',34)
savefig('spatialROI_UD_8y10m.fig')
saveas(gcf,'spatialROI_UD_8y10m','epsc')

% UD_CL4 
test=readtable('UD4_ROI.txt')
testArray=table2array(test(:,[2:4]));
testArray([2,4,6,8,10,12,17],:)=NaN;  
 % testArray([3,4,7,8,11,12,14,15],:)=NaN; %just ventral ROIs: ffa PPA loc vwfa and EVC

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'UD (10y10m)'}, 'FontSize',34)
savefig('spatialROI_UD_10y10m.fig')
saveas(gcf,'spatialROI_UD_10y10m','epsc')


% UD_CL5 
test=readtable('UD5_ROI.txt')
testArray=table2array(test(:,[2:4]));
testArray([2,4,6,8,10,12,17],:)=NaN;  
 % testArray([3,4,7,8,11,12,14,15],:)=NaN; %just ventral ROIs: ffa PPA loc vwfa and EVC

FigHandle = figure('Position', [100, 100, 600, 400]); marker_size=500;
for r=1:17
    scatter(testArray(r,1,1),testArray(r,2,1),marker_size,c{r},'filled','MarkerEdgeColor','black','LineWidth',.5)
    hold on
end
%set(gca, 'YDir','reverse')
set(gca, 'FontSize', 28)
xlabel(' LH  <---------->  RH','FontSize', 30)
ylabel('P  <--->  A','FontSize', 30)
xlim([-20 100])
xticks([-20, 40, 100])
xticklabels([0, 88, 176])
%xticklabels({'Lateral','Medial','Lateral'})
ylim([-120 40])
yticks([-100, -40, 20])
yticklabels([10, 70, 130])
hold on
set(gca, 'tickdir', 'out');
box off
% set(gca,'color',[.9 .9 .9]);
ax = gca;
ax.XAxis.TickLength = [0 0];
ax.YAxis.TickLength = [0 0];
set(gca, 'Color','[.94 .94 .94]', 'XColor','k', 'YColor','k');
title({'UD (13y)'}, 'FontSize',34)
savefig('spatialROI_UD_13y.fig')
saveas(gcf,'spatialROI_UD_13y','epsc')

