f = fopen('input_plaintext.txt','r');
c = textread('input_plaintext.txt','%s','delimiter','\n','whitespace','');
in_hex = cellfun(@(l) l(1:2),c,'un',0);   %2 char input array
in_dec = hex2dec(in_hex);     %input in hexadecimal
measure = 1:10000;
maxplots = zeros(10000,256);
roh = zeros(10000,256);
for n = 1:400                 %no of inputs
for i = 1:n                     %varying no of inputs
    for j = 1:256               % for all keys
        s(i,j) = bitxor(in_dec(i),(j-1));      %xor input and key
    end
end
hd = arrayfun(@(s) sum(bitget(s,1:8)),s);       %hamming distance
pow = csvread('fifty.csv',1,0,[1,0,i,49]);                     %read power traces
time = 1:50;

    for k = 1:256                                   %for all keys, one at a time
        roh(:,k) = corr(hd(:,k),pow);               %corr with whole trace file
    end

maxplots(n,:) = max(roh);                         %max of every column
minplots = min(roh);

disp("Created row")
disp(n)

end 
figure(4);
for y = 1:256
plot(measure,maxplots(:,y));
hold on
end
