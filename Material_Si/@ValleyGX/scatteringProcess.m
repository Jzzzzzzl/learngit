function [es, ps] = scatteringProcess(obj, dv, es, ps, sc, pc)
    %>针对不同散射类型计算电子声子散射过程
    ps.time = es.time;
    vectorTemp = es.vector;
    ps.position = es.position;
    switch es.scatype
        case 1 % ionized-impurity
            k = obj.chooseStandardVectorForElasticScattering(es, pc, 'i');
            es = obj.getGeneralElectricWaveVector(es, pc, k);
        case 2 % intra_ab_LA
            ps.aborem = 0;
            ps.polar = 1;
            k = obj.chooseStandardVectorForInelasticScattering(es, pc, 'a', polyval(sc.band.LA, obj.qAB), 1);
            es = obj.getGeneralElectricWaveVector(es, pc, k);
        case 3 % intra_ab_TA
            ps.aborem = 0;
            ps.polar = 2;
            k = obj.chooseStandardVectorForInelasticScattering(es, pc, 'a', polyval(sc.band.TA, obj.qAB), 1);
            es = obj.getGeneralElectricWaveVector(es, pc, k);
        case 4 % inter_f_ab_LA
            ps.aborem = 0;
            ps.polar = 1;
            es.valley = randomValley(es, 'f');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wf.LA, 1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 5 % inter_f_ab_TA
            ps.aborem = 0;
            ps.polar = 2;
            es.valley = randomValley(es, 'f');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wf.TA, 1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 6 % inter_f_ab_TO
            ps.aborem = 0;
            ps.polar = 4;
            es.valley = randomValley(es, 'f');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wf.TO, 1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 7 % inter_g_ab_LA
            ps.aborem = 0;
            ps.polar = 1;
            es.valley = randomValley(es, 'g');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wg.LA, 1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 8 % inter_g_ab_TA
            ps.aborem = 0;
            ps.polar = 2;
            es.valley = randomValley(es, 'g');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wg.TA, 1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 9 % inter_g_ab_LO
            ps.aborem = 0;
            ps.polar = 3;
            es.valley = randomValley(es, 'g');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wg.LO, 1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 10 % intra_em_LA
            ps.aborem = 1;
            ps.polar = 1;
            while polyval(sc.band.LA, obj.qEM)*pc.hbar >= es.energy
                obj.qEM = obj.qEM * 0.8;
            end
            k = obj.chooseStandardVectorForInelasticScattering(es, pc, 'a', polyval(sc.band.LA, obj.qEM), -1);
            es = obj.getGeneralElectricWaveVector(es, pc, k);
        case 11 % intra_em_TA
            ps.aborem = 1;
            ps.polar = 2;
            while polyval(sc.band.TA, obj.qEM)*pc.hbar >= es.energy
                obj.qEM = obj.qEM * 0.8;
            end
            k = obj.chooseStandardVectorForInelasticScattering(es, pc, 'a', polyval(sc.band.TA, obj.qEM), -1);
            es = obj.getGeneralElectricWaveVector(es, pc, k);
        case 12 % inter_f_em_LA
            ps.aborem = 1;
            ps.polar = 1;
            es.valley = randomValley(es, 'f');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wf.LA, -1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 13 % inter_f_em_TA
            ps.aborem = 1;
            ps.polar = 2;
            es.valley = randomValley(es, 'f');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wf.TA, -1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 14 % inter_f_em_TO
            ps.aborem = 1;
            ps.polar = 4;
            es.valley = randomValley(es, 'f');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wf.TO, -1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 15 % inter_g_em_LA
            ps.aborem = 1;
            ps.polar = 1;
            es.valley = randomValley(es, 'g');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wg.LA, -1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 16 % inter_g_em_TA
            ps.aborem = 1;
            ps.polar = 2;
            es.valley = randomValley(es, 'g');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wg.TA, -1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 17 % inter_g_em_LO
            ps.aborem = 1;
            ps.polar = 3;
            es.valley = randomValley(es, 'g');
            dv.valleyGuidingPrinciple(es);
            k = dv.valley.chooseStandardVectorForInelasticScattering(es, pc, 'e', sc.wg.LO, -1);
            es = dv.valley.getGeneralElectricWaveVector(es, pc, k);
        case 18 % 
            return;
    end
    
    if ps.polar ~= -1
        ps.vector = es.vector - vectorTemp;
        ps = dv.valley.phononWhetherBeyondBZ(ps, pc);
        ps.getFrequency(sc);
    end
    
    function value = randomValley(es, type)
        %>随机选择能谷
        switch type
            case 'f'
                valley0 = abs(es.valley);
                valleys1 = [2, -2, 3, -3];
                valleys2 = [1, -1, 3, -3];
                valleys3 = [1, -1, 2, -2];
                index = round(randNumber(0.5, length(valleys1)+0.5));
                switch valley0
                    case 1
                        value = valleys1(index);
                    case 2
                        value = valleys2(index);
                    case 3
                        value = valleys3(index);
                end
            case 'g'
                value = -1*es.valley;
        end
    end
end