close all
clear all
clc
addpath(genpath(pwd))
[FileName,PathName,FilterIndex] = uigetfile('*.*','iSAM Data');
load([PathName,FileName]);   % File with data stored according to spec provided
DataFolder=PathName;

Xbl=[2.4;-0.1;-2.3; pi; 0; pi/2];
R_b2l=e2R(Xbl(4:6));
T_b2l=Xbl(1:3);
H_b2l=[[R_b2l, T_b2l];...
    0 0 0  1    ];
IdxSet=[1001 1002 1003];
%%
for scanIndex=IdxSet
    %%scanName= spntf('%s\SCANS\Scan%04d.mat',DataFolder,scanIndex);
    eval(['scanName','= sprintf(''','%sSCANS/Scan%04d.mat','''',',DataFolder,scanIndex)']);
    %load the scan
    load(scanName)
    %%eval(['load(scanName',num2str(scanIndex),')']);
    %%eval(['load(scanName)])
    %     eval(['SCAN',num2str(scanIndex),'=SCAN']);
    %     clear SCAN ;
    % load the image
    %     im_name = sprintf('%sIMAGES/Cam%i/image%04d.ppm', DataFolder,i-1,eval(['SCAN.image_index']));
    %     I = imreadbw(im_name);
    %     I = imresize(I, [1232,1616]);
    if scanIndex==IdxSet(1)
        PrevScan=SCAN;
        %         PrevImage=I;
%         vEstimatedPose(:,scanIndex)=PrevScan.X_wv; %% estimated pose for vehicle
%         cEstimatedPose(:,scanIndex)=RelativeTransform(PrevScan.X_wv,zeros(1,6),X_c2b); %% estimated pose for camera
        
        %         CurrentImage=PrevImage;
        %         [PrevFrames,PrevDescriptor] = sift(I(BoxLimY(1):BoxLimY(2),BoxLimX(1):BoxLimX(2)), 'Verbosity', 1) ;
        %         PrevFrames(1,:)=PrevFrames(1,:)+BoxLimX(1);
        %         PrevFrames(2,:)=PrevFrames(2,:)+BoxLimY(1);
        %         CurrentFrames=PrevFrames;
        %         CurrentDescriptor=PrevDescriptor;
        %         PrevPixels = K*SCAN.Cam(i).xyz;
        %         PrevU = PrevPixels(1,:)./PrevPixels(3,:);
        %         PrevV = PrevPixels(2,:)./PrevPixels(3,:);
        %         scatter(PrevU,PrevV, 2);
        %         [neighborIds neighborDistances] = kNearestNeighbors([PrevU;PrevV]', PrevFrames(1:2,:)', kNN_num);
        %     IdxN=neighborDistances<KnnThreshold;
        %        neighborIds(IdxN==0)=[];
        %         Pair=[PrevFrames(1:2,:)',[PrevU(neighborIds);PrevV(neighborIds)]'];
        
        %         neighborIds(neighborDistances>KnnThreshold)=[];
        %         Laser3DPrev=SCAN.Cam(i).xyz(:,neighborIds);
        %         Pair(neighborDistances>KnnThreshold,:)=[];
        %         PrevDescriptor(:,neighborDistances>KnnThreshold)=[];
        %         neighborDistances(neighborDistances>KnnThreshold)=[];
        %         PrePair=Pair;
        %%%%%%%%
        %         LaserData=[PrevU(neighborIds);PrevV(neighborIds)]';
        %                 figure; imshow(I');hold on;scatter(PrePair(:,2),PrePair(:,1),'b');
        %                 scatter(PrePair(:,4),PrePair(:,3),'r');
        %                 for TempIdx=1:size(PrePair,1)
        %                     plot([PrePair(TempIdx,2) PrePair(TempIdx,4)],[PrePair(TempIdx,1) PrePair(TempIdx,3)],'g')
        %                     hold on
        %                 end
        %         figure; imshow(I');hold on;
        %         figure;hold on;
        %         for ttt=1:10:100
        %             plot([Pair(ttt,1) Pair(ttt,3)],[Pair(ttt,2) Pair(ttt,4)],'ob')
        %
        %             plot([Pair(ttt,1) Pair(ttt,3)],[Pair(ttt,2) Pair(ttt,4)],'r')
        %
        %         end
        %%%%%%%%
        %         PrevFrames(:,neighborIds)
        %         [neighborIds neighborDistances] = kNearestNeighbors([CurrentU;CurrentV], CurrentFrames(1:2), k);
    else
        PrevScan=CurrentScan;
        %         PrevImage=CurrentImage;
        %         PrevDescriptor=CurrentDescriptor;
        %         PrevU=CurrentU;
        %         PrevV=CurrentV;
        %         PrePair=CurrentPair;
        %         Laser3DPrev=Laser3DCurrent;
    end
    CurrentScan=SCAN;
    GroundTruth(:,scanIndex)=CurrentScan.X_wv;
    %     CurrentImage=I;
    %     [CurrentFrames,CurrentDescriptor] = sift(CurrentImage(BoxLimY(1):BoxLimY(2),BoxLimX(1):BoxLimX(2)), 'Verbosity', 1) ;
    %     CurrentFrames(1,:)=CurrentFrames(1,:)+BoxLimX(1);
    %     CurrentFrames(2,:)=CurrentFrames(2,:)+BoxLimY(1);
    %     CurrentPixels = K*SCAN.Cam(i).xyz;
    
    
    %     CurrentU = CurrentPixels(1,:)./CurrentPixels(3,:);
    %     CurrentV = CurrentPixels(2,:)./CurrentPixels(3,:);
    %         scatter(PrevU,PrevV, 2);
    %     [neighborIds neighborDistances] = kNearestNeighbors([CurrentU;CurrentV]', CurrentFrames(1:2,:)', kNN_num);
    %     Pair=[CurrentFrames(1:2,:)',[CurrentU(neighborIds);CurrentV(neighborIds)]'];
    %     neighborIds(neighborDistances>KnnThreshold)=[];
    %     Laser3DCurrent=SCAN.Cam(i).xyz(:,neighborIds);
    clear SCAN;
    %     Pair(neighborDistances>KnnThreshold,:)=[];
    %     CurrentDescriptor(:,neighborDistances>KnnThreshold)=[];
    %     neighborDistances(neighborDistances>KnnThreshold)=[];
    %     CurrentPair=Pair;
    %     CrntLasCamPair=
    
    %% SIFT matching
    %     matches = siftmatch(CurrentDescriptor, PrevDescriptor) ;
    
    %% 3D matching based on the 2d correspondences
    % Ya=Laser3DPrev;
    % Yb=Laser3DCurrent;
    % Sa= PrePair(:,1:2);
    % Sb= CurrentPair(:,1:2);
    
    options.DistanceThreshold=0.5;
    options.MaxIteration=20;
    %     options.matches=matches;
    
    %      [R,T,error,BestFit]=ICP_RANSAC(Ya,Yb,Sa,Sb,matches,options);
    %      [R, T] = icp(Laser3DPrev,Laser3DCurrent);
    %      [R, T,EE] = icp(PrevScan.Cam(2).xyz,CurrentScan.Cam(2).xyz,TempK);
    % [TR, TT, ER] = icp(q,p,k)
    
    SCAN1=PrevScan.Cam(2).xyz;
SCAN2=CurrentScan.Cam(2).xyz;
for i=1:length(PrevScan.Cam(2).xyz)
    depth1(i)=norm(PrevScan.Cam(2).xyz(:,i));
end
for i=1:length(CurrentScan.Cam(2).xyz)
    depth2(i)=norm(CurrentScan.Cam(2).xyz(:,i));
end
reduc1=SCAN1(:,depth1<15);
reduc2=SCAN2(:,depth2<15);
[R, T] = icp(reduc1 ,reduc2,20);
    
    
    Results(scanIndex).Rot=R;
    Results(scanIndex).Trans=T;
    Results(scanIndex).Idx=scanIndex;
    %     [R, T] = icp(Ya,Yb);
    %% SIFT Matching plot
    % I2=PrevImage;
    % I1=CurrentImage;
    % P2=PrePair;
    % P1=CurrentPair;
    close all
    % for tt=1:min(14,round(size(matches,2)/10))
    %
    % figure
    % IndexMatches=tt:round(size(matches,2)/10):size(matches,2);
    % MY_MATCHES=matches(:,IndexMatches);
    % plotmatches(I1,I2,P1',P2',MY_MATCHES)
    % title('Matching Test')
    % end
    %% plot the 3d data
    % Yb0=R*Yb;
    % Yb0=[Yb0(1,:)+T(1);Yb0(2,:)+T(2);Yb0(3,:)+T(3)];
    figure
    hold on
    % for k=1:length(matches)
    %     try
    % scatter3(Yb0(1,matches(1,k)),Yb0(2,matches(1,k)),Yb0(3,matches(1,k)),'b');
    % scatter3(Ya(1,matches(2,k)),Ya(2,matches(2,k)),Ya(3,matches(2,k)),'r');
    %     plot3([Yb0(1,matches(1,k)),Ya(1,matches(2,k))],...
    %           [Yb0(2,matches(1,k)),Ya(2,matches(2,k))],...
    %           [Yb0(3,matches(1,k)),Ya(3,matches(2,k))],'Color',[0 1 1]);
    %     catch
    %         display('an error has been occured');
    %     end
    % end
    % title(['3d Matching from frame ',num2str(scanIndex),' to frame', num2str(scanIndex-1),' Ransac Matches = ',num2str(BestFit)])
    %% Compare with ground truth
    if scanIndex~=IdxSet(1)
        %%%% Transforming the (R,T) from laser coordinate to base
        %%%% coordinate
        dX = [T;R2e(R)]; %% expressed in camera frame
        dY = H_b2l*[R,T;0 0 0 1]*inv(H_b2l);
        dY_true = inv(Pose2H(GroundTruth(:,scanIndex-1)))*Pose2H(GroundTruth(:,scanIndex));
        Error(:,scanIndex)= dY_true -dY;
        
        %     cEstimatedPose(:,scanIndex)=RelativeTransform(cEstimatedPose(:,scanIndex-1),dX,zeros(1,6)); %% estimated pose for camera
        %     vEstimatedPose(:,scanIndex)=RelativeTransform(cEstimatedPose(:,scanIndex-1),dX,X_b2c); %% estimated pose for camera
        %     temp=RelativeTransform(cEstimatedPose(:,scanIndex),zeros(6,1),X_b2c);
        
        %         XS=RelativeTransform(XB,dX,XS2B); %% XS is in the base frame( attached to the vehicle)
        
    end
    %%% Computing the error
    % Error(:,scanIndex)=GroundTruth(:,scanIndex)-vEstimatedPose(:,scanIndex);
    
    %% Find Correspondence between image and lidar data in both frames
    %%project_3D_pointcloud_to_images(DataFolder, scanIndex)
    %     q=CurrentPair()
    %     p=PrePair()
    %     [TR, TT, ER, t] = icp(CurrentPair,PrePair);
    
    
    
    
end
clear im_name



%Loop over all 5 camera images
%%% for i = 1:5
%get the image


%%% end


%%

[R, T] = icp(PrevScan.XYZ ,CurrentScan.XYZ);
[R, T] = icp(PrevScan.Cam(2).xyz ,CurrentScan.Cam(2).xyz,2);


Xbl=[2.4;-0.1;-2.3; pi; 0; pi/2];
R_b2l=e2R(Xbl(4:6));
T_b2l=Xbl(1:3);
H_b2l=[[R_b2l, T_b2l];...
    0 0 0  1    ];

SCAN1=PrevScan.Cam(2).xyz;
SCAN2=CurrentScan.Cam(2).xyz;
for i=1:length(PrevScan.Cam(2).xyz)
    depth1(i)=norm(PrevScan.Cam(2).xyz(:,i));
end
for i=1:length(CurrentScan.Cam(2).xyz)
    depth2(i)=norm(CurrentScan.Cam(2).xyz(:,i));
end
reduc1=SCAN1(:,depth1<15);
reduc2=SCAN2(:,depth2<15);
[R, T] = icp(reduc1 ,reduc2,20);