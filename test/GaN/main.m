%% 材料计算主程序
rmpath(genpath('/home/jiang/eMonteCarlo'))
addpath(genpath('./BasicClasses'))
addpath(genpath('./functions/'))
addpath(genpath('./MEX/'))
addpath(genpath('./OperatorTerms/'))
addpath(genpath('./ParallelCompute/MaterialParallelCompute'))
addpath(genpath('./Material_GaN/'))
addpath(genpath('./test/GaN'))
%% 初始化计算对象
clc,clear
close all
pc = PhysicConstantsGaN;
cc = ConfigureConstantsGaN(pc);
sc = ScatteringCurveGaN(cc, pc);
% 采用shengBTE的数据,若不采用则注释该行
sc.getBandDataFromOther(cc);

dv = DecideValleyKind(cc, pc, sc);
sh = SimulationHistory(dv, pc, cc);
eq = ElectricQuantityStaticsGaN;
pq = PhononQuantityStatics(cc);
%% 开始计算
verifyProgram('verifyConfigureSettings', dv, pc, sc, cc)
parallelCompute(sh, dv, sc, pc, cc);
%% Hard读取仅用于观察电子轨迹图
eq.minTime = 0e-12;
eq.maxTime = 40e-12;
eq.extractElectricHistoryHard(cc, 300, 1);
% 电子轨迹图
eq.plotElectronTrace(cc, 15, 'k')
eq.plotElectronTrace(cc, 17, 'e')
eq.plotElectronTrace(cc, 1, 'r')
%% Soft读取仅用于计算电子性质
eq.minTime = 0e-12;
eq.maxTime = 40e-12;
eq.maxEnergy = 6*cc.e;
eq.extractElectricHistorySoft(cc, 1000);
% 材料性质
eq.computeDirftVelocityWithTimeSoft(cc)
eq.computeDriftVwithEFieldSoft(cc)
eq.computeValleyOccupationWithTime(cc)
eq.computeValleyOccupationWithElectricField(cc)
eq.plotGeneralPropertiesSoft(cc);
% 电子散射类型统计
eq.statisticsScatteringTypeDistribution(cc, 'U');
eq.statisticsScatteringTypeDistribution(cc, 'G1');
eq.statisticsScatteringTypeDistribution(cc, 'G3');
%% 读取声子历史信息
pq.minTime = 0e-12;
pq.maxTime = 40e-12;
pq.parallelPhononDistribution(cc);
%% 电声散射结果验证
% 验证1，能带画图
dv.valley.bandStructurePlot(pc, pc.hsp.G, pc.hsp.K);
dv.valley.electricVelocityPlot(pc, pc.hsp.G, pc.hsp.K);
% 验证2，散射表画图
tic; dv.valley.scatteringRatePlot(sc, pc, cc, [1, 20]); toc
% 验证3，验证函数
verifyProgram('EnergyToVector', dv, pc, sc, cc);
verifyProgram('AcousticPiezoelectricScatPlot', dv, pc, sc, cc);
verifyProgram('ValleyStructureOfValleyU', dv, pc, sc, cc);
verifyProgram('ValleyStructureOfValleyGamma', dv, pc, sc, cc);
verifyProgram('youshifangxiangdianchang', dv, pc, sc, cc);
% 验证4，声子发射谱
pq.plotSpectrum(pc, cc, 'LO', [0, 1e9, 0, 1e9])
pq.plotSpectrum(pc, cc, 'ALL', [0, 1e9, 0, 1e9])

%% 散射率导出
sa = zeros(1001, 7);
temp = dv.valleyG3.interScatable';
sa(:, 1) = dv.valleyG3.energyFace;
sa(:, 2) = temp(:, 1);
sa(:, 3) = temp(:, 2);
sa(:, 4) = temp(:, 3);
sa(:, 5) = temp(:, 5);
sa(:, 6) = temp(:, 7);
sa(:, 7) = temp(:, 9);
sa(:, 8) = temp(:, 10);


%% 单电子轨迹图导出
tempk = zeros(10000, 3);
for i = 1 : 10000
    tempk(i, :) = eq.vectors(:, :, 1, i);
end




