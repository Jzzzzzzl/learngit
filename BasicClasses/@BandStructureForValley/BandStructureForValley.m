classdef BandStructureForValley < handle
    %% 本文件提供能谷能带结构相关计算的父类
    % ======================================================================
    %>     属性说明：
    %>     Eg   ：能带带隙，以第一导带极小值为基准点
    %>     mt   ：横向有效质量
    %>     ml   ：纵向有效质量
    %>     md  ：态密度有效质量
    %>     alpha：能谷非抛物性参数
    %>     Tz   ：z轴Herring-Vogt变换矩阵
    %>     invTz：Tz逆矩阵
    %>     centerRatio：能谷中心所在位置比例
    %>
    % ======================================================================
    %>     函数说明：
    %>
    % ======================================================================
    properties
        Eg
        mt
        ml
        alpha
        centerRatio
        md
        Tz
        invTz
    end
    
    methods
        [k] = generateStandardElectricWaveVector(obj, es, pc, theta)
    end
end