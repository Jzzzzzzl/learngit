%% 二维模型主程序
rmpath(genpath('/home/jiang/eMonteCarlo/'))
addpath(genpath('./BasicClasses/'))
addpath(genpath('./functions/'))
addpath(genpath('./MEX/'))
addpath(genpath('./OperatorTerms/'))
addpath(genpath('./ParallelCompute/DeviceParallelCompute/'))
addpath(genpath('./Material_Si/'))
addpath(genpath('./1D_Si/'))
%% 
clc,clear
close all
pc = PhysicConstantsSi;
cc = ConfigureConstantsSi(pc);
sc = ScatteringCurveSi(cc, pc);

sc.getBandDataFromOther(cc);

dv = DecideValleyKind(cc, pc, sc);
sh = SimulationHistory(dv, pc, cc);
pq = PhononQuantityStatics(cc);
%%
verifyProgram('verifyConfigureSettings', dv, pc, sc, cc)
%% 
parallelCompute(sh, dv, sc, pc, cc);
eq = ElectricQuantityStaticsSi(cc);

eq.computeAverageEnergyWithPosition(cc);
eq.aveEPos.plotField(cc, 'n')
%%
pq.minTime = 0e-12;
pq.maxTime = 100e-12;
pq.parallelPhononDistribution(cc);
%%
pq.initializeVariables(cc);
pq.computeHeatGenerationRate(pc, cc, sc);
pq.solveFarDistributionFunction(cc, sc);

pq.plotFullFrequencyPeoperties(pq.Q, cc)
pq.plotFullFrequencyPeoperties(pq.nDot, cc)
pq.plotFullFrequencyPeoperties(pq.n, cc)
%% 
pq.computeTF(cc, sc, pc)
pq.computeTeff(cc, pc, sc, 1)
pq.computeTeff(cc, pc, sc, 2)
pq.computeTeff(cc, pc, sc, 3)
pq.computeTeff(cc, pc, sc, 4)
pq.computeTeff(cc, pc, sc, 5)

pq.TF.plotField(cc)
pq.pTeff.LA.plotField(cc)
pq.pTeff.TA.plotField(cc)
pq.pTeff.LO.plotField(cc)
pq.pTeff.TO.plotField(cc)
pq.Teff.plotField(cc)
legend("TF", "LATeff", "TATeff", "LOTeff", "TOTeff", "Teff")
%% 
eq.plotElectronTrace(cc, 2, 'k')
eq.plotElectronTrace(cc, 8, 'r')
eq.plotElectronTrace(cc, 1, 'e')
eq.plotElectronTrace(cc, 0, 'd')
eq.plotElectronTrace(cc, 6, 'xy')
%%
pq.plotSpectrum(pc, cc, 'LA', [170, 172, 0.1, 99.9])
pq.plotSpectrum(pc, cc, 'TA', [170, 172, 0.1, 99.9])
pq.plotSpectrum(pc, cc, 'LO', [170, 172, 0.1, 99.9])
pq.plotSpectrum(pc, cc, 'TO', [170, 172, 0.1, 99.9])
pq.plotSpectrum(pc, cc, 'ALL', [0.1, 320, 0.1, 99.9])

eq.statisticsScatteringTypeDistribution(cc)
%%
cc.dopDensity.plotField(cc, 'n')
cc.eleConc.plotField(cc, 'n')
cc.xField.plotField(cc, 'n')
cc.yField.plotField(cc, 'n')
cc.xyField.plotField(cc, 'n')
%% 
writeDataToFile('aveEtime', cc, eq.aveEtime)
writeDataToFile('currrent', cc, eq.current)
writeDataToFile('occupyRate', cc, eq.occupyRate)
writeDataToFile('xEfield', cc, cc.modelx.point*1e9, cc.xFieldCopy.data(2:end-1, 2))
%% 
nDot = repmat(pq.polar, cc.NW, 1);
for k = 1 : cc.NW
    nDot(k).LA = pq.nDot(k).LA.data(:, 2);
    nDot(k).TA = pq.nDot(k).TA.data(:, 2);
    nDot(k).LO = pq.nDot(k).LO.data(:, 2);
    nDot(k).TO = pq.nDot(k).TO.data(:, 2);
end











