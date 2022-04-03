classdef BandStructureGamma3 < BandStructureForValley
    %% U能谷
    methods
        function obj = BandStructureGamma3(pc)
            %>构造函数
            obj.Eg = pc.EgG3;
            obj.mt = pc.mtG3;
            obj.ml = pc.mlG3;
            obj.alpha = pc.alphaG3;
            obj.centerRatio = pc.centerRatioG3;
            obj.md = (obj.mt^2*obj.ml)^(1/3);
            obj.Tz = [sqrt(pc.m / obj.mt)    0   0;
                        0   sqrt(pc.m / obj.mt)  0;
                        0   0   sqrt(pc.m / obj.ml)];
            obj.invTz = inv(obj.Tz);
        end
        
    end
end
