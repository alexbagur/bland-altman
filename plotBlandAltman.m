function [meanValues,diffValues,nDataPoints,naninds] = plotBlandAltman(vec1,vec2,markerclr,grp,leg)
%PLOTBLANDALTMAN Creates a Bland-Altman plot using gscatter
%   plotBlandAltman(VEC1,VEC2) creates a Bland-Altman plot from vectors
%   VEC1 and VEC2, where xdata is the mean of VEC1 and VEC2, and ydata is
%   the difference VEC1-VEC2
%   
%   plotBlandAltman(VEC1,VEC2,MARKERCLR) uses the marker color MARKERCLR
% 
%   plotBlandAltman(VEC1,VEC2,MARKERCLR,GRP) groups the data into the
%   groups in the grouping variable GRP, which must have the same length as
%   VEC1 and VEC2
%   
%   plotBlandAltman(VEC1,VEC2,MARKERCLR,GRP,LEG) uses cell array LEG to use
%   as the legend of the plot
% 
%   Alex Bagur, 2019

arguments
    vec1
    vec2
    markerclr = 'k'
    grp = ones(numel(vec1),1)
    leg = {}
end 

set(0,'defaultAxesFontSize',15)

if ~isequal(length(vec1),length(vec2))
    error('VEC1 and VEC2 must have the same length')
end

% make row vectors
if ~isrow(vec1); vec1=vec1'; end
if ~isrow(vec2); vec2=vec2'; end

meanValues = mean(cat(1,vec1,vec2));
diffValues = vec1-vec2;

naninds = isnan(meanValues);
meanValues(naninds) = [];
diffValues(naninds) = [];

nDataPoints = numel(meanValues); % n after nan values have been removed
mean_diff   = mean(diffValues);
std_diff    = std(diffValues);

grp(naninds) = [];

minVpl = min(meanValues)-0.2*min(meanValues);
maxVpl = max(meanValues)+0.2*max(meanValues);
rangpl = minVpl:maxVpl;
numVpl = numel(rangpl);

gscatter(meanValues,diffValues,grp,markerclr,'.',20); hold on; grid on;
plot(rangpl,ones(1,numVpl)*mean_diff,'k-','LineWidth',1); % mean
plot(rangpl,ones(1,numVpl)*mean_diff+1.96*std_diff,'k--','LineWidth',1); % std
plot(rangpl,ones(1,numVpl)*mean_diff-1.96*std_diff,'k--','LineWidth',1);

% 95% confidence intervals of limits of agremeent (LoA)
% https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4470095/#__sec5title
se = sqrt(3*std_diff.^2/nDataPoints);   % standard error
alpha=0.05;                             % significance level
tcrit2 = tinv(1-alpha/2,nDataPoints-1); % two tails
interv1 = se*tcrit2;
v = [rangpl(1)  mean_diff-1.96*std_diff-interv1; rangpl(1)   mean_diff-1.96*std_diff+interv1; ...
    rangpl(end) mean_diff-1.96*std_diff-interv1; rangpl(end) mean_diff-1.96*std_diff+interv1];
f = [1 2 4 3]; p1=patch('Faces',f,'Vertices',v,'FaceColor','green','EdgeColor','none');
p1.FaceVertexAlphaData = 0.01; p1.FaceAlpha = 'flat';
v = [rangpl(1)  mean_diff+1.96*std_diff-interv1; rangpl(1)   mean_diff+1.96*std_diff+interv1; ...
    rangpl(end) mean_diff+1.96*std_diff-interv1; rangpl(end) mean_diff+1.96*std_diff+interv1];
f = [1 2 4 3]; p2=patch('Faces',f,'Vertices',v,'FaceColor','green','EdgeColor','none');
p2.FaceVertexAlphaData = 0.01; p2.FaceAlpha = 'flat';

if isempty(leg)
    for ii=1:numel(find(diff(sort(grp))))+1
        leg{end+1} = ['data ' num2str(ii)];
    end
end
leg{end+1} = ['bias = ' num2str(round(mean(diffValues),3))];
leg{end+1} = ['CI 95% = bias +/- ' num2str(round(1.96*std(diffValues),3))];
legend(leg,'Location','best','Interpreter','none')
title('Bland-Altman')

end

