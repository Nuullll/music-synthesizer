function f = freqmap(varargin)
% freqmap(key, nnote)
% 输入:
% <string> key: 调名
% <int> nnote: 数字简谱
% 返回值:
% <float> f: 该音在给定调下的频率
%
% e.g. 求 F大调 So(5)音 的频率
% freqmap('F',5)
%           = 523.2511
%
% 
% freqmap(key, nnote, flag)
% 输入:
% <int> flag: -1表示降调(b), 1表示升调(#)
%
% e.g. 求 bD调 La(6)音 的频率
% freqmap('D',6,-1)
%           = 466.1638

narginchk(2,3);     % check input argv
key = varargin{1};
nnote = varargin{2};
if nargin == 2      % freqmap(key,nnote)
    flag = 0;
else                % freqmap(key,nnote,flag)
    flag = varargin{3};
end
if key == 'B' && flag == 1      % #B === C
    f = freqmap('C',nnote,0); return
elseif key == 'C' && flag == -1     % bC === B
    f = freqmap('B',nnote,0); return
elseif key == 'E' && flag == 1      % #E === F
    f = freqmap('F',nnote,0); return 
elseif key == 'F' && flag == -1     % bF === E
    f = freqmap('E',nnote,0); return 
elseif flag == 1
    f = freqmap(key+1,nnote,-1);    % #A === bB
end

if nnote < 1 || nnote > 7
    f = 2^floor((nnote-1)/7)*freqmap(key,mod(nnote-1,7)+1,flag);
    return
end

mainf = 2.^((0:11)/12)*220;     % [A,bB,B,C,bD,D,bE,E,F,bG,G,bA]
map = containers.Map({'A','B','C','D','E','F','G'},{1,3,4,6,8,9,11});
f1 = mainf(map(key)+flag);      % frequency of note Do

if nnote <= 3       % Do Re Mi
    f = f1*2^(2*(nnote-1)/12);
else                % Fa So La Si
    f = f1*2^((2*(nnote-1)-1)/12);
end

end

