classdef ValleyGX < ScatterringProcessForValley & EPWaveVectorModify
    %% GammaX能谷
    methods
        function obj = ValleyGX(cc, pc, sc)
            %>构造函数
            obj.Eg = pc.EgGX;
            obj.mt = pc.mtGX;
            obj.ml = pc.mlGX;
            obj.alpha = pc.alphaGX;
            obj.centerRatio = pc.centerRatioGX;
            obj.nofScat = pc.nofScatGX;
            obj.maxScatRate = pc.maxScatRateGX;
            obj.xsForimpurity = pc.xsForimpurityGX;
            
            obj.scatTable = zeros(obj.nofScat, 1);
            obj.md = (obj.mt^2*obj.ml)^(1/3);
            obj.Tz = [sqrt(pc.m / obj.mt)    0   0;
                        0   sqrt(pc.m / obj.mt)  0;
                        0   0   sqrt(pc.m / obj.ml)];
            obj.invTz = inv(obj.Tz);
            
            obj.energyFace = cc.energy.face/pc.e;
            obj.buildInterpolationScatalbe(cc, pc, sc);
        end
        
        function updateScatterringRateFormula(obj, es, pc)
            %>更新散射率句柄函数，该能谷所包含的散射类型
            obj.ionizedImpurityScatteringRate(es, pc);
            obj.inelasticIntravalleyAcousticScatteringRate(es, pc);
            obj.inelasticIntervalleyScatteringRate(es, pc);
        end
        
        function [es] = getGeneralElectricWaveVector(obj, es, pc, k)
            %>根据能谷标号旋转电子波矢
            tempk = k + [0, 0,  obj.centerRatio] * pc.dBD;
            es.vector = obj.rotateToGeneralValley(tempk, es.valley);
            es = obj.computeEnergyAndGroupVelocity(es, pc);
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
    
    methods
        bandStructurePlot(obj, pc, pointA, pointB)
        buildInterpolationScatalbe(obj, cc, pc, sc)
        electricVelocityPlot(obj, pc, pointA, pointB)
        [es, ps] = scatteringProcess(obj, dv, es, ps, sc, pc)
        scatteringRatePlot(obj, sc, pc, cc, mn)
        scatteringTable(obj, es, sc, pc)
    end
    
    methods(Static)
        [vector2] = rotateToGeneralValley(vector1, valley)
        [vector2] = rotateToStandardValley(vector1, valley)
    end
end