function features_info = disp_stat_feature(features_info,filter)


% debugInnov = features_info(index_in_info(match_idx(1,i))).z - features_info(index_in_info(match_idx(1,i))).h' ;
% if isempty(MaxInnov)
%     MaxInnov = max(debugInnov);
% else
%     MaxInnov = max(MaxInnov,max(debugInnov));
% end
x_k_k = get_x_k_k(filter);
x_features = x_k_k(14:end);
for i=1:length(features_info)
    
    if ~isempty(features_info(i).h)
        
        if strcmp(features_info(i).type, 'cartesian')
            y = x_features(1:3);
            x_features = x_features(4:end);
            disp_txt = 'C';
            %%% TAMADD: modified jacobian calculation
            %             features_info(i).H = sparse(calculate_Hi_cartesian_my_version( x_v, y, cam, i, features_info ));
            %             features_info(i).H = sparse(calculate_Hi_cartesian_my_code( x_v, y, cam, i, features_info ));
            %%%
        else
            y1 = x_features(1:6);
            y = inversedepth2cartesian( y1 );
            x_features = x_features(7:end);
            disp_txt = 'I';
            %%% TAMADD: modified jacobian calculation
            %             features_info(i).H = sparse(calculate_Hi_inverse_depth_my_version( x_v, y, cam, i, features_info ));
            %             features_info(i).H = sparse(calculate_Hi_inverse_depth_my_code( x_v, y, cam, i, features_info ));
            %%%
        end
        
        if features_info(i).individually_compatible
            innovation = [features_info(i).z(1)-features_info(i).h(1),...
                features_info(i).z(2)-features_info(i).h(2)  ];
            disp_txt = [disp_txt,'F ',num2str(i), ' (',num2str(features_info(i).z(1)),',',...
                num2str(features_info(i).z(2)),')', ' | innov = ',num2str(innovation(1)), ' ',num2str(innovation(2)),...
                ' | TM = ',num2str(features_info(i).times_measured),...
                ' | TP = ',num2str(features_info(i).times_predicted),...
                ' | IF = ',num2str(features_info(i).init_frame),...
                ' | 3D = ',num2str(y(1)),' ',num2str(y(2)),' ',num2str(y(3)),...
                ' | US = ',num2str(features_info(i).used )];

        else
            disp_txt = [disp_txt,'F ',num2str(i), ' (',num2str(features_info(i).h(1)),',',...
                num2str(features_info(i).h(2)),')', ...
                ' | TM = ',num2str(features_info(i).times_measured),...
                ' | TP = ',num2str(features_info(i).times_predicted),...
                ' | IF = ',num2str(features_info(i).init_frame),...
                ' | 3D = ',num2str(y(1)),' ',num2str(y(2)),' ',num2str(y(3)),...
                ' | US = ',num2str(features_info(i).used  )];
        end

        %       'Text'                 - default: black
        %       'Keywords'             - default: blue
        %       'Comments'             - default: green
        %       'Strings'              - default: purple
        %       'UnterminatedStrings'  - default: dark red
        %       'SystemCommands'       - default: orange
        %       'Errors'               - default: light red
        %       'Hyperlinks'           - default: underlined blue
        %
        %       'Black','Cyan','Magenta','Blue','Green','Red','Yellow','White'
        if features_info(i).individually_compatible
            if  features_info(i).low_innovation_inlier
                cprintf('UnterminatedStrings',[disp_txt,'\n'])
                features_info(i).used = features_info(i).used + 1 ; 
            end
            if  features_info(i).high_innovation_inlier
                cprintf('SystemCommands',[disp_txt,'\n'])
                features_info(i).used = features_info(i).used + 1 ; 
            end
            if ~features_info(i).high_innovation_inlier && ~features_info(i).low_innovation_inlier
                cprintf('Strings',[disp_txt,'\n'])
            end
        else
            cprintf('Keywords',[disp_txt,'\n'])
        end
    else
        if strcmp(features_info(i).type, 'cartesian')
            x_features = x_features(4:end);
        end
        if strcmp(features_info(i).type, 'inversedepth')
            x_features = x_features(7:end);
        end
    end
end


% features_info(new_position).patch_when_initialized =...
%     im_k(uv(2,1)-half_patch_size_when_initialized:uv(2,1)+half_patch_size_when_initialized,...
%     uv(1,1)-half_patch_size_when_initialized:uv(1,1)+half_patch_size_when_initialized);
% features_info(new_position).patch_when_matching = zeros( 2*half_patch_size_when_matching+1, 2*half_patch_size_when_matching+1 );
% features_info(new_position).r_wc_when_initialized=X_RES(1:3);
% features_info(new_position).R_wc_when_initialized=q2r(X_RES(4:7));
% features_info(new_position).uv_when_initialized=uv';
% features_info(new_position).half_patch_size_when_initialized=half_patch_size_when_initialized;
% features_info(new_position).half_patch_size_when_matching=half_patch_size_when_matching;
% features_info(new_position).times_predicted=0;
% features_info(new_position).times_measured=0;
% features_info(new_position).init_frame = step;
% features_info(new_position).init_measurement = uv;
% features_info(new_position).type = 'inversedepth';
% features_info(new_position).yi = newFeature;
% features_info(new_position).individually_compatible = 0;
% features_info(new_position).low_innovation_inlier = 0;
% features_info(new_position).high_innovation_inlier = 0;
% features_info(new_position).z = [];
% features_info(new_position).h = [];
% features_info(new_position).H = [];
% features_info(new_position).S = [];
% features_info(new_position).state_size = 6;
% features_info(new_position).measurement_size = 2;
% features_info(new_position).R = eye(features_info(new_position).measurement_size);
% features_info(new_position).Feature3d_in_code_coordinate = Feature3d_in_code_coordinate;
% features_info(new_position).last_visible = step;