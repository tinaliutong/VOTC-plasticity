clear all
% cd /Users/liut7/Library/CloudStorage/Box-Box/VWFAPlasticityPaper/forMarlene_OneDrive/Spatial organization of the visual cortex/Anat_FG_OTS
load UD_anat_FGOTS_Obj_Fixation_CL12345_ttest.mat
load Jet2.mat;
load Jet1.mat;
 
%% face-words
cMap = jet;
FigHandle = figure('Position', [100, 100, 2000, 250])
subplot(1,6,1)
colormap(cMap)
% view 1 * dorsal word selectivity increase
h=scatter3(FGOTS_CL1_face_word(:,1),FGOTS_CL1_face_word(:,2), FGOTS_CL1_face_word(:,3),3, FGOTS_CL1_face_word(:,4) , '+'); %
colormap(cMap)
view (322,20)
caxis([-5  5])
set(gca,'XLim',[150 200],'YLim',[130 250],'ZLim',[100 140])
%
xlabel('X','FontSize',12,'FontWeight','bold','Color','k');
ylabel('Y','FontSize',12,'FontWeight','bold','Color','k')
zlabel('Z','FontSize',12,'FontWeight','bold','Color','k','Rotation',90)
% set (gca,'Xdir','reverse')
% set (gca,'Zdir','reverse')
%set (gca,'Ydir','reverse')
set (gca, 'FontSize', 14)
title('face-word: UD (7y10m)','FontSize',20,'FontWeight','bold','Color','k')

subplot(1,6,2)
scatter3(FGOTS_CL2_face_word(:,1), FGOTS_CL2_face_word(:,2), FGOTS_CL2_face_word(:,3),3, FGOTS_CL2_face_word(:,4)  ,'+'); %
colormap(cMap)
view (322,20)
caxis([-5  5])
set(gca,'XLim',[150 200],'YLim',[130 250],'ZLim',[100 140])

set (gca, 'FontSize', 14)
title('UD (8y4m)','FontSize',20,'FontWeight','bold','Color','k')

subplot(1,6,3)
scatter3(FGOTS_CL3_face_word(:,1), FGOTS_CL3_face_word(:,2), FGOTS_CL3_face_word(:,3),3, FGOTS_CL3_face_word(:,4) ,'+'); %
colormap(cMap)
view (322,20)
caxis([-5  5])
set(gca,'XLim',[150 200],'YLim',[130 250],'ZLim',[100 140])
set (gca, 'FontSize', 14)
title('UD (8y10m)','FontSize',20,'FontWeight','bold','Color','k')

subplot(1,6,4)
scatter3(FGOTS_CL4_face_word(:,1), FGOTS_CL4_face_word(:,2), FGOTS_CL4_face_word(:,3),3, FGOTS_CL4_face_word(:,4)  ,'+'); %
colormap(cMap)
view (322,20)
caxis([-5  5])
set(gca,'XLim',[150 200],'YLim',[130 250],'ZLim',[100 140])
set (gca, 'FontSize', 14)
title('UD (10y10m)','FontSize',20,'FontWeight','bold','Color','k')

subplot(1,6,5)
scatter3(FGOTS_CL5_face_word(:,1), FGOTS_CL5_face_word(:,2), FGOTS_CL5_face_word(:,3),3, FGOTS_CL5_face_word(:,4)  ,'+'); %
colormap(cMap)
view (322,20)
caxis([-5  5])
%caxis([-6  6])
set(gca,'XLim',[150 200],'YLim',[130 250],'ZLim',[100 140])
set (gca, 'FontSize', 14)
title('UD (13y)','FontSize',20,'FontWeight','bold','Color','k')

subplot(1,6,6)
colormap(cMap)
colorbar
caxis([-5  5])

savefig('UD_5sessions_face-word.fig')
% saveas(gcf,'UD_5sessions_face-word','epsc')
print -painters -depsc UD_5sessions_face-word.eps
 
%% voxel Stats
%% face - word
[h12,p12,ci12,stats12] = ttest2(FGOTS_CL1(:,4),FGOTS_CL2(:,4))
% % 
% h12 =
% 
%      0
% 
% 
% p12 =
% 
%     0.8435
% 
% 
% ci12 =
% 
%    -0.0259
%     0.0317
% 
% 
% stats12 = 
% 
%   struct with fields:
% 
%     tstat: 0.1974
%        df: 24854
%        sd: 1.1574

