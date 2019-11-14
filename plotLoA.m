function plotLoA(LoA_value)
%PLOTLOA Plots horizontal line with own acceptance criteria
% 
%   Alex Bagur, 2019

hold on; 
plot(xlim,[ LoA_value, LoA_value],'g--','LineWidth',2)
plot(xlim,[-LoA_value,-LoA_value],'g--','LineWidth',2)
ax1 = gca;
ax1.Legend.String(end-1:end)=[];
end

