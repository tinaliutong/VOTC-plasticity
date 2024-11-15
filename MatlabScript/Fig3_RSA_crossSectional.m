clear all
rois={'Sphere_Broca.rdm','Sphere_Wer.rdm','Sphere_VWFA.rdm','Sphere_lFFA.rdm','Sphere_lSTS.rdm','Sphere_lPF.rdm','Sphere_lLOC.rdm','Sphere_lPPA.rdm','Sphere_lTOS.rdm','Sphere_lEVC.rdm','Sphere_rEVC.rdm','Sphere_rTOS.rdm','Sphere_rPPA.rdm','Sphere_rLOC.rdm','Sphere_rPF.rdm','Sphere_rSTS.rdm','Sphere_rFFA.rdm'};


rois_title={'Broca','Wer','VWFA','lFFA','lSTS','lPF','lLOC','lPPA','lTOS','lEVC','rEVC','rTOS','rPPA','rLOC','rPF','rSTS','rFFA'}; %

for g=1:2
    %controls
    path='/Users/tl925/Library/CloudStorage/Box-Box/VWFAPlasticityPaper/forMarlene_OneDrive/Spatial organization of the visual cortex/RSA_Tina/Controls/RSA_443/';
    if g==1
        subjects={'C12','626','307','853','828','631','731','C20','C18','C11','256','C16',...% from Fig 2
            'C07','C19', '712','228','701','957','917','C14','719','809','440','153','039'}  % 12+13=25  
    else
        %patients
        path='/Users/tl925/Library/CloudStorage/Box-Box/VWFAPlasticityPaper/forMarlene_OneDrive/Spatial organization of the visual cortex/RSA_Tina/';
        % subjects={'KN_rsa_1393','SN_rsa_1393','OT2014_rsa_1393','OT2017_rsa_1393','OT2018_rsa_1393','TC2016_rsa_1393','TC2017_rsa_1393','TC2019_rsa_1393','UD_rsa_CL1_1393','UD_rsa_CL2_1393','UD_rsa_CL3_1393','UD_rsa_CL4_1393','UD_rsa_CL5_1393'}
        subjects={'KN_rsa_443','SN_rsa_443','TC2016_rsa_443','TC2017_rsa_443','TC2019_rsa_443','UD_rsa_CL1_443','UD_rsa_CL2_443','UD_rsa_CL3_443','UD_rsa_CL4_443','UD_rsa_CL5_443','OT2014_rsa_443','OT2017_rsa_443','OT2018_rsa_443'};
    end
    for s=1:length(subjects)
        tempdir=struct2cell(dir([path subjects{s} '/*.rdm']));
        tempdir=tempdir(1,:);
        for r=1:length(rois)
            a=find(strcmp(tempdir,rois{r}));
            if a>0
                A = importdata([path subjects{s}  '/' rois{r}],' ',3);
                A.textdata(1) = [];
                A.data=1-A.data;
                data_nofisher(:,:,r,s,g)=A.data;
                A.data=real(0.5*log((1+A.data)./(1-A.data)));%fisher
                data(:,:,r,s,g)=A.data;
            end
        end
    end
end

controls = squeeze(data(:,:,:,:,1));
patients = squeeze(data(:,:,:,:,2)); % has 0s
controls_nofisher = squeeze(data_nofisher(:,:,:,:,1));
patients_nofisher = squeeze(data_nofisher(:,:,:,:,2));

% making 0s as NaNs
for i=1:25
    for j = 1:length(rois)
        if patients(:,:,j,i)== 0
            patients(:,:,j,i)= nan;
        end
    end
end

for i=1:25
    for j = 1:length(rois)
        if patients_nofisher(:,:,j,i)== 0
            patients_nofisher(:,:,j,i)= nan;
        end
    end
end

patients_avg=squeeze(nanmean(patients(:,:,:,:),4));
controls_avg =squeeze(nanmean(controls(:,:,:,:),4));
 

patients(isinf(patients)) = 0;
controls(isinf(controls)) = 0;