[h23,p23,ci23,stats23] = ttest2(FGOTS_CL2(:,4),FGOTS_CL3(:,4))
% h23 =
% 
%      1
% 
% 
% p23 =
% 
%    8.3455e-38
% 
% 
% ci23 =
% 
%    -0.2213
%    -0.1628
% 
% 
% stats23 = 
% 
%   struct with fields:
% 
%     tstat: -12.8738
%        df: 24854
%        sd: 1.1761

[h34,p34,ci34,stats34] = ttest2(FGOTS_CL3(:,4),FGOTS_CL4(:,4))

% h34 =
% 
%      1
% 
% 
% p34 =
% 
%   1.7023e-287
% 
% 
% ci34 =
% 
%    -0.8232
%    -0.7397
% 
% 
% stats34 = 
% 
%   struct with fields:
% 
%     tstat: -36.7194
%        df: 24854
%        sd: 1.6776

[h45,p45,ci45,stats45] = ttest2(FGOTS_CL4(:,4),FGOTS_CL5(:,4))

% h45 =
% 
%      1
% 
% 
% p45 =
% 
%     0.0020
% 
% 
% ci45 =
% 
%     0.0298
%     0.1327
% 
% 
% stats45 = 
% 
%   struct with fields:
% 
%     tstat: 3.0961
%        df: 24854
%        sd: 2.0685

%% object - scrambled
[h12,p12,ci12,stats12] = ttest2(FGOTS_CL1_Obj(:,4),FGOTS_CL2_Obj(:,4))
% h12 =
% 
%      0
% 
% 
% p12 =
% 
%     0.9062
% 
% 
% ci12 =
% 
%    -0.0301
%     0.0267
% 
% 
% stats12 = 
% 
%   struct with fields:
% 
%     tstat: -0.1179
%        df: 24854
%        sd: 1.1409

[h23,p23,ci23,stats23] = ttest2(FGOTS_CL2_Obj(:,4),FGOTS_CL3_Obj(:,4))
% h23 =
% 
%      0
% 
% 
% p23 =
% 
%     0.9633
% 
% 
% ci23 =
% 
%    -0.0275
%     0.0288
% 
% 
% stats23 = 
% 
%   struct with fields:
% 
%     tstat: 0.0461
%        df: 24854
%        sd: 1.1336
 
[h34,p34,ci34,stats34] = ttest2(FGOTS_CL3_Obj(:,4),FGOTS_CL4_Obj(:,4))
% h34 =
% 
%      0
% 
% 
% p34 =
% 
%     0.3290
% 
% 
% ci34 =
% 
%    -0.0325
%     0.0109
% 
% 
% stats34 = 
% 
%   struct with fields:
% 
%     tstat: -0.9762
%        df: 24854
%        sd: 0.8714

[h45,p45,ci45,stats45] = ttest2(FGOTS_CL5_Obj(:,4),FGOTS_CL4_Obj(:,4))
% h45 =
% 
%      0
% 
% 
% p45 =
% 
%     0.3173
% 
% 
% ci45 =
% 
%    -0.0153
%     0.0471
% 
% 
% stats45 = 
% 
%   struct with fields:
% 
%     tstat: 0.9999
%        df: 24854
%        sd: 1.2554

[h15,p15,ci15,stats15] = ttest2(FGOTS_CL5_Obj(:,4),FGOTS_CL1_Obj(:,4))
% h15 =
% 
%      0
% 
% 
% p15 =
% 
%     0.0818
% 
% 
% ci15 =
% 
%    -0.0035
%     0.0590
% 
% 
% stats15 = 
% 
%   struct with fields:
% 
%     tstat: 1.7405
%        df: 24854
%        sd: 1.2572

[h25,p25,ci25,stats25] = ttest2(FGOTS_CL5_Obj(:,4),FGOTS_CL2_Obj(:,4))
% h25 =
% 
%      0
% 
% 
% p25 =
% 
%     0.1566
% 
% 
% ci25 =
% 
%    -0.0100
%     0.0621
% 
% 
% stats25 = 
% 
%   struct with fields:
% 
%     tstat: 1.4166
%        df: 24854
%        sd: 1.4497