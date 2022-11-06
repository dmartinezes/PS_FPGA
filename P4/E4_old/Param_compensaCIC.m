%%
% Generación de ficheros para TB_CIC (Testeo del filtro compensador CIC)
%% 
graficas_si = 1; % 1 -> si; 0 -> no
ficheros_si = 1; % 1 -> si; 0 -> no
sim_time = 0.02;
%% CONFIGURATION

%% Parameters
fs = 50000; %% Frecuencia de muestreo
fo = 15000; %% Frecuencia de la señal
Win = 16; %% cuantificación de los datos de entrada
Win_f = 15; %% parte fraccional de los datos de entrada
Wc = 18; %% Bits para cuantificar los coeficientes
Wc_f = 16; %% Parte fraccional de los coeficientes
%% Coeficientes del filtro (en formato entero)
h_comp = [   
         640
         710
        -985
        1260
       -1145
        -100
        4458
      -19111
       86137
      -19111
        4458
        -100
       -1145
        1260
        -985
         710
         640
];
     


%% Convertir a binario los coeficientes del filtro
q = quantizer([Wc Wc_f],'fixed','wrap','floor')
h_q = quantize(q, h_comp*2^-Wc_f); %% Cuantificamos
h_bin = num2bin(q,h_q); %% Convertimos a binario

%% Escribir los coeficientes en el fichero
fB = sprintf(['coef.txt']);
packB = fopen(fB,'w')
for i=1:length(h_comp)
   fprintf(packB,h_bin(i,:));
   fprintf(packB,'\n');
end
fclose(packB);

M=1;


%% Simulink
sim('Filtro_compensa_CIC.slx');

%% Graficas INPUT / OUTPUT
L_s_in= length(s_in);
if graficas_si ==1
        subplot(2,1,1)
        plot((1:L_s_in),s_in(1:L_s_in))
        ylabel('s\_in(n)')
        xlabel('n')
        axis([0 L_s_in -1 1])
        subplot(2,1,2)
        sal_out(1:L_s_in) = s_out(1,1,1:L_s_in);
        plot((1:L_s_in),sal_out);
        ylabel('s\_out(n)')
        axis([0 L_s_in -1 1])
        xlabel('n')
end

%% Generacion de ficheros de datos
if ficheros_si == 1
  

    

    %% Escritura de ficheros de datos de entrada
     q_in = quantizer([Win Win_f],'fixed','wrap','floor');
     Dout_eq = quantize(q_in,s_in);
     [m,n] = size(Dout_eq);
    
    f=sprintf(['s_FC_CIC_in.txt']);
    pack_f=fopen(f,'w');

    for i=1:length(s_in)
       fprintf(pack_f,num2bin(q_in,Dout_eq(i)));
     
       fprintf(pack_f,'\n');
    end

    fclose(pack_f);

    % s_out

    fC=sprintf(['s_FC_CIC_out1.txt']);
    packC=fopen(fC,'w');

    Dout_s=s_out*2^((Wc+Win-3));
%     
%      %% Cuantificamos con precision completa 
      Wout = Win+Wc;
      Wout_f = Win_f + Wc_f;

     %% Cuantificamos a 19.16
     %Wout = 19;
     %Wout_f = 16;
     qout=quantizer([Wout Wout_f ],'fixed','wrap','floor')
     Dout_q = quantize(qout, s_out); %% Cuantificamos
     Dout_bin = num2bin(qout,Dout_q); %% Convertimos a binario
     [m,n] = size(Dout_bin);
    for i=1:length(s_in)
        fprintf(packC,Dout_bin(i,:));
        fprintf(packC,'\n');
    end

    fclose(packC);
    
end

%%
%Respuesta del CIC
N=3;M=1;R=2000; 
w=[0:0.05:1];
h1=ones(R*M,1);
hcic=1;
for i=1:N
    hcic=conv(h1,hcic);
end
[h,w]=freqz(hcic,1);
figure;
a1 = plot(w/(2*pi),20*log10(abs(h)));
hold;

%Respuesta del filtro compensador secuencial
for i=1:length(h_q)
    hcomp=conv(h_q,hcic);
end
[h,w]=freqz(hcomp,1);
a2 = plot(w/(2*pi),20*log10(abs(h)));
M1 = "Respuesta filtro CIC";
M2 = "Respuesta filtro compoensador";
legend([a1,a2], [M1, M2]);
