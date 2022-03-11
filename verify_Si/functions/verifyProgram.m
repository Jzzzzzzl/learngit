function [] = verifyProgram(type, bs, pc)
    % 验证
    
    switch type
        case "EnergyToVector"
            num = 200;
            allowedError = 0.001;
            
            for i = 1 : num
                es = ElectricStatus;
                es.vector = [randnumber(0.1,1.0) randnumber(0.1,1.0) randnumber(0.1,1.0)] * pc.dGX;
                es.valley = bs.whichValley(es);
                es = bs.computeInParabolicFactor(es, pc);
                es.energy = bs.computeElectricEnergy(es, pc);
                item = es.energy;
                es = bs.chooseWaveVector(es, pc);
                es = bs.computeInParabolicFactor(es, pc);
                es.energy = bs.computeElectricEnergy(es, pc);
                disp(es.energy / pc.e)
                if abs((es.energy - item)/item) > allowedError
                    error("能量正反验证错误！")
                end
            end
            if i == num
                disp("电子波矢选择与能量计算正反验证无误")
            end
    end
end