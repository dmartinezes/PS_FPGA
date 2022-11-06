%% Configuración DDS test
% Accumulator length
Macc = 24; % bits
% Accumulator truncated phase (L <= M)
L = 15; % bits
% Sine LUT word-lemgth
W = 16; % bits
% Accumulator step P
f_interpolacion = 2000;
P = round(2^Macc*fmod*1e-3/(fsc/f_interpolacion))*2^-Macc;

%% Compensacion del DAC
h_comp_DAC=[-1/16 8/9 -1/16];
f_scala = 0.75;
h_comp_DAC = f_scala*h_comp_DAC/sum(h_comp_DAC);
h_comp_DAC = round(h_comp_DAC*2^17)*2^-17;

[H,Wf]=freqz(h_comp_DAC);
H(1)=H(2);
%H = H/max(abs(H));
figure(20)
plot(Wf/(2*pi),20*log10(abs(H)));

grid
ylabel('|H(f)| dBs')
xlabel('f/fs')
title(['FIR compensador DAC'])

% DAC
R=10;M=1;N=1;
h1=ones(M*R,1);
hcic=1;
for i=1:N 
	hcic=conv(h1,hcic); 
end;
f_cic_scale = ceil(log2((M*R)^(N-1)));
[H,Wf]=freqz(hcic/(sum(hcic)));
H(1)=H(2);
%H = H/max(abs(H));
figure(21)
plot(R*Wf/(2*pi),20*log10(abs(H)));
axis([0 0.5 -5 0])
grid
ylabel('|H(f)| dBs')
xlabel('f/fs')
title(['Respuesta DAC'])

hfinal=conv(hcic,upsample(h_comp_DAC,R)/R);

[h,Wf]=freqz(hfinal,1,1e5);


figure(22) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(R*Wf/(2*pi),20*log10(abs(h)));
grid
hold on
[H,Wf]=freqz(hcic/(sum(hcic)));
H(1)=H(2);
plot(R*Wf/(2*pi),20*log10(abs(H)),'r');
axis([0 0.5 -5 0])
ylabel('|H(f)| dBs')
xlabel('f/fs')
title(['DAC'])
legend('Compensated DAC',['DAC'])
hold off

%% Compensacion CIC interpolador x 2000
% Se asume escalado de la salida de 2^ceil(log2(2000^2))

% CIC
R=2000;M=1;N=3;
h1=ones(M*R,1);
hcic=1;
for i=1:N 
	hcic=conv(h1,hcic); 
end;
f_cic_scale = ceil(log2((M*R)^(N-1)));
[H,Wf]=freqz(hcic/(sum(hcic)),1,1e5);
H(1)=H(2);
%H = H/max(abs(H));
figure(30)
plot(Wf/(2*pi),20*log10(abs(H)));

grid
ylabel('|H(f)| dBs')
xlabel('f/fs')
title(['CIC: R=' num2str(R) ' M=' num2str(M) ' N=' num2str(N)])

% Compensador
order_comp_filter = 15;
f_max_comp = 0.4; % Máxima frec (normalizada) a compensar

f1=0:0.01:f_max_comp;
f=f1/(M*R);
resp=abs(sin(pi*f*R*M)./sin(pi*f)).^N; 
resp=resp/abs(resp(2));
resp(1)=resp(2);
g_cic04=resp(end);

figure(31) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(f,20*log10(abs(resp)));
grid
ylabel('|H(f)| dBs')
xlabel('f/fs')
title(['CIC: R=' num2str(R) ' M=' num2str(M) ' N=' num2str(N)])

h_comp_cic=remez(order_comp_filter,2*[f1 0.5],[1./resp 1/resp(end)]);
h_comp_cic = h_comp_cic * 0.95;
h_comp_cic = round(h_comp_cic*2^16)*2^-16;
[h,Wf]=freqz(h_comp_cic,1,1e5);

figure(32) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(Wf/(2*pi),20*log10(abs(h)));grid
h_comp04=20*log10(abs(h(round(length(h)*4/5))));
g_comp04=abs(h(round(length(h)*4/5)));
comp_g04 = g_comp04*g_cic04;

ylabel('|H(f)| dBs')
xlabel('f/fs')
title(['Compensador CIC: orden ' num2str(order_comp_filter) '; G(0.4)=' num2str(g_comp04) ' '])

hcic=hcic*2^-f_cic_scale;

hfinal=conv(hcic,upsample(h_comp_cic,R)/R);

[h,Wf]=freqz(hfinal,1,1e5);


figure(33) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(Wf/(2*pi),20*log10(abs(h)));
grid
hold on
[H,Wf]=freqz(hcic/(sum(hcic)),1,1e5);
H(1)=H(2);
plot(Wf/(2*pi),20*log10(abs(H)),'r');
hold off
axis([0 0.001 -50 0])
ylabel('|H(f)| dBs')
xlabel('f/fs')
title(['CIC: R=' num2str(R) ' M=' num2str(M) ' N=' num2str(N)])
legend('Compensated CIC',['CIC: R=' num2str(R) ' M=' num2str(M) ' N=' num2str(N)])