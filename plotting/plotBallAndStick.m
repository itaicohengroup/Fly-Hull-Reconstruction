%--------------------------------------------------------------------------
% function to generate ball and stick plot for showing wing kinematics
%
%   INPUTS:
%       -ballAndStickStruct = data structure generated by
%        "getBallAndStickData.m" containing relevant info
%       -plotColorMat = Nx3 matrix containing colors for each wingstroke
%        to plot
%--------------------------------------------------------------------------
function h_bas = plotBallAndStick(ballAndStickStruct, plotColorMat)
% --------------------
%% params and inputs
% --------------------
if ~exist('plotColorMat','var') || isempty(plotColorMat)
    plotColorMat = zeros(length(ballAndStickStruct),3) ;
end

stroke_types = {'back', 'fwd'} ;
% --------------
% plot params
xlim = [-ballAndStickStruct(1).span, ballAndStickStruct(1).span] ;
ylim = [-0.5, 1.75] ;

figPosition = [986,   558,   186,   148] ;
mSize = 2.5 ;
lw = 0.75 ;

faceColorBack = [1 1 1] ; % faceColorFwd and edge color are determined by input

% ------------------------------
%% make plot
h_bas = figure('PaperPositionMode','auto','Position',figPosition) ;

% ---------------------------
% initialize subplot axes
ax_back = subplot(2,1,1) ; % subplot for back stroke
ax_fwd = subplot(2,1,2) ; % subplot for fwd stroke
hold(ax_back, 'on') ; hold(ax_fwd, 'on') ;
ax_array = [ax_back; ax_fwd] ;
% ---------------------------------------------
% loop through different wingstrokes to plot
for i = 1:length(ballAndStickStruct)
    % -----------------
    % color info
    edgeColor = plotColorMat(i,:) ;
    faceColorFwd = plotColorMat(i,:) ;
    
    color_cell = {faceColorBack, faceColorFwd} ;
    
    % ----------------------------------
    % loop over back and forward stroke
    for j = 1:length(stroke_types)
        stroke_type_curr = stroke_types{j} ;
        
        % get ball and stick data
        ball_x = ballAndStickStruct(i).(['ball_x_' stroke_type_curr]) ;
        ball_y = ballAndStickStruct(i).(['ball_y_' stroke_type_curr]) ;
        stick_x = ballAndStickStruct(i).(['stick_x_' stroke_type_curr]) ;
        stick_y = ballAndStickStruct(i).(['stick_y_' stroke_type_curr]) ;
        
        faceColor = color_cell{j} ;
        % sticks
        for k = 1:length(ball_x)
            plot(ax_array(j),[ball_x(k) (ball_x(k) - stick_x(k))], ...
                [ball_y(k) (ball_y(k) - stick_y(k))],'-',...
                'Color',edgeColor, 'lineWidth', lw)
        end
        % back stroke -- balls
        plot(ax_array(j), ball_x, ball_y,'o','MarkerFaceColor',faceColor,...
            'MarkerEdgeColor', edgeColor, 'lineWidth', lw, ...
            'MarkerSize', mSize)
    end
end

% ---------------------------------------
% set axis properties
for p = 1:length(ax_array)
    hold(ax_array(p), 'off') ; %turn off hold
    axis(ax_array(p), 'equal') ; % set equal axis sizing
    set(ax_array(p),'xlim',xlim,'ylim',ylim) % axis limits
    axis(ax_array(p), 'off') ; % turn off axes
end

end