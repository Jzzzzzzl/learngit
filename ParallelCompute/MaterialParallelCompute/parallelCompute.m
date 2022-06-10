function [] = parallelCompute(sh, dv, sc, pc, cc)
    %% 并行计算
    eGroup = sh.eGroup;
    pGroup = sh.pGroup;
    
    tic
    parGrid = linspace(0, cc.noFly, cc.localWorkers+1);
%     p = parpool(cc.localWorkers);
    for k = 1 : cc.noFly
        parfor i = 1 : cc.superElecs
            %自由飞行段
            eGroup(i) = freeFlyProcess(eGroup(i), dv, pc, cc);
            %散射段
            dv.valleyGuidingPrinciple(eGroup(i));
            dv.valley.scatteringTable(eGroup(i), sc, pc, cc);
            dv.valley.computeScatType;
            eGroup(i).scatype = dv.valley.scatType;
            [eGroup(i), pGroup(i)] = dv.valley.scatteringProcess(dv, eGroup(i), pGroup(i), sc, pc);
        end
        %飞行完成后写入电声子信息
        [elog, plog] = getFileID(cc, parGrid, k);
        writeToElectricLogFile(elog, eGroup, cc);
        writeToPhononLogFile(plog, pGroup, cc);
        %输出计算进度
        disp(['计算进度： ', sprintf('%.2f', k / cc.noFly * 100), '%']);
    end
%     delete(p);
    disp(['计算总用时： ', sprintf('%.2f', toc), ' s']);
    
end