function idec = bindec(ibin,LEN)

idec = 0;
ii = 1;
for i = 1:LEN
    idec = idec + ii*ibin(LEN+1-i);
    ii = ii*2;
end