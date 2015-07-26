function fundamental = ffilter(f)
%fundamental = ffilter(f)
%����:
%   <vector> f: һϵ��Ƶ��ֵ
%���:
%   <vector> fundamental: �������һϵ��Ƶ��ֵ��, �ҳ����ܵĻ�Ƶ
%ע: ���Ƚ�f�п�ǰ��Ԫ����Ϊ��Ƶ
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