%% imp correlation score
for i=1:length(controls)% 25 controls
    % prefered vs all other categories:
    Broca(i,1)=nanmean(controls(5,1:4,1,i));
    Wernicke(i,1)=nanmean(controls(5,1:4,2,i));
    VWFA(i,1)=nanmean(controls(5,1:4,3,i));
    FFA_L(i,1)=nanmean(controls(1,2:5,4,i));
    STS_L(i,1)=nanmean(controls(1,2:5,5,i));
    pF_L(i,1)=nanmean(controls(2,[1 3:5],6,i));
    LOC_L(i,1)=nanmean(controls(2,[1 3:5],7,i));
    PPA_L(i,1)=nanmean(controls(3,[1 2 4 5],8,i));
    TOS_L(i,1)=nanmean(controls(3,[1 2 4 5],9,i));
    EVC_L(i,1)=nanmean(controls(3,[1 2 4 5],10,i));
    EVC_R(i,1)=nanmean(controls(3,[1 2 4 5],11,i));
    TOS_R(i,1)=nanmean(controls(3,[1 2 4 5],12,i));
    PPA_R(i,1)=nanmean(controls(3,[1 2 4 5],13,i));
    LOC_R(i,1)=nanmean(controls(2,[1 3:5],14,i));
    pF_R(i,1)=nanmean(controls(2,[1 3:5],15,i));
    STS_R(i,1)=nanmean(controls(1,2:5,16,i));
    FFA_R(i,1)=nanmean(controls(1,2:5,17,i));
end


for i=1:13 % 13 sessions, 5 patients
    % prefered vs all other categories:
    %rois={'Sphere_Broca.rdm','Sphere_Wer.rdm','Sphere_VWFA.rdm','Sphere_lFFA.rdm','Sphere_lSTS.rdm','Sphere_lPF.rdm','Sphere_lLOC.rdm','Sphere_lPPA.rdm','Sphere_lTOS.rdm','Sphere_lEVC.rdm','Sphere_rEVC.rdm','Sphere_rTOS.rdm','Sphere_rPPA.rdm','Sphere_rLOC.rdm','Sphere_rPF.rdm','Sphere_rSTS.rdm','Sphere_rFFA.rdm'};
    %'
    Broca_Pat(i,1)=nanmean(patients(5,1:4,1,i));
    Wernicke_Pat(i,1)=nanmean(patients(5,1:4,2,i));
    VWFA_Pat(i,1)=nanmean(patients(5,1:4,3,i));
    FFA_L_Pat(i,1)=nanmean(patients(1,2:5,4,i));
    STS_L_Pat(i,1)=nanmean(patients(1,2:5,5,i));
    pF_L_Pat(i,1)=nanmean(patients(2,[1 3:5],6,i));
    LOC_L_Pat(i,1)=nanmean(patients(2,[1 3:5],7,i));
    PPA_L_Pat(i,1)=nanmean(patients(3,[1 2 4 5],8,i));
    TOS_L_Pat(i,1)=nanmean(patients(3,[1 2 4 5],9,i));
    EVC_L_Pat(i,1)=nanmean(patients(3,[1 2 4 5],10,i));
    EVC_R_Pat(i,1)=nanmean(patients(3,[1 2 4 5],11,i));
    TOS_R_Pat(i,1)=nanmean(patients(3,[1 2 4 5],12,i));
    PPA_R_Pat(i,1)=nanmean(patients(3,[1 2 4 5],13,i));
    LOC_R_Pat(i,1)=nanmean(patients(2,[1 3:5],14,i));
    pF_R_Pat(i,1)=nanmean(patients(2,[1 3:5],15,i));
    STS_R_Pat(i,1)=nanmean(patients(1,2:5,16,i));
    FFA_R_Pat(i,1)=nanmean(patients(1,2:5,17,i));
end

% Broca_Pat(1)=NaN; % KN not found
Broca_Pat(3)=NaN; % TC0 not found
Broca_Pat(6:8)=NaN; % UD1-3 not covered
Wernicke_Pat(3:4) = NaN;
FFA_L_Pat([1,3:6],1)=NaN;
STS_L_Pat([1,3:6],1)=NaN;
pF_L_Pat([1,3:5],1)=NaN;
LOC_L_Pat([1,3:5],1)=NaN;
PPA_L_Pat([1,3:5],1)=NaN;
TOS_L_Pat([1,3:5],1)=NaN;
TOS_R_Pat([6:10],1)=NaN; % UD
PPA_R_Pat([6:10],1)=NaN; % UD
LOC_R_Pat([6:10],1)=NaN; % UD
pF_R_Pat([6:10],1)=NaN;  % UD
STS_R_Pat([6:10],1)=NaN; % UD
FFA_R_Pat([6:10],1)=NaN; % UD
Broca_Pat(11:13)=NaN; % OT not covered

%% longitudinal figure

load('/Users/tl925/Library/CloudStorage/Box-Box/VWFAPlasticityPaper/forMarlene_OneDrive/Spatial organization of the visual cortex/Selectivty_Tina_443_1393/x_coor.mat')

