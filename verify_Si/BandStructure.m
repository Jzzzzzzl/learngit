classdef BandStructure < handle
    
    properties
        
        
        
    end
    
    
    methods
        
        function obj = BandStructure(Material)
            %能带曲线
            if strcmpi(Material, "Si")
                
            elseif strcmpi(Material, "GaN")
                
            end
        end
        
        function [es] = ChooseWaveVector(obj, es, pc)
            %根据能量选择电子波矢
            
            n = 10; %椭球点密集程度
            energy0 = es.energy/es.eipara;
            rx = real(sqrt(2 * energy0 * pc.mt) / pc.hbar);
            ry = real(sqrt(2 * energy0 * pc.mt) / pc.hbar);
            rz = real(sqrt(2 * energy0 * pc.ml) / pc.hbar);
            [xm, ym, zm] = ellipsoid(0,0,0,rx,ry,rz,n);
            
            while true
                %可通过控制randx与randy的范围来取值
                randx = round(ElectricStatus.Random(0.5, n + 0.5));
                randy = round(ElectricStatus.Random(0.5, n + 0.5));
%                 randx = round(rand(1)*(n - 1)) + 1;
%                 randy = round(rand(1)*(n - 1)) + 1;
                x = xm(randx, randy);
                y = ym(randx, randy);
                z = zm(randx, randy);
                kitem = [x, y, z] + [0, 0,  0.85] * dGX;
                if double(max(abs(es.vector))/pc.dGX) < 1.0
                    break;
                end
            end
            
            es.vector = obj.RotateToOtherAxisValley(kitem, es.valley);
            
        end
        
    end
    
    methods
        
        function [Rrot] = RotMatrix(~, theta, type)
            % 在符合右手法则的坐标系中顺时针旋转
            switch type
                case 'x'
                    Rrot = [1 0 0;0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
                case 'y'
                    Rrot = [cos(theta) 0 sin(theta);0 1 0;-sin(theta) 0 cos(theta)];
                case 'z'
                    Rrot = [cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];
            end
            
        end
        
        
        function [vector2] = RotateToOtherAxisValley(obj, vector1, valley)
            %从Z轴正向能谷转向其他能谷
            
            switch valley
                case 1
                    vector2 = vector1*obj.RotMatrix(-pi/2, 'y');
                case -1
                    vector2 = vector1*obj.RotMatrix(pi/2, 'y');
                case 2
                    vector2 = vector1*obj.RotMatrix(pi/2, 'x');
                case -2
                    vector2 = vector1*obj.RotMatrix(-pi/2, 'x');
                case 3
                    vector2 = vector1*obj.RotMatrix(0, 'x');
                case -3
                    vector2 = vector1*obj.RotMatrix(-pi, 'x');
            end
            
        end
        
        function [vector2] = RotateToZAxisValley(obj, vector1, valley)
            %从其他能谷转向Z轴正向能谷
            
            switch valley
                case 1
                    vector2 = vector1*obj.RotMatrix(pi/2, 'y');
                case -1
                    vector2 = vector1*obj.RotMatrix(-pi/2, 'y');
                case 2
                    vector2 = vector1*obj.RotMatrix(-pi/2, 'x');
                case -2
                    vector2 = vector1*obj.RotMatrix(pi/2, 'x');
                case 3
                    vector2 = vector1*obj.RotMatrix(0, 'x');
                case -3
                    vector2 = vector1*obj.RotMatrix(pi, 'x');
            end
        end
        
        
        function [energy] = ComputeElectricEnergy(obj, es, pc)
            %计算电子能量
            
            kitem = obj.RotateToZAxisValley(es.vector, es.valley);
            k0 = kitem - [0, 0, 0.85] * pc.dGX;
            energy = es.eipara * pc.hbar^2 * ...
                         (k0(1)^2 / pc.mt + k0(2)^2 / pc.mt + k0(3)^2 / pc.ml) / 2;
%             if es.energy > EnergyMax
%                 es.energy = EnergyMax;
%             end
        end
        
        function [velocity] = ComputeElectricVelocity(obj, es, pc)
            %计算电子速度
            
            kitem = obj.RotateToZAxisValley(es.vector, es.valley);
            k0 = kitem - [0, 0, 0.85] * pc.dGX;
            vx = es.vipara * pc.hbar * k0(1) / pc.mt;
            vy = es.vipara * pc.hbar * k0(2) / pc.mt;
            vz = es.vipara * pc.hbar * k0(3) / pc.ml;
            velocity = [vx, vy, vz];
            
            velocity = obj.RotateToOtherAxisValley(velocity, es.valley);
        end
        
        function [energyGX] = BandStructurePlot(obj, num, bs, pc)
            %电子能带画图
            
            energyGX = zeros(num, 2);
            k = linspace(0, 1, num);
            elec = ElectricStatus;
            elec.valley = 1;
            for i = 1 : num
                elec.vector = [k(i) 0 0] * pc.dGX;
                elec = elec.ComputeInParabolicFactor(bs, pc);
                energyGX(i, 1) = elec.vector(1) / pc.dGX;
                energyGX(i, 2) = obj.ComputeElectricEnergy(elec, pc) / pc.e;
            end
            figure
            plot(energyGX(:,1), energyGX(:,2))
            xlabel("k/dGX")
            ylabel("Energy/(eV)")
            
        end
        
        function [velocityGX] = ElectricVelocityPlot(obj, num, bs, pc)
            % 电子速度画图
            
            velocityGX = zeros(num, 2);
            k = linspace(0, 1, num);
            elec = ElectricStatus;
            elec.valley = 1;
            for i = 1 : num
                elec.vector = [k(i) 0 0] * pc.dGX;
                elec = elec.ComputeInParabolicFactor(bs, pc);
                velocityGX(i, 1) = elec.vector(1) / pc.dGX;
                velocity = obj.ComputeElectricVelocity(elec, pc) * 1e2;
                velocityGX(i, 2) = velocity(1);
            end
            figure
            plot(velocityGX(:,1),velocityGX(:,2))
            xlabel("k/dGX")
            ylabel("Velocity/(cm/s)")
            
        end
        
    end
    
    
end