%% 

clc,clear
close all
addpath(genpath(pwd))


pc = PhysicConstants("Si");
cc = ConfigureConstants("1D");
sc = ScatterringCurve("Si", pc);
bs = BandStructure("Si");
sr = ScatterringRateTable("Si", pc, cc);

ps = PhononStatus;
es = ElectricStatus;

es = es.InitializeStatus(bs, pc);
disp(es.valley)
es.valley = 22;
disp(es.valley)
% es = bs.ChooseWaveVector(es, pc);

% es.energy = 1.2 * pc.e;

% sr = sr.ScatterringTable(es, sc, pc, cc);
% sr.ScatterringRatePlot(sc, pc, cc);




% VerifyProgram("EnergyToVector", bs, pc);

% es = es.ComputeInParabolicFactor(pc);
% es.energy = bs.ComputeElectricEnergy(es, pc);
% es.velocity = bs.ComputeElectricVelocity(es, pc);
% % es.valley = es.RandomValley("i");
% % disp(es)


% bs.BandStructurePlot(50, pc);
% bs.ElectricVelocityPlot(50, pc);





