%% 参数
%  均使用国际单位制

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%     固定常量     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e = 1.602176634e-19;            %电子的电荷量
m = 9.10956e-31;                %电子的质量
kb = 1.380649e-23;              %玻尔兹曼常数
h = 6.6260755e-34;              %普朗克常量
hbar = 1.05457266e-34;          %约化普朗克常量

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%     模型参数     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d1 = 100e-9;                %源极长度
d2 = 200e-9;                %栅极长度
d3 = 100e-9;                %漏极长度

dntype = 120e-9;            %n型掺杂厚度,从顶部开始

mLength = 600e-9;             %实空间模型长度
mWidth = 500e-9;              %实空间模型高度

mbLeft  = 0;                    %模拟区域边界
mbRight = mLength;
mbTop = mWidth;
mbBottom = 0;

xMin = mbLeft;                  %模型网格参数
xMax = mbRight;
NX = 60;                        %划分网格数,不能比silvaco的网格密
deltax = mLength/NX;
yMin = mbBottom;
yMax = mbTop;
NY = 60;
deltay = mWidth/NY;

hotSpotPoint = 420e-9;         %热点位置,只规定x方向,y方向由于与电子运动有关所以不作规定

DopDensity = 1e23;             %掺杂浓度

sumSuperElecs = 200;            %超电子数

T = 300;                        %环境温度

timeStart = 0;                  %时间段
timeEnd = 4.2758e-11;

noFly = 2000;                    %需要模拟的运动次数
deltaFly = noFly/4;             %分段计算飞行过程，分段存储

nofScat = 15;                   %考虑的散射类型数
slefScatRate = 1.2;             %自散射占比

EnergyInit = 0.01*e;            %电子初始能量

gammaMax = 4e13;                %主要用来计算飞行时间，大小不计较

HotSpotRound = 20e-9;            %热点范围

xsforSourceB = 9e20;

xsfornDot = 1e8;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%     材料参数     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                           % Material = 'Si'

a = 5.431e-10;                  %晶格常数
c = 3.867e-10; 
EMax = 1.3*e;                   %电子在第一导带中的最高能量
EnergyCut = 0.1*e;              %电子所能发射声子的最低能量
Eg = 0.2*e;                     %导带底能量，相对于费米能级
dGX = 2*pi/a;                   %第一布里渊区，Gamma点到X点的距离
qf = 0.95*dGX;                  %f型散射声子波矢大小
qg = 0.3*dGX;                   %g型散射声子波矢大小
qintra = 0.15*dGX;              %谷内散射声子波矢大小
wMin = 0;                       %频率网格参数
wMax = 12e13;
NW = 200;
deltaw = (wMax-wMin)/NW;
qMin = 0;                       %波矢网格参数
qMax = dGX;
NQ = 200;
mt = 0.196*m;                   %质量张量的分量
ml = 0.916*m;
V0 = sqrt(3)*c^3/8;             %单原子体积
Rs = 2.122e-10;                 %球形Winger-Seitz元胞半径
DLA = 6.39*e;                   %各向同性平均形变势
DTA = 3.01*e;
gammaG = 0.73;                  %Gruneisen非谐参数
C44 = 75e9;
miu = C44;                      %剪切模量
rou = 2330;                     %密度
thetaD = 643;                   %德拜温度
omegaD = thetaD*kb/hbar;        %德拜频率
k = 148;                        %热导张量，暂定常数

kappa = 11.9*8.854187817e-12;   %介电常量
Beta = 1e9;                     %屏蔽长度倒数
Z = 0.02;                       %杂质电荷数

ul = 9.2e3;                     %纵向声速
ut = 4.7e3;                     %横向声速
bzR = (5/pi)^(1/3)*dGX;         %第一布里渊区等效半径
md = (mt^2*ml)^(1/3);           %态密度有效质量
gDKTA = 0.5e10*e;               %耦合常数
gDKLA = 0.8e10*e;
gDKLO =  11e10*e;
fDKTA = 0.3e10*e;
fDKLA =   2e10*e;
fDKTO =   2e10*e;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%     其他处理     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





tMin = timeStart;               %时间网格参数
tMax = timeEnd;
Nt = 100;

Deltat = timeEnd-timeStart;     %模拟时间间隔
deltat = Deltat / Nt;







































