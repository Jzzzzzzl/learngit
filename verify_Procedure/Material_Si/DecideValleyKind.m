classdef DecideValleyKind < handle
    %% 能谷指向类
    properties
        valley
        valleyGX
    end
    
    methods
        function obj = DecideValleyKind(pc)
            %>构造函数
            obj.valleyGX = ValleyGX(pc);
        end
        
        function valleyGuidingPrinciple(obj, es)
            %>将dv指向电子所在能谷种类
            type = obj.judgeValleyKind(es);
            switch type
                case "GammaX"
                    obj.valley = obj.valleyGX;
                otherwise
                    error("能谷种类判断出错！")
            end
        end
        
    end
    
    methods(Static)
        function [value] = whichValley(es)
            %>计算电子所在能谷标号
            [~, index] = max(abs(es.vector));
            item = es.vector(index) / abs(es.vector(index));
            value = index * item;
        end
        
        function [type] = judgeValleyKind(es)
            %>判断能谷种类
            absValley = abs(es.valley);
            if absValley <= 3
                type = "GammaX";
            else
                error("能谷种类判断出错！")
            end
        end
    end
end