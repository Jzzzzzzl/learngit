function elasticIntravalleyAcousticScatteringRate(obj, es, pc, cc)
    %>生成谷内声学散射句柄函数（弹性）
    %>     参数说明：
    %>     D：形变势常量
    % ======================================================================
    obj.elasticIntraAcoustic = @(D) sqrt(2)*obj.md^(3/2)*pc.kb*cc.envTemp*D^2 ...
                                      / (pi*pc.hbar^4*pc.u^2*pc.rho) ...
                                      * real(sqrt(es.epsilon))*(1+2*obj.alpha*es.epsilon/pc.e) ...
                                      * real(sqrt(1+obj.alpha*es.epsilon/pc.e));
end