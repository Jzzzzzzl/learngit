classdef ValleyG1 < ScatterringProcessForValley & EPWaveVectorModify
    %% Gamma1能谷
    methods
        function obj = ValleyG1(pc)
            %>构造函数
            obj.Eg = pc.EgG1;
            obj.mt = pc.mtG1;
            obj.ml = pc.mlG1;
            obj.alpha = pc.alphaG1;
            obj.centerRatio = pc.centerRatioG1;
            obj.nofScat = pc.nofScatG1;
            obj.maxScatRate = pc.maxScatRateG1;
            obj.xsForimpurity = pc.xsForimpurityG1;
            obj.xsForPolarOptical = pc.xsForPolarOpticalG1;
            
            obj.scatTable = zeros(obj.nofScat, 1);
            obj.md = (obj.mt^2*obj.ml)^(1/3);
            obj.Tz = [sqrt(pc.m / obj.mt)    0   0;
                        0   sqrt(pc.m / obj.mt)  0;
                        0   0   sqrt(pc.m / obj.ml)];
            obj.invTz = inv(obj.Tz);
        end
        
        function updateScatterringRateFormula(obj, es, pc, cc)
            %>更新散射率句柄函数，该能谷所包含的散射类型
            obj.ionizedImpurityScatteringRate(es, pc, cc);
            obj.acousticPiezoelectricScatteringRate(es, pc, cc);
            obj.elasticIntravalleyAcousticScatteringRate(es, pc, cc);
            obj.inelasticPolarOpticalScatteringRate(es, pc, cc);
            obj.inelasticIntervalleyScatteringRate(es, pc, cc);
        end
        
        function [es] = getGeneralElectricWaveVector(obj, es, pc, k)
            %>根据能谷标号旋转电子波矢
            tempk = k + [0, 0,  obj.centerRatio] * pc.dBD;
            es.vector = obj.rotateToGeneralValley(tempk, es.valley);
        end
        
        function [es] = computeEnergyAndGroupVelocity(obj, es, pc)
            %>计算电子能量
            tempk = obj.rotateToStandardValley(es.vector, es.valley);
            k = tempk - [0, 0, obj.centerRatio] * pc.dBD;
            es.gamma = pc.hbar^2*(k(1)^2 / obj.mt + k(2)^2 / obj.mt + k(3)^2 / obj.ml) / 2;
            es.epsilon = (-1 + sqrt(1 + 4*obj.alpha*es.gamma/pc.e)) * pc.e / (2*obj.alpha);
            es.energy = es.epsilon + obj.Eg;
            %>计算电子速度
            kStar = obj.Tz * k';
            vStar = pc.hbar * kStar / (pc.m * (1 + 2*obj.alpha*es.epsilon/pc.e));
            velocity = (obj.invTz * vStar)';
            es.velocity = obj.rotateToGeneralValley(velocity, es.valley);
        end
    end
end