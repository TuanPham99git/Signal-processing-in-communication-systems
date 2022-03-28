%
d = randint(1,1000);
L=length(d);
SNR=2; %y so tin hieu tren tap am. 
y=1;
N=5*10^6;%toc do du lieu. 
Fc=10^7;%tan so song mang. 
T=1/N;%thoi gian truyen bit. 
t=0:T*L/(30*L-1):T*L;
%tao chuoi dk gom 1,-1,j va -j.
for x=1:2:L
if d(x)==0 && d(x+1)==0
    dk((y-1)*60+1:y*60)=1;
    y=y+1;
elseif d(x)==0 && d(x+1)==1
    dk((y-1)*60+1:y*60)=j; 
    y=y+1;
elseif d(x)==1 && d(x+1)==1
    dk((y-1)*60+1:y*60)=-1;
    y=y+1; 
elseif d(x)==1 && d(x+1)==0
    dk((y-1)*60+1:y*60)=-j; 
    y=y+1;
end
end

%tao tin hieu phat st voi pha cua tin hieu phat la pi/4.
st=dk*exp(j*pi/4); 
st_awgn=awgn(st,SNR,'measured');%tin hieu qua kenh AWGN.

%Giai dieu che ban tin QPSK.
%tim pha cua tin hieu tai phia thu. 
for x=1:60*L/2
if angle(st_awgn(x))<=pi/2 && angle(st_awgn(x))>0
    phi(x)=pi/4;
elseif angle(st_awgn(x))<=pi && angle(st_awgn(x))>pi/2
    phi(x)=3*pi/4;
elseif angle(st_awgn(x))<=0 && angle(st_awgn(x))>-pi/2 
    phi(x)= 7*pi/4;
elseif angle(st_awgn(x))<=-pi/2 && angle(st_awgn(x))>-pi
    phi(x)=5*pi/4;
end
end
%tim lai vecto phat.
z=1;
for x=30:60:60*L/2 
    if phi(x) == pi/4
        r((z-1)*30+1:z*30)=0;
        r(z*30+1:z*30+30)=0;
        z=z+2; 
    elseif phi(x)==3*pi/4
        r((z-1)*30+1:z*30)=0; 
        r(z*30+1:z*30+30)=1;
        z=z+2; 
    elseif phi(x)==5*pi/4
        r((z-1)*30+1:z*30)=1; 
        r(z*30+1:z*30+30)=1;
        z=z+2;
    elseif phi(x)==7*pi/4
        r((z-1)*30+1:z*30)=1; 
        r(z*30+1:z*30+30)=0;
        z=z+2;
    end
end
%ve bieu do chom sao QPSK. 
h=scatterplot(st_awgn,1,0,'xb');
hold on
scatterplot(st,1,0,'or',h)
title('bieu do chom sao tin hieu QPSK')
%ve dang song tin hieu. 
for x=1:30*L
    sdc(x)=cos(2*pi*Fc*t(x)+ angle(st(x))); 
    sdc_awgn(x)=cos(2*pi*Fc*t(x)+angle(st_awgn(x)));
end
figure(2) 
plot(t,sdc)
title('dang song tin hieu tai dau ra bo dieu che') 
figure(3)
plot(t,sdc_awgn);
title('dang song tin hieu khi qua kenh awgn')
figure(4)
plot(t,r)
title('dang song tin hieu sau khi duoc khoi phuc')

%Mau mat cua tin hieu tai cac diem tren he thong
%ve pho cua tin hieu.
%pho tin hieu dieu che.
f=(-30*L/2:30*L/2-1)/(30*L*(t(2)-t(1)));
pho_dc=fft(sdc,30*L);
pho_dc=fftshift(pho_dc); 
figure(5) 
plot(f,abs(pho_dc).^2/(30*L))
title('pho tin hieu sau dieu che')
%pho tin hieu khi qua kenh awgn. 
pho_awgn=fft(sdc_awgn,30*L);
pho_awgn=fftshift(pho_awgn);
figure(6) 
plot(f,abs(pho_awgn).^2/(30*L))
title('pho tin hieu qua kenh awgn')
%pho tin hieu khi khoi phuc tai phia thu. 
pho_r=fft(r,30*L); 
pho_r=fftshift(pho_r);
figure(7)
plot(f,abs(pho_r).^2/(30*L))
title('pho tin hieu khi duoc khoi phuc')
%ve duong cong xac xuat loi.
%tao chuoi bit ngau nhien QPSK.
Dk=randint(1,5*10^5,[0 3]);
Phi=2*pi*Dk/4 + pi/4; 
sk=exp(i*Phi);
SNRdB=0:15;%dB
for k=1:length(SNRdB)
    st=awgn(sk,SNRdB(k),'measured');
for c=1:length(Dk)
        if angle(st(c))<=pi/2 && angle(st(c))>0
            phi(c)=pi/4;
        elseif angle(st(c))<=pi && angle(st(c))>pi/2
            phi(c)=3*pi/4;
        elseif angle(st(c))<=3*pi/2 && angle(st(c))>pi
            phi(c)= 5*pi/4;
        elseif angle(st(c))<=2*pi && angle(st(c))>3*pi/2
            phi(c)=7*pi/4;
        end
end
error=phi;
%tim so symbol sai.
so_loi=length(find(error~=0)); 
BER(k)=so_loi/(5*10^5);
end        
%

% BER theo ly thuyet truyen dan QPSK la: 
BER_lt=erfc(sqrt(10.^(SNRdB./10)));
%ve do thi.
figure(8) 
semilogy(SNRdB,BER,'*',SNRdB,BER_lt); 
xlabel('SNR')
ylabel('BER')
legend('theo mo phong','theo ly thuyet')
title('duong cong bit loi QPSK')
grid 