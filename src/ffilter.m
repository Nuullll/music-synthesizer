function fundamental = ffilter(f)
%fundamental = ffilter(f)
%输入:
%   <vector> f: 一系列频率值
%输出:
%   <vector> fundamental: 在输入的一系列频率值中, 找出可能的基频
%注: 优先将f中靠前的元素作为基频
fundamental = [];
for j = 1:length(f)
    if isempty(fundamental)
        fundamental = [fundamental,f(j)];
    else
        ratio = f(j)./fundamental;
        inrange = (ratio<(round(ratio)*1.05)) + (ratio>(round(ratio)*0.95));
        if all(inrange~=2)
            fundamental = [fundamental,f(j)];
        end
    end
end

end

