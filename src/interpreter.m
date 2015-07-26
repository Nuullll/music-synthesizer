function [song,BPM,key] = interpreter(nt)
%[song,BPM,key] = interpreter(nt)
%����:
%   <n-by-2 cell> nt: ��һ��Ϊ�����220Hz�������, �ڶ���Ϊ��ǰ���ĳ���
%���:
%   <n-by-2 cell> song: C�������, �ڶ���Ϊ������
%   <float> BPM: ÿ���ӽ�����
%   <char> key: 'C'
key = 'C';
t = cell2mat(nt(:,2));
tpb = min(t);
BPM = round(60/tpb);
song = cell(size(nt,1),2);
for i = 1:size(nt,1)
    nnote = [];
    n = nt{i,1};
    for j = 1:length(n)
        nnote = [nnote,floor(n(j)/12)*7+cnotetable(mod(n(j),12))];
    end
    song{i,1} = nnote;
    song{i,2} = round(nt{i,2}/tpb);
end


end

