function inelasticIntravalleyOpticalScatteringRate(obj, dv, pc, cc)
    %>生成谷内光学散射句柄函数
    %>     参数说明：
    %>     DK：耦合常数
    %>     w：某极化支/某散射类型的声子平均频率
    % ======================================================================
    epsilonTempAB = @(w) dv.bs.epsilon + pc.hbar * w;
    obj.inelasticIntraOpticalAB = @(DK, w) DK^2*dv.bs.md^(3/2) ... 
                                            / (sqrt(2)*pi*pc.rho*pc.hbar^3 * w) ...
                                           * (1/(exp(pc.hbar * w / (pc.kb*cc.envTemp)) - 1)) ...
                                           * real(sqrt(epsilonTempAB(w))) ...
                                           * real(sqrt((1 + dv.bs.alpha*epsilonTempAB(w)/pc.e))) ...
                                           * (1 + 2*dv.bs.alpha*epsilonTempAB(w)/pc.e);
    epsilonTempEM = @(w) dv.bs.epsilon - pc.hbar * w;
    obj.inelasticIntraOpticalEM = @(DK, w) DK^2*dv.bs.md^(3/2) ... 
                                            / (sqrt(2)*pi*pc.rho*pc.hbar^3 * w) ...
                                           * (1 + 1/(exp(pc.hbar * w / (pc.kb*cc.envTemp)) - 1)) ...
                                           * real(sqrt(epsilonTempEM(w))) ...
                                           * real(sqrt((1 + dv.bs.alpha*epsilonTempEM(w)/pc.e))) ...
                                           * (1 + 2*dv.bs.alpha*epsilonTempEM(w)/pc.e);
end