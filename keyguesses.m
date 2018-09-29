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
pow = csvread('traces.csv');   %t
time = 1:400;
figure(2);
for i = 1:256
    roh(:,i) = corr(hd(:,i),pow);
    plot(time,roh(:,i))
    hold on
    title('Key Guesses')
    xlabel('time')
    ylabel('key')
end
maxplots = max(roh);    %max corr in every column
minplots = min(roh);

[max_corr, max_inx] = max(maxplots);    %max_inx : col index of highest
[min_corr, min_inx] = min(minplots);

max_modelxtrace = roh(:,max_inx);   % store whole col that had highest element
min_modelxtrace = roh(:,min_inx); 
[max_model, max_position] = max(max_modelxtrace);   %max_pos : row index of highest element
[min_model, min_position] = min(max_modelxtrace);
pos_max = dec2hex(max_inx-1);   %convert to hex the col(key) of the highest element
pos_min = dec2hex(min_inx-1);
for i = 1:400
    if(roh(i,max_inx)== max_model)
        max_row = i;
    end
end