FigHandle = figure('Position', [100, 100, 1600, 400]);
boxplot([Broca, Wernicke, VWFA,FFA_L,STS_L,pF_L,LOC_L,PPA_L,TOS_L,TOS_R,PPA_R,LOC_R,pF_R,STS_R,FFA_R],'Notch','on','Widths',.6,'Colors','rrrmmbbggggbbmm')
% boxplot([Broca, Wernicke, VWFA,FFA_L,STS_L,pF_L,LOC_L,PPA_L,TOS_L,TOS_R,PPA_R,LOC_R,pF_R,STS_R,FFA_R],'Notch','on','Widths',0.2,'Whisker',1,'Colors','rrrmmmmggggbbbb')
% boxplot([Broca, Wernicke, VWFA,FFA_L,STS_L,pF_L,LOC_L,PPA_L,TOS_L,TOS_R,PPA_R,LOC_R,pF_R,STS_R,FFA_R],'Widths',.3,'LineWidth')
markerSize = 200;
set(gca, 'tickdir', 'out');
%xticklabels({'lFFA','rFFA','lSTS','rSTS','lPPA','rPPA','lTOS','rTOS','lLOC','rLOC','lPF','rPF','VWFA','STG','IFG','lEVC','rEVC'});
ylim([-.6 1.8]) % for para
xlim([0 16])
ax = gca;
ax.FontSize = 22;
xticks(1:1:15)
xtickangle(0)
yticks(-.5:1:1.5)

xticklabels({'IFG','STG','VWFA','lFFA','lSTS','lPF','lLOC','lPPA','lTOS','rTOS','rPPA','rLOC','rPF','rSTS','rFFA'}) ;
% ylabel({'Fisher transformed correlation coefficient';'(correlation between preferred category and all other categories)'},'FontSize',16,'Color','k','FontAngle', 'italic')
ylabel({'Fisher transformed correlation coefficient'},'FontSize',20,'Color','k','FontAngle', 'italic')
box off
hold on

scatter(x_coor_Pat(3,1),Broca_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(4,1),Broca_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(5,1),Broca_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC3
scatter(x_coor_Pat(6,1),Broca_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(7,1),Broca_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(8,1),Broca_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(9,1),Broca_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); %  UD4
scatter(x_coor_Pat(10,1),Broca_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); %  UD5
scatter(x_coor_Pat(11,1),Broca_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); %  OT1
scatter(x_coor_Pat(12,1),Broca_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); %  OT2
scatter(x_coor_Pat(13,1),Broca_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k');  % OT3

scatter(x_coor_Pat(3,2),Wernicke_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,2),Wernicke_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,2),Wernicke_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,2),Wernicke_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,2),Wernicke_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,2),Wernicke_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,2),Wernicke_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,2),Wernicke_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,2),Wernicke_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,2),Wernicke_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,2),Wernicke_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', [1 120/255 0],'MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,3),VWFA_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,3),VWFA_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,3),VWFA_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,3),VWFA_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,3),VWFA_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,3),VWFA_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,3),VWFA_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,3),VWFA_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', [1 120/255 0],'MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,3),VWFA_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', [1 120/255 0],'MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,3),VWFA_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', [1 120/255 0],'MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,3),VWFA_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', [1 120/255 0],'MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,4),FFA_L_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,4),FFA_L_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,4),FFA_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,4),FFA_L_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,4),FFA_L_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,4),FFA_L_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,4),FFA_L_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,4),FFA_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,4),FFA_L_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,4),FFA_L_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,4),FFA_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % UD5


