function out = gray(N)
% tao chuoi so gray N bit
out = zeros(2^N,N);
flag = 0;
for i = 1:N
    for j = 1:2^i:2^N
        if flag == 0
            temp = [ zeros(2^i/2,1); ones(2^i/2,1) ];
        else
            temp = [ ones(2^i/2,1); zeros(2^i/2,1) ];
        end
        out(j:j+2^i-1,N-i+1) = temp;
        flag = ~flag;
    end
end
out = binaryVectorToDecimal(out)';
end