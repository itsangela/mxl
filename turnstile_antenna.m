%% Modeling Turnstile Antenna

%% Antenna Parameters
freq    = 437e6;
lambda  = 3e8/freq;
offset  = lambda/50;
spacing = lambda/2;
length  = lambda/2.1;
width   = lambda/50;
anglevar= 0:10:180;
freqrange = 200e6:2e6:400e6;
gndspacing = lambda/4;

%% Model Antenna
d  = dipole('Length',length,'Width',width);
turnstile = dipoleCrossed('Element',d,'Tilt',90,'TiltAxis',[0 1 0]);