scatter(x_coor_Pat(3,5),STS_L_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,5),STS_L_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,5),STS_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,5),STS_L_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,5),STS_L_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,5),STS_L_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,5),STS_L_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,5),STS_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,5),STS_L_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,5),STS_L_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,5),STS_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,6),pF_L_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,6),pF_L_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,6),pF_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,6),pF_L_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,6),pF_L_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,6),pF_L_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,6),pF_L_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,6),pF_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,6),pF_L_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,6),pF_L_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,6),pF_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,7),LOC_L_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,7),LOC_L_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,7),LOC_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,7),LOC_L_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,7),LOC_L_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,7),LOC_L_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,7),LOC_L_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,7),LOC_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,7),LOC_L_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,7),LOC_L_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,7),LOC_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,8),PPA_L_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,8),PPA_L_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,8),PPA_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,8),PPA_L_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,8),PPA_L_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,8),PPA_L_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,8),PPA_L_Pat(9,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,8),PPA_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,8),PPA_L_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,8),PPA_L_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,8),PPA_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,9),TOS_L_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,9),TOS_L_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,9),TOS_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,9),TOS_L_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,9),TOS_L_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,9),TOS_L_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,9),TOS_L_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,9),TOS_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,9),TOS_L_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,9),TOS_L_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,9),TOS_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,10),TOS_R_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,10),TOS_R_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,10),TOS_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,10),TOS_R_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,10),TOS_R_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,10),TOS_R_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,10),TOS_R_Pat(9,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,10),TOS_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,10),TOS_R_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,10),TOS_R_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,10),TOS_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,11),PPA_R_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,11),PPA_R_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,11),PPA_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,11),PPA_R_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,11),PPA_R_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,11),PPA_R_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,11),PPA_R_Pat(9,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,11),PPA_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,11),PPA_R_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,11),PPA_R_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,11),PPA_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,12),LOC_R_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,12),LOC_R_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,12),LOC_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,12),LOC_R_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,12),LOC_R_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,12),LOC_R_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,12),LOC_R_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,12),LOC_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,12),LOC_R_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,12),LOC_R_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,12),LOC_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,13),pF_R_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,13),pF_R_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,13),pF_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,13),pF_R_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,13),pF_R_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,13),pF_R_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,13),pF_R_Pat(9,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,13),pF_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,13),pF_R_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,13),pF_R_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,13),pF_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,14),STS_R_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,14),STS_R_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,14),STS_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,14),STS_R_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,14),STS_R_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,14),STS_R_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,14),STS_R_Pat(9,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,14),STS_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,14),STS_R_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,14),STS_R_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,14),STS_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat(3,15),FFA_R_Pat(3,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % OT1
scatter(x_coor_Pat(4,15),FFA_R_Pat(4,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % OT2
scatter(x_coor_Pat(5,15),FFA_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat(6,15),FFA_R_Pat(6,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % TC1
scatter(x_coor_Pat(7,15),FFA_R_Pat(7,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % TC2
scatter(x_coor_Pat(8,15),FFA_R_Pat(8,1), markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % TC3
scatter(x_coor_Pat(9,15),FFA_R_Pat(9,1),  markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD1
scatter(x_coor_Pat(10,15),FFA_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat(11,15),FFA_R_Pat(11,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD3
scatter(x_coor_Pat(12,15),FFA_R_Pat(12,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD4
scatter(x_coor_Pat(13,15),FFA_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % UD5

saveas(gcf,'correlationCoefficient_Longitudinal','epsc')


%% cross sectional figure

FigHandle = figure('Position', [100, 100, 1600, 400]);
boxplot([Broca, Wernicke, VWFA,FFA_L,STS_L,pF_L,LOC_L,PPA_L,TOS_L,TOS_R,PPA_R,LOC_R,pF_R,STS_R,FFA_R],'Notch','on','Widths',.6,'Colors','rrrmmbbggggbbmm')
markerSize = 200;
set(gca, 'tickdir', 'out');
%xticklabels({'lFFA','rFFA','lSTS','rSTS','lPPA','rPPA','lTOS','rTOS','lLOC','rLOC','lPF','rPF','VWFA','STG','IFG','lEVC','rEVC'});
ylim([-.6 1.8]) % for para
xlim([0 16])
ax = gca;
ax.FontSize = 22;
xticks(1:1:15)
xtickangle(0)

% xticks(1:1:17)
yticks(-.5:1:1.5)

xticklabels({'IFG','STG','VWFA','lFFA','lSTS','lPF','lLOC','lPPA','lTOS','rTOS','rPPA','rLOC','rPF','rSTS','rFFA'}) ;
% ylabel({'Fisher transformed correlation coefficient';'(correlation between preferred category and all other categories)'},'FontSize',16,'Color','k','FontAngle', 'italic')
ylabel({'Fisher transformed correlation coefficient'},'FontSize',20,'Color','k','FontAngle', 'italic')
box off
hold on

scatter(x_coor_Pat_crossSec(1,1),Broca_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,1),Broca_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,1),Broca_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC3
scatter(x_coor_Pat_crossSec(4,1),Broca_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); %  UD5
scatter(x_coor_Pat_crossSec(5,1),Broca_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k');  % OT3

scatter(x_coor_Pat_crossSec(1,2),Wernicke_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,2),Wernicke_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,2),Wernicke_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC3
scatter(x_coor_Pat_crossSec(4,2),Wernicke_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % UD5
scatter(x_coor_Pat_crossSec(5,2),Wernicke_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', [1 120/255 0],'MarkerEdgeColor','k');  % OT3

scatter(x_coor_Pat_crossSec(1,3),VWFA_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,3),VWFA_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,3),VWFA_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor',[1 120/255 0],'MarkerEdgeColor','k'); % TC3
scatter(x_coor_Pat_crossSec(4,3),VWFA_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', [1 120/255 0],'MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,3),VWFA_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', [1 120/255 0],'MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,4),FFA_L_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,4),FFA_L_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,4),FFA_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,4),FFA_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,4),FFA_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,1), FFA_L_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,5),STS_L_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,5),STS_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,5),STS_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,5),STS_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,6),pF_L_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,6),pF_L_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,6),pF_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,6),pF_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,6),pF_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k');  % UD5


