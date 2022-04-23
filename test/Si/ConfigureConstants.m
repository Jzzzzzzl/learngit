classdef ConfigureConstants < Data2ColocatedField
    %% 运行参数类
    properties(Constant)
        e =1.602176634e-19;
    end
    
    properties
        noFly
        envTemp
        maxVelocity
        maxFrequency
        initValley
        mLength
        mWidth
        eField
        dopdensity
    end
    
    methods
        function obj = ConfigureConstants
            obj.superElecs = 2000;
            obj.noFly = 10000;
            obj.eField = [100e-12 -1e5
                             110e-12 -10e5
                             1 -1e5];
            obj.dopdensity = 1e23;
            
            obj.envTemp = 300;
            obj.maxVelocity = 3e5;
            obj.maxFrequency = 10e13;
            obj.initValley = 1;
            obj.dSource = 0;
            obj.mLength = 1;
            obj.mWidth = 1;
            obj.NX = 1;
            obj.NY = 1;
            obj.NW = 100;
            obj.modelMeshAndBuildNodesAndReadData;
        end
        
        function modelMeshAndBuildNodesAndReadData(obj)
            %>构建节点和读取数据
            obj.frequencyGrid(0, obj.maxFrequency, obj.NW);
            obj.modelXGrid(0, obj.mLength, obj.NX);
            obj.modelYGrid(0, obj.mWidth, obj.NY);
            obj.eleConc = ColocateField(obj, obj.dopdensity);
            obj.dopDensity = ColocateField(obj, obj.dopdensity);
            obj.computeSuperElectricCharge;
        end
        
    end
end
