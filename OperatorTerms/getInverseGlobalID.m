function [xID, yID] = getInverseGlobalID(~, ysize, globalID)
    %>反算单元格坐标
    xID = ceil(globalID/ysize);
    yID = globalID - (xID - 1) * ysize;
end