scatter(x_coor_Pat_crossSec(1,7),LOC_L_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,7),LOC_L_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,7),LOC_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,7),LOC_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,7),LOC_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k');  % UD5


scatter(x_coor_Pat_crossSec(1,8),PPA_L_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,8),PPA_L_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,8),PPA_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,8),PPA_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,8),PPA_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,9),TOS_L_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,9),TOS_L_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,9),TOS_L_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,9),TOS_L_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,9),TOS_L_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,10),TOS_R_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,10),TOS_R_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,10),TOS_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,10),TOS_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,10),TOS_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,11),PPA_R_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,11),PPA_R_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,11),PPA_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','g','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,11),PPA_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,11),PPA_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'g','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,12),LOC_R_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,12),LOC_R_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,12),LOC_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,12),LOC_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,12),LOC_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,13),pF_R_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,13),pF_R_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,13),pF_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','b','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,13),pF_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,13),pF_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'b','MarkerEdgeColor','k');  % UD5


scatter(x_coor_Pat_crossSec(1,14),STS_R_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,14),STS_R_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,14),STS_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor','m','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,14),STS_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,14),STS_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % UD5

scatter(x_coor_Pat_crossSec(1,15),FFA_R_Pat(1,1), markerSize,'^','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % KN
scatter(x_coor_Pat_crossSec(2,15),FFA_R_Pat(2,1), markerSize,'o','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % SN
scatter(x_coor_Pat_crossSec(3,15),FFA_R_Pat(5,1), markerSize,'s','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % OT3
scatter(x_coor_Pat_crossSec(4,15),FFA_R_Pat(10,1),markerSize,'d','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k'); % UD2
scatter(x_coor_Pat_crossSec(5,15),FFA_R_Pat(13,1),markerSize+100,'pentagram','LineWidth',.2,'MarkerFaceColor', 'm','MarkerEdgeColor','k');  % UD5


%scatter(x_coor(:,16),EVC_L(:,1), markerSize,'o','LineWidth',1, 'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerEdgeColor',[1 0.5 0]);
%scatter(x_coor_Pat(:,16),EVC_L_Pat(:,1), markerSize,'d','LineWidth',1, 'MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor',[1 0.5 0]);
%scatter(x_coor(:,17),EVC_R(:,1), markerSize,'o','LineWidth',1, 'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerEdgeColor',[1 0.5 0]);
%scatter(x_coor_Pat(:,17),EVC_R_Pat(:,1), markerSize,'d','LineWidth',1, 'MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor',[1 0.5 0]);

saveas(gcf,'correlationCoefficient_crossSectional','epsc')


subjects={'C12','626','307','523','828','631','731','C20','C18','C11','256','C16',... %12
    'C07','C19', '712','701','957','917','C14','809','719','926','440','153','039'};  % 21+13=25

%subjects={'KN_rsa_443','SN_rsa_443','OT2014_rsa_443','OT2017_rsa_443','OT2018_rsa_443','TC2016_rsa_443','TC2017_rsa_443','TC2019_rsa_443','UD_rsa_CL1_443','UD_rsa_CL2_443','UD_rsa_CL3_443','UD_rsa_CL4_443','UD_rsa_CL5_443'};
%%


%% Crawford tests
marker_size=15
% t_crawford_EVC_L(:,1)=(EVC_L(:,1)-nanmean(EVC_L(:,1)))./ (nanstd(EVC_L(:,1)*sqrt((length(subjects)+1)/length(subjects))))
% t_crawford_EVC_R(:,1)=(EVC_R(:,1)-nanmean(EVC_R(:,1)))./ (nanstd(EVC_R(:,1)*sqrt((length(subjects)+1)/length(subjects))))
t_crawford_Broca_Pat(:,1)=(Broca_Pat(:,1)-nanmean(Broca(:,1)))./ (nanstd(Broca(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_VWFA_Pat(:,1) =(VWFA_Pat(:,1)-nanmean(VWFA(:,1)))./ (nanstd(VWFA(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_Wernicke_Pat(:,1)=(Wernicke_Pat(:,1)-nanmean(Wernicke(:,1)))./ (nanstd(Wernicke(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_FFA_L_Pat(:,1)=(FFA_L_Pat(:,1)-nanmean(FFA_L(:,1)))./ (nanstd(FFA_L(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_FFA_R_Pat(:,1)=(FFA_R_Pat(:,1)-nanmean(FFA_R(:,1)))./ (nanstd(FFA_R(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_STS_L_Pat(:,1)=(STS_L_Pat(:,1)-nanmean(STS_L(:,1)))./ (nanstd(STS_L(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_STS_R_Pat(:,1)=(STS_R_Pat(:,1)-nanmean(STS_R(:,1)))./ (nanstd(STS_R(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_PPA_R_Pat(:,1)=(PPA_R_Pat(:,1)-nanmean(PPA_R(:,1)))./ (nanstd(PPA_R(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_PPA_L_Pat(:,1)=(PPA_L_Pat(:,1)-nanmean(PPA_L(:,1)))./ (nanstd(PPA_L(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_TOS_L_Pat(:,1)=(TOS_L_Pat(:,1)-nanmean(TOS_L(:,1)))./ (nanstd(TOS_L(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_TOS_R_Pat(:,1)=(TOS_R_Pat(:,1)-nanmean(TOS_R(:,1)))./ (nanstd(TOS_R(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_pF_L_Pat(:,1) =(pF_L_Pat(:,1) -nanmean(pF_L(:,1)))./ (nanstd(pF_L(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_pF_R_Pat(:,1) =(pF_R_Pat(:,1) -nanmean(pF_R(:,1)))./ (nanstd(pF_R(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_LOC_L_Pat(:,1)=(LOC_L_Pat(:,1)-nanmean(LOC_L(:,1)))./ (nanstd(LOC_L(:,1)*sqrt((length(subjects)+1)/length(subjects))));
t_crawford_LOC_R_Pat(:,1)=(LOC_R_Pat(:,1)-nanmean(LOC_R(:,1)))./ (nanstd(LOC_R(:,1)*sqrt((length(subjects)+1)/length(subjects))));

t_crawford_all_regions_Pat=cat(3,t_crawford_Broca_Pat,t_crawford_Wernicke_Pat,t_crawford_VWFA_Pat,t_crawford_FFA_L_Pat,t_crawford_STS_L_Pat,t_crawford_pF_L_Pat,t_crawford_LOC_L_Pat,t_crawford_PPA_L_Pat,t_crawford_TOS_L_Pat,t_crawford_TOS_R_Pat,t_crawford_PPA_R_Pat,t_crawford_LOC_R_Pat,t_crawford_pF_R_Pat, t_crawford_STS_R_Pat,t_crawford_FFA_R_Pat);
t_crawford_all_regions_Pat_long=cat(3,t_crawford_Broca_Pat(3:13),t_crawford_Wernicke_Pat(3:13),t_crawford_VWFA_Pat(3:13),t_crawford_FFA_L_Pat(3:13),t_crawford_STS_L_Pat(3:13),t_crawford_pF_L_Pat(3:13),t_crawford_LOC_L_Pat(3:13),t_crawford_PPA_L_Pat(3:13),t_crawford_TOS_L_Pat(3:13),t_crawford_TOS_R_Pat(3:13),t_crawford_PPA_R_Pat(3:13),t_crawford_LOC_R_Pat(3:13),t_crawford_pF_R_Pat(3:13), t_crawford_STS_R_Pat(3:13),t_crawford_FFA_R_Pat(3:13));
t_crawford_all_regions_Pat_cross=cat(3,t_crawford_Broca_Pat([1:2,5,10,13]),t_crawford_Wernicke_Pat([1:2,5,10,13]),t_crawford_VWFA_Pat([1:2,5,10,13]),t_crawford_FFA_L_Pat([1:2,5,10,13]),t_crawford_STS_L_Pat([1:2,5,10,13]),t_crawford_pF_L_Pat([1:2,5,10,13]),t_crawford_LOC_L_Pat([1:2,5,10,13]),t_crawford_PPA_L_Pat([1:2,5,10,13]),t_crawford_TOS_L_Pat([1:2,5,10,13]),t_crawford_TOS_R_Pat([1:2,5,10,13]),t_crawford_PPA_R_Pat([1:2,5,10,13]),t_crawford_LOC_R_Pat([1:2,5,10,13]),t_crawford_pF_R_Pat([1:2,5,10,13]), t_crawford_STS_R_Pat([1:2,5,10,13]),t_crawford_FFA_R_Pat([1:2,5,10,13]));


%% controls t-test

%% controls t-test
for x=1:length(controls)
    t_crawford_FFA_L(x,1)=(FFA_L(x,1)-nanmean(FFA_L(x~=1:length(controls),1)))./ (nanstd(FFA_L(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_FFA_R(x,1)=(FFA_R(x,1)-nanmean(FFA_R(x~=1:length(controls),1)))./ (nanstd(FFA_R(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_STS_L(x,1)=(STS_L(x,1)-nanmean(STS_L(x~=1:length(controls),1)))./ (nanstd(STS_L(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_STS_R(x,1)=(STS_R(x,1)-nanmean(STS_R(x~=1:length(controls),1)))./ (nanstd(STS_R(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_PPA_L(x,1)=(PPA_L(x,1)-nanmean(PPA_L(x~=1:length(controls),1)))./ (nanstd(PPA_L(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_PPA_R(x,1)=(PPA_R(x,1)-nanmean(PPA_R(x~=1:length(controls),1)))./ (nanstd(PPA_R(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_TOS_L(x,1)=(TOS_L(x,1)-nanmean(TOS_L(x~=1:length(controls),1)))./ (nanstd(TOS_L(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_TOS_R(x,1)=(TOS_R(x,1)-nanmean(TOS_R(x~=1:length(controls),1)))./ (nanstd(TOS_R(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_LOC_L(x,1)=(LOC_L(x,1)-nanmean(LOC_L(x~=1:length(controls),1)))./ (nanstd(LOC_L(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_LOC_R(x,1)=(LOC_R(x,1)-nanmean(LOC_R(x~=1:length(controls),1)))./ (nanstd(LOC_R(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_pF_L(x,1) =(pF_L(x,1)-nanmean(pF_L(x~=1:length(controls),1)))./ (nanstd(pF_L(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_pF_R(x,1) =(pF_R(x,1)-nanmean(pF_R(x~=1:length(controls),1)))./ (nanstd(pF_R(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_VWFA(x,1) =(VWFA(x,1)-nanmean(VWFA(x~=1:length(controls),1)))./ (nanstd(VWFA(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_Broca(x,1)=(Broca(x,1)-nanmean(Broca(x~=1:length(controls),1)))./(nanstd(Broca(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_Wernicke(x,1)=(Wernicke(x,1)-nanmean(Wernicke(x~=1:length(controls),1)))./(nanstd(Wernicke(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_STS_L(x,1)=(STS_L(x,1)-nanmean(STS_L(x~=1:length(controls),1)))./ (nanstd(STS_L(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));
    t_crawford_STS_R(x,1)=(STS_R(x,1)-nanmean(STS_R(x~=1:length(controls),1)))./ (nanstd(STS_R(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))));


    %t_crawford_EVC_L(x,1)=(EVC_L(x,1)-nanmean(EVC_L(x~=1:length(controls),1)))./ (nanstd(EVC_L(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))))
    %t_crawford_EVC_R(x,1)=(EVC_R(x,1)-nanmean(EVC_R(x~=1:length(controls),1)))./ (nanstd(EVC_R(x~=1:length(controls),1)*sqrt((length(subjects))/(length(subjects)-1))))
end
t_crawford_all_regions=cat(3, t_crawford_Broca,t_crawford_Wernicke,t_crawford_VWFA,t_crawford_FFA_L,t_crawford_STS_L,t_crawford_pF_L,t_crawford_LOC_L,t_crawford_PPA_L,t_crawford_TOS_L...
    ,t_crawford_TOS_R,t_crawford_PPA_R,t_crawford_LOC_R,t_crawford_pF_R, t_crawford_STS_R,t_crawford_FFA_R);

% for g=1:2
% figure(g)
% if g==1
%     crtical_value=2.069
% else
%     crtical_value=2.064
% end
% for i=1:length(rois_title)
%     subplot(5,4,i)
%     for s=1:length(subjects)
%
%         if and(t_crawford_all_regions(s,g,i)>-crtical_value,t_crawford_all_regions(s,g,i)<crtical_value)
%             scatter(s,t_crawford_all_regions(s,g,i),marker_size,'filled','blue')
%             hold on
%         else
%             scatter(s,t_crawford_all_regions(s,g,i),marker_size,'filled','red')
%             hold on
%         end
%     end
%     xticks(1:25)
%     if g==1
%         xticklabels(controls_name)
%     else
%         xticklabels(subjects)
%     end
%     xtickangle(-45)
%     xt = get(gca, 'XTick');
%     set(gca, 'FontSize', 10)
%     xlim([0 25])
%     ylim([-4 4])
%     yticks([-crtical_value 0 crtical_value])
%     line([0,25],[crtical_value,crtical_value],'color',[0 0 0])
%     line([0,25],[-crtical_value,-crtical_value],'color',[0 0 0])
%     line([0,25],[0,0],'color',[0.6 0.6 0.6])
%
%     ylabel('t score')
%     title (rois_title{i})
% end
% %     if g==1
% %         print(['/Users/liut7/OneDrive - National Institutes of Health/forMarlene_OneDrive/Spatial organization of the visual cortex/matlab_scripts'], '-dtiff')
% %     else
% %         print(['/Users/liut7/OneDrive - National Institutes of Health/forMarlene_OneDrive/Spatial organization of the visual cortex/matlab_scripts'], '-dtiff')
% %     end
% end

%% compare each control to all 24 other controls

rois_title={'IFG','STG','VWFA','lFFA','lSTS','lPF','lLOC','lPPA','lTOS','rTOS','rPPA','rLOC','rPF','rSTS','rFFA'}; %
controls_name={'C01','C02','C03','C04','C05','C06','C07','C08','C09','C10','C11','C12',... %12
    'C13','C14','C15','C16','C17','C18','C19','C20','C21','C22','C23','C24','C25'}  % 21+13=25
marker_size = 50;

FigHandle = figure('Position', [100, 100, 1600, 900]);
crtical_value=2.069 % df = 23 = 25-1-1
for i=1:length(rois_title)
    subplot(5,3,i)
    for s=1:length(subjects)
        if and(t_crawford_all_regions(s,i)>-crtical_value,t_crawford_all_regions(s,i)<crtical_value)
            scatter(s,t_crawford_all_regions(s,i),marker_size,'filled','blue')
            hold on
        else
            scatter(s,t_crawford_all_regions(s,i),marker_size,'filled','red')
            hold on
        end
    end
    xticks(1:25)
    xticklabels(controls_name)
    xtickangle(-45)
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 10)
    xlim([0 26])
    ylim([-3.8 3.8])
    yticks([-crtical_value 0 crtical_value])
    line([0,25],[crtical_value,crtical_value],'color',[0 0 0])
    line([0,25],[-crtical_value,-crtical_value],'color',[0 0 0])
    line([0,25],[0,0],'color',[0.6 0.6 0.6])
    ylabel('t score','FontSize', 12)
    title (rois_title{i},'FontSize', 14)
end
%
%  print(['/Users/liut7/OneDrive - National Institutes of Health/forMarlene_OneDrive/Spatial organization of the visual cortex/matlab_scripts'], '-dtiff')
%
%% for patients
% longitudinal
patients={'TC1','TC2','TC3','UD1','UD2','UD3','UD4','UD5','OT1','OT2','OT3'};
FigHandle = figure('Position', [100, 100, 1800, 900]);

crtical_value=2.064 % df = 24 = 25-1
for i=1:length(rois_title)
    subplot(5,3,i)
    for s=1:length(patients)
        if and(t_crawford_all_regions_Pat_long(s,i)>-crtical_value,t_crawford_all_regions_Pat_long(s,i)<crtical_value)
            scatter(s,t_crawford_all_regions_Pat_long(s,i),marker_size,'filled','black')
            hold on
        else
            scatter(s,t_crawford_all_regions_Pat_long(s,i),marker_size,'filled','red')
            hold on
        end
    end
    xticks(1:11)
    xticklabels(patients)
    xtickangle(0)
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 13)
    set(gca, 'tickdir', 'out');
    xlim([0 12])
    ylim([-3 3.8])
    yticks([-crtical_value 0 crtical_value])
    line([0,12],[crtical_value,crtical_value],'color',[0 0 0])
    line([0,12],[-crtical_value,-crtical_value],'color',[0 0 0])
    line([0,12],[0,0],'color',[0.6 0.6 0.6])
    ylabel('t score','FontSize', 15)
    title (rois_title{i},'FontSize', 16)

end
saveas(gcf,'rsa_crawfordT_patient_long','epsc')

%% for patients cross sectional
patients={'KN','SN','TC','UD','OT'};
FigHandle = figure('Position', [100, 100, 1300, 500]);

crtical_value=2.064 % df = 24 = 25-1
for i=1:length(rois_title)
    subplot(3,5,i)
    for s=1:length(patients)
        if and(t_crawford_all_regions_Pat_cross(s,i)>-crtical_value,t_crawford_all_regions_Pat_cross(s,i)<crtical_value)
            scatter(s,t_crawford_all_regions_Pat_cross(s,i),marker_size,'filled','black')
            hold on
        else
            scatter(s,t_crawford_all_regions_Pat_cross(s,i),marker_size,'filled','red')
            hold on
        end
    end
    xticks(1:5)
    xticklabels(patients)
    %     xtickangle(-45)
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 13)
    set(gca, 'tickdir', 'out');
    xlim([0 6])
    ylim([-3 3.8])
    yticks([-crtical_value 0 crtical_value])
    line([0,6],[crtical_value,crtical_value],'color',[0 0 0])
    line([0,6],[-crtical_value,-crtical_value],'color',[0 0 0])
    line([0,6],[0,0],'color',[0.6 0.6 0.6])
    ylabel('t score','FontSize', 15)
    title (rois_title{i},'FontSize', 16)
end
saveas(gcf,'rsa_crawfordT_patient_crossSec','epsc')
 