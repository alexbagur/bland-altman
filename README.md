# bland-altman
Creates Bland-Altman plot from paired data

**Reference**:
*Giavarina, Davide. "Understanding bland altman analysis." Biochemia medica: Biochemia medica 25.2 (2015): 141-151.* doi: [10.11613/BM.2015.015](https://dx.doi.org/10.11613%2FBM.2015.015)

**Example**

```
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
```

![img](readme-img.png)