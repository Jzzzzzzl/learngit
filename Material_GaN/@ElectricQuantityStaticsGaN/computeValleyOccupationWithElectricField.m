function computeValleyOccupationWithElectricField(obj, cc)
    %>
    if isempty(obj.occupyRate)
        error("请先计算valleyOccupationWithTime函数！")
    end
    n = find(cc.eField(:, 1) >= obj.minimumTime, 1);
    obj.occupyField = zeros(n, 4);
    for i = 1 : n
        index = find(obj.occupyRate(:, 1) >= cc.eField(i, 1) * 1e12, 1) - 2;
        if isempty(index)
            [index, ~] = size(obj.occupyRate);
        end
        obj.occupyField(i, 1) = abs(cc.eField(i, 2));
        obj.occupyField(i, 2:end) = obj.occupyRate(index, 2:end);
    end
    figure
    hold on
    [~, n] = size(obj.occupyRate);
    for i = 2 : n
        slg = plot(obj.occupyField(:, 1), obj.occupyField(:, i), '-*');
        slg.LineWidth = 2;
    end
    xlabel("V/m"); ylabel(".a.u");
    legend('U', 'Gamma1', 'Gamma3')
    title("valley occupation")
    hold off
end