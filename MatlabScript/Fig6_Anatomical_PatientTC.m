clear all
load TC_face_word_obj_fix_S123_2023.mat
load Jet2.mat;
load Jet1.mat;

%% face - word  
cMap = jet;
FigHandle = figure('Position', [10, 100,1300, 250])
subplot(1,4,1)
scatter3(FGOTS_CL1(:,1), FGOTS_CL1(:,2), FGOTS_CL1(:,3),3, FGOTS_CL1(:,4),'+');
colormap(cMap)
colorbar off
%view (10,50)
%view (300,20) % no diff
view (175,-10) % posterior word
%%view (200,20) % ventral word
%view (40,20) % lateral word
%rotate3d('on')
xlabel('X','FontSize',12,'FontWeight','bold','Color','k');
 ylabel('Y','FontSize',12,'FontWeight','bold','Color','k')
 zlabel('Z','FontSize',12,'FontWeight','bold','Color','k')
grid on
%set (gca,'Zdir','reverse')
xticks([60 80 100])
yticks([160 190])
zticks([100 110 120 130 140])
set(gca,'XLim',[60 110],'YLim',[150 210],'ZLim',[100 140])
caxis([-5  5])
set (gca, 'FontSize', 14)
title('face-word: TC (13y3m)','FontSize',18,'FontWeight','bold','Color','k')

subplot(1,4,2)
scatter3(FGOTS_CL2(:,1), FGOTS_CL2(:,2), FGOTS_CL2(:,3),3, FGOTS_CL2(:,4),'+');
colormap(cMap)
colorbar off
view (175,-10) % posterior word
%rotate3d('on')
caxis([-5  5])
grid on
%set (gca,'Zdir','reverse')

xticks([60 80 100])
yticks([160 190])
zticks([100 110 120 130 140])
set(gca,'XLim',[60 110],'YLim',[150 210],'ZLim',[100 140])
grid on
set (gca, 'FontSize', 14) 
title('TC (13y11m)','FontSize',18,'FontWeight','bold','Color','k')

subplot(1,4,3)
scatter3(FGOTS_CL3(:,1), FGOTS_CL3(:,2), FGOTS_CL3(:,3),3, FGOTS_CL3(:,4),'+');
colormap(cMap)
colorbar off
view (175,-10) % posterior word
caxis([-5  5])
grid on
%set (gca,'Zdir','reverse')

xticks([60 80 100])
yticks([160 190])
zticks([100 110 120 130 140])
set(gca,'XLim',[60 110],'YLim',[150 210],'ZLim',[100 140])

set (gca, 'FontSize', 14)
% a = annotation('textarrow',x,y,'String','y = x ');
title('TC (15y9m)','FontSize',18,'FontWeight','bold','Color','k')
%
subplot(1,4,4)
colormap(cMap)
colorbar
caxis([-5  5])

savefig('TC_3sessions_face-word_175_-10.fig')
% saveas(gcf,'UD_5sessions_face-word','epsc')
print -painters -depsc TC_3sessions_face-word_175_-10.eps


% voxel Stats

[h12,p12,ci12,stats12] = ttest2(FGOTS_CL1(:,4),FGOTS_CL2(:,4))
% h12 =
% 
%      1
% 
% 
% p12 =
% 
%   1.7954e-264
% 
% 
% ci12 =
% 
%     1.1472
%     1.2814
% 
% 
% stats12 = 
% 
%   struct with fields:
% 
%     tstat: 35.4732
%        df: 14612
%        sd: 2.0692

[h23,p23,ci23,stats23] = ttest2(FGOTS_CL2(:,4),FGOTS_CL3(:,4))
% h23 =
% 
%      1
% 
% 
% p23 =
% 
%    7.1474e-11
% 
% 
% ci23 =
% 
%     0.1333
%     0.2479
% 
% 
% stats23 = 
% 
%   struct with fields:
% 
%     tstat: 6.5224
%        df: 14612
%        sd: 1.7662
 

[h13,p13,ci13,stats13] = ttest2(FGOTS_CL1(:,4),FGOTS_CL3(:,4))
% h13 =
% 
%      1
% 
% 
% p13 =
% 
%   3.1819e-273
% 
% 
% ci13 =
% 
%     1.3286
%     1.4812
% 
% 
% stats13 = 
% 
%   struct with fields:
% 
%     tstat: 36.0853
%        df: 14612
%        sd: 2.3533
       
 [h12,p12,ci12,stats12] = ttest2(FGOTS_Obj_CL1(:,4),FGOTS_Obj_CL2(:,4))
% 
% h12 =
% 
%      0
% 
% 
% p12 =
% 
%     0.1215
% 
% 
% ci12 =
% 
%    -0.0123
%     0.1052
% 
% 
% stats12 = 
% 
%   struct with fields:
% 
%     tstat: 1.5488
%        df: 14612
%        sd: 1.8119


[h23,p23,ci23,stats23] = ttest2(FGOTS_Obj_CL2(:,4),FGOTS_Obj_CL3(:,4))
% h23 =
% 
%      0
% 
% 
% p23 =
% 
%     0.2446
% 
% 
% ci23 =
% 
%    -0.0999
%     0.0255
% 
% 
% stats23 = 
% 
%   struct with fields:
% 
%     tstat: -1.1637
%        df: 14612
%        sd: 1.9330

[h13,p13,ci13,stats13] = ttest2(FGOTS_Obj_CL1(:,4),FGOTS_Obj_CL3(:,4))
% h13 =
% 
%      0
% 
% 
% p13 =
% 
%     0.7706
% 
% 
% ci13 =
% 
%    -0.0527
%     0.0711
% 
% 
% stats13 = 
% 
%   struct with fields:
% 
%     tstat: 0.2916
%        df: 14612
%        sd: 1.9097
% 
%% mean(FGOTS_Obj_CL1(:,4))
% 
% ans =
% 
%     2.1334
% 
% mean(FGOTS_Obj_CL2(:,4))
% 
% ans =
% 
%     2.0870
% 
% mean(FGOTS_Obj_CL3(:,4))
% 
% ans =
% 
%     2.1242
 
% 
%% mean(FGOTS_Obj_CL1(:,4))
% 
% ans =
% 
%     2.1334
% 
% mean(FGOTS_Obj_CL2(:,4))
% 
% ans =
% 
%     2.0870
% 
% mean(FGOTS_Obj_CL3(:,4))
% 
% ans =
% 
%     2.1242

