% Create data and plot Bland-Altman with some acceptance criteria
clear; clc; close all

rng('default')

gt = [rand(1,50)+2 rand(1,50)+3];   % ground truth measurement
m1 = gt + 0.3*rand(1,100);          % method 1 measurement
m2 = gt + 0.3*rand(1,100);          % method 2 measurement

grp = [ones(1,50) 2*ones(1,50)];

figure
plotBlandAltman(m1,m2,'rk',grp,{'object 1','object 2'});
plotLoA(0.5)
ylim([-2 2])