classdef ScatterringProcessGammaX < ScatterringProcessForValley
    
    methods
        function [es,ps] = electricScatProcess(obj, es, ps, dv, sc, pc, cc)
            %针对不同散射类型计算电子声子散射过程
            ps.time = es.time;
            ps.position = es.position;
            switch dv.sr.scatType
                case 1 % ionized-impurity
                    es = obj.chooseFinalVectorOfImpurity(es, dv, pc);
                case 2 % intra_ab_LA
                    ps.aborem = "ab";
                    ps.polar = "LA";
                    obj.chooseIntravalleyScatteringPhononWavenum(dv, pc, cc);
                    es.valley = obj.randomValley(es, "intra");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaLA(obj.qAB), 1);
                case 3 % intra_ab_TA
                    ps.aborem = "ab";
                    ps.polar = "TA";
                    obj.chooseIntravalleyScatteringPhononWavenum(dv, pc, cc);
                    es.valley = obj.randomValley(es, "intra");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaTA(obj.qAB), 1);
                case 4 % intra_em_LA
                    ps.aborem = "em";
                    ps.polar = "LA";
                    obj.chooseIntravalleyScatteringPhononWavenum(dv, pc, cc);
                    es.valley = obj.randomValley(es, "intra");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaLA(obj.qEM), -1);
                case 5 % intra_em_TA
                    ps.aborem = "em";
                    ps.polar = "TA";
                    obj.chooseIntravalleyScatteringPhononWavenum(dv, pc, cc);
                    es.valley = obj.randomValley(es, "intra");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaTA(obj.qEM), -1);
                case 6 % inter_g_ab_LA
                    ps.aborem = "ab";
                    ps.polar = "LA";
                    es.valley = obj.randomValley(es, "interg");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaLA(pc.qg), 1);
                case 7 % inter_g_ab_TA
                    ps.aborem = "ab";
                    ps.polar = "TA";
                    es.valley = obj.randomValley(es, "interg");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaTA(pc.qg), 1);
                case 8 % inter_g_ab_LO
                    ps.aborem = "ab";
                    ps.polar = "LO";
                    es.valley = obj.randomValley(es, "interg");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaLO(pc.qg), 1);
                case 9 % inter_f_ab_LA
                    ps.aborem = "ab";
                    ps.polar = "LA";
                    es.valley = obj.randomValley(es, "interf");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaLA(pc.qf), 1);
                case 10 % inter_f_ab_TA
                    ps.aborem = "ab";
                    ps.polar = "TA";
                    es.valley = obj.randomValley(es, "interf");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaTA(pc.qf), 1);
                case 11 % inter_f_ab_TO
                    ps.aborem = "ab";
                    ps.polar = "TO";
                    es.valley = obj.randomValley(es, "interf");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaTO(pc.qf), 1);
                case 12 % inter_g_em_LA
                    ps.aborem = "em";
                    ps.polar = "LA";
                    es.valley = obj.randomValley(es, "interg");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaLA(pc.qg), -1);
                case 13 % inter_g_em_TA
                    ps.aborem = "em";
                    ps.polar = "TA";
                    es.valley = obj.randomValley(es, "interg");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaTA(pc.qg), -1);
                case 14 % inter_g_em_LO
                    ps.aborem = "em";
                    ps.polar = "LO";
                    es.valley = obj.randomValley(es, "interg");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaLO(pc.qg), -1);
                case 15 % inter_f_em_LA
                    ps.aborem = "em";
                    ps.polar = "LA";
                    es.valley = obj.randomValley(es, "interf");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaLA(pc.qf), -1);
                case 16 % inter_f_em_TA
                    ps.aborem = "em";
                    ps.polar = "TA";
                    es.valley = obj.randomValley(es, "interf");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaTA(pc.qf), -1);
                case 17 % inter_f_em_TO
                    ps.aborem = "em";
                    ps.polar = "TO";
                    es.valley = obj.randomValley(es, "interf");
                    dv.judgeBsSrSp(es);
                    [es, ps] = obj.chooseElectricFinalStateAfterScattering(es, ps, dv, sc, pc, sc.omegaTO(pc.qf), -1);
                case 18 % 
                    return;
            end
        end
        
    end
    
    methods(Static)
        
        function value = randomValley(es, type)
            %随机选择能谷
            switch type
                case "impurity"
                    valleys = [1, -1, 2, -2, 3, -3];
                    index = round(randNumber(0.5, 6.5));
                    value = valleys(index);
                case "intra"
                    value = es.valley;
                case "interf"
                    valley0 = abs(es.valley);
                    valleys1 = [2, -2, 3, -3];
                    valleys2 = [1, -1, 3, -3];
                    valleys3 = [1, -1, 2, -2];
                    index = round(randNumber(0.5, 4.5));
                    switch valley0
                        case 1
                            value = valleys1(index);
                        case 2
                            value = valleys2(index);
                        case 3
                            value = valleys3(index);
                    end
                case "interg"
                    value = -1*es.valley;
            end
        end
        
    end
end
