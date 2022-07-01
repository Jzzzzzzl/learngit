function rejectScatteringType(obj, cc, es)
    %>散射类型的拒绝算法
    a = es.position(1) - cc.regionPB(1);
    b = cc.regionPB(2) - es.position(1);
    if a*b > 0 && es.energy < cc.energyPB
        bool = true;
        maxitem = 0;
        while bool && maxitem < 20
            obj.computeScatType(cc, es);
            if sum(cc.scatypePB == obj.scatType) == 1
                bool = false;
            end
            maxitem = maxitem + 1;
        end
    else
        obj.computeScatType(cc, es);
    end
end