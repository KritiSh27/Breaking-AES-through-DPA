f = fopen('input_plaintext.txt','r');
c = textread('input_plaintext.txt','%s','delimiter','\n','whitespace','');
in_hex = cellfun(@(l) l(1:2),c,'un',0);   %2 char input array cellcont
in_dec = hex2dec(in_hex);     %inp
for i = 1:10000
    for j = 1:256
        s(i,j) = bitxor(in_dec(i),(j-1));      %l
    end
end
hd = arrayfun(@(s) sum(bitget(s,1:8)),s);
pow = csvread('fifty.csv');   %t
time = 1:50;
for k = 1:256
    roh(:,k) = corr(hd(:,k),pow);
end
maxplots = max(roh);
minplots = min(roh);

[max_corr, max_inx] = max(maxplots);
[min_corr, min_inx] = min(minplots);

max_modelxtrace = roh(:,max_inx); 
min_modelxtrace = roh(:,min_inx); 
[max_model, max_position] = max(max_modelxtrace);
[min_model, min_position] = min(max_modelxtrace);
pos_max = dec2hex(max_inx-1);
pos_min = dec2hex(min_inx-1);
figure(3);
plot(time,roh(:,1))
    hold on
plot(time,roh(:,256))
    title('Best 2 Key Guesses')
    xlabel('time')
    ylabel('Corelation')
    