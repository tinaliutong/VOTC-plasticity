
%% load OT_anat_lFGOTS.mat
cMap = jet;
FigHandle = figure('Position', [100, 100, 1300, 250])
subplot(1,4,1)
colormap(cMap)
% view 1 * dorsal word selectivity increase
h=scatter3(FGOTS_CL1(:,1),FGOTS_CL1(:,2), FGOTS_CL1(:,3),3, FGOTS_CL1(:,4) , '+'); %
 colormap(cMap)
view (222,20)   
caxis([-5  5])
set(gca,'XLim',[100 200],'YLim',[140 220],'ZLim',[95 130])
% 
xlabel('X','FontSize',12,'FontWeight','bold','Color','k');
ylabel('Y','FontSize',12,'FontWeight','bold','Color','k')
zlabel('Z','FontSize',12,'FontWeight','bold','Color','k','Rotation',90)
% set (gca,'Xdir','reverse')
set (gca,'Zdir','reverse')
%set (gca,'Ydir','reverse')
set (gca, 'FontSize', 14) 
title('face-word: OT1','FontSize',20,'FontWeight','bold','Color','k')

subplot(1,4,2)
% view 1 * dorsal word selectivity increase
h=scatter3(FGOTS_CL2(:,1),FGOTS_CL2(:,2), FGOTS_CL2(:,3),3, FGOTS_CL2(:,4) , '+'); %
colormap(cMap)
view (222,20)   
caxis([-5  5])
set(gca,'XLim',[100 200],'YLim',[140 220],'ZLim',[95 130])
% 
xlabel('X','FontSize',12,'FontWeight','bold','Color','k');
ylabel('Y','FontSize',12,'FontWeight','bold','Color','k')
zlabel('Z','FontSize',12,'FontWeight','bold','Color','k','Rotation',90)
% set (gca,'Xdir','reverse')
set (gca,'Zdir','reverse')
%set (gca,'Ydir','reverse')
set (gca, 'FontSize', 14) 
title('face-word: OT2','FontSize',20,'FontWeight','bold','Color','k')

subplot(1,4,3)
% view 1 * dorsal word selectivity increase
h=scatter3(FGOTS_CL3(:,1),FGOTS_CL3(:,2), FGOTS_CL3(:,3),3, FGOTS_CL3(:,4) , '+'); %
colormap(cMap)
view (222,20)   
caxis([-5  5])
set(gca,'XLim',[100 200],'YLim',[140 220],'ZLim',[95 130])
% 
xlabel('X','FontSize',12,'FontWeight','bold','Color','k');
ylabel('Y','FontSize',12,'FontWeight','bold','Color','k')
zlabel('Z','FontSize',12,'FontWeight','bold','Color','k','Rotation',90)
% set (gca,'Xdir','reverse')
set (gca,'Zdir','reverse')
%set (gca,'Ydir','reverse')
set (gca, 'FontSize', 14) 
title('face-word: OT3','FontSize',20,'FontWeight','bold','Color','k')

meanCL1=mean(FGOTS_CL1(:,4))
meanCL2=mean(FGOTS_CL2(:,4))
meanCL3=mean(FGOTS_CL3(:,4))


subplot(1,4,4)
colormap(cMap)
colorbar
caxis([-5  5])

savefig('OT_3sessions_face-word_view222.fig')
print -painters -depsc OT_3sessions_face-word_view222.eps

%% Voxel Stats
% face - word
[h12,p12,ci12,stats12] = ttest2(FGOTS_CL1(:,4),FGOTS_CL2(:,4))
% % 
% %h12 =
% 
%      0
% 
% 
% p12 =
% 
%     0.2987
% 
% 
% ci12 =
% 
%    -0.0202
%     0.0657
% 
% 
% stats12 = 
% 
%   struct with fields:
% 
%     tstat: 1.0393
%        df: 24204
%        sd: 1.7032

[h13,p13,ci13,stats13] = ttest2(FGOTS_CL1(:,4),FGOTS_CL3(:,4))
% h13 =
% 
%      0
% 
% 
% p13 =
% 
%     0.7049
% 
% 
% ci13 =
% 
%    -0.0339
%     0.0502
% 
% 
% stats13 = 
% 
%   struct with fields:
% 
%     tstat: 0.3787
%        df: 24204
%        sd: 1.6686

[h23,p23,ci23,stats23] = ttest2(FGOTS_CL2(:,4),FGOTS_CL3(:,4))
%
% h23 =
% 
%      0
% 
% 
% p23 =
% 
%     0.4851
% 
% 
% ci23 =
% 
%    -0.0544
%     0.0258
% 
% 
% stats23 = 
% 
%   struct with fields:
% 
%     tstat: -0.6982
%        df: 24204
%        sd: 1.5909