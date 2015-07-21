function f = freqmap(varargin)
% freqmap(key, nnote)
% 输入:
% <string> key: 调名
% <int> nnote: 数字简谱
% 返回值:
% <float> f: 该音在给定调下的频率
%
% e.g. 求 F大调 SOL(5)音 的频率
% freqmap('F',5)
%           = 523.25
%
% 
% freqmap(key, nnote, flag)
% 输入:
% <int> flag: -1表示降调(?), 1表示升调(?)
%
% e.g. 求 ?D调 LA(6)音 的频率
% freqmap('D',6,-1)
%           = 466.16



end

