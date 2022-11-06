%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generación de ficheros para TB_CIC (Testeo del módulo CIC completo)
%   Curso 2020-2021
%   Versión para alumnos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ------------------Configuracion-----------------------------------------
graficas_si = 1; % 1 -> si; 0 -> no
ficheros_si = 1; % 1 -> si; 0 -> no
file_dir = './';

% Señal de entrada
sel = 0; %% 0 -> Sin; 1-> Chirp; 2 -> Square;

% Input Frequency (kHz)
fo= 10; % kHz
n_ciclos = 10; %% Num ciclos

Tsim = n_ciclos*1e-3/(fo); %% Simulation time

% Sample frequency (kHz)
fsL=50; % kHz

% CIC config
R = 2000; %% Interpolator Factor
M=1;
% Wordlengths
Wg = 22;  %% Calculate Filter Growth
Win = 16;  %% W input
Fin = 15;  %% frac
Wout = Win+Wg; %% Output full precision
%Wout = Win; %% Output Win bits

% ------------------Configuration END--------------------------------------


% Señales de control entrada
switch(sel)
    case 0
        sel_b = [0 0];
    case 1
        sel_b = [0 1];
    case 2
        sel_b = [1 0];
    case 3
        sel_b = [1 1];
    otherwise
        sel_b = [0 0];
end






%% Simulink
sim('CIC.slx');

%% Graficas INPUT / OUTPUT
L_s_in= length(s_in);
L_sout = length(s_out);
if graficas_si ==1
        subplot(2,1,1)
        plot((1:L_s_in),s_in(1:L_s_in))
        ylabel('s\_in(n)')
        xlabel('n')
        axis([0 L_s_in -1 1])
        subplot(2,1,2)
        plot((1:L_sout),s_out(1:L_sout)*2^-(Wg));
        ylabel('s\_out(n)')
        axis([0 L_sout -1 1])
        xlabel('n')
end

%% Generacion de ficheros de datos
if ficheros_si == 1
    % s_in 
    fB=sprintf(['s_CIC_in.txt']);
    packB=fopen(fB,'w');
    
    Dout_e=s_in*2^(Win-1);
    

    for i=1:length(Dout_e)
        fprintf(packB,num2str(Dout_e(i)));
        fprintf(packB,'\n');
    end
    fclose(packB);


    
    % s_out
    fB=sprintf(['s_CIC_out.txt']);
    packB=fopen(fB,'w');

    
    %% Cuantificamos a Wout.Wout-1
    q = quantizer([Wout Wout-1],'fixed','wrap','floor')

    Dout_q = quantize(q, s_out*2^-Wg); %% Cuantificamos
    Dout_bin = num2bin(q,Dout_q); %% Convertimos a binario
    [m,n] = size(Dout_bin);
    for i=1:m
       fprintf(packB,Dout_bin(i,1:(Wout)));
       fprintf(packB,'\n');
    end

    fclose(packB);
    
    %% COMB
    % Input data comb file
    i_data_comb = quantizer([16 15],'saturate','floor');
    fi_comb=sprintf([file_dir 'idata_comb1.txt']);
    pack_fi_comb=fopen(fi_comb,'w');
    for i=1:length(s_in1)
       fprintf(pack_fi_comb,[num2bin(i_data_comb ,s_in1(i)) '\n']);
       %fprintf(pack_fi_comb,[num2str(s_in1(i)) '\n']);
    end
    fclose(pack_fi_comb);
    
    % Output data comb file
    o_data_comb = quantizer([17 15],'saturate','floor');
    fo_comb=sprintf([file_dir 'odata_comb1.txt']);
    pack_fo_comb=fopen(fo_comb,'w');
    for i=1:length(out_comb1)
       fprintf(pack_fo_comb,[num2bin(o_data_comb ,out_comb1(i)) '\n']);
       %fprintf(pack_fo_comb,[num2str(out_comb1(i)) '\n']);
    end
    fclose(pack_fo_comb);
    
     %% INT
    % Input data int file
    i_data_int = quantizer([38 15],'saturate','floor');
    fi_int=sprintf([file_dir 'idata_int1.txt']);
    pack_fi_int=fopen(fi_int,'w');
    for i=1:length(out_int1)
       fprintf(pack_fi_int,[num2bin(i_data_int ,out_int1(i)) '\n']);
       %fprintf(pack_fi_int,[num2str(out_in1(i)) '\n']);
    end
    fclose(pack_fi_int);
    
    % Output data int file
    o_data_int = quantizer([38 15],'saturate','floor');
    fo_int=sprintf([file_dir 'odata_int1.txt']);
    pack_fo_int=fopen(fo_int,'w');
    for i=1:length(out_int2)
       fprintf(pack_fo_int,[num2bin(o_data_int ,out_int2(i)) '\n']);
       %fprintf(pack_fo_int,[num2str(out_int2(i)) '\n']);
    end
    fclose(pack_fo_int);
    
    %% R INT
    % Input data r int file
    i_data_r_int = quantizer([19 15],'saturate','floor');
    fi_r_int=sprintf([file_dir 'idata_r_int.txt']);
    pack_fi_r_int=fopen(fi_r_int,'w');
    for i=1:length(out_comb3)
       fprintf(pack_fi_r_int,[num2bin(i_data_r_int ,out_comb3(i)) '\n']);
       %fprintf(pack_fi_r_int,[num2str(out_comb3(i)) '\n']);
    end
    fclose(pack_fi_r_int);
    
    % Output data r int file
    o_data_r_int = quantizer([19 15],'saturate','floor');
    fo_r_int=sprintf([file_dir 'odata_r_int.txt']);
    pack_fo_r_int=fopen(fo_r_int,'w');
    for i=1:length(out_r_int)
       fprintf(pack_fo_r_int,[num2bin(o_data_r_int ,out_r_int(i)) '\n']);
       %fprintf(pack_fo_r_int,[num2str(out_r_int(i)) '\n']);
    end
    fclose(pack_fo_r_int);
    
    %% OUT TRUNC S[16,15]
    % Output data r int file
    o_data_trunc = quantizer([16 15],'saturate','floor');
    fo_trunc=sprintf([file_dir 'odata_trunc.txt']);
    pack_fo_trunc=fopen(fo_trunc,'w');
    for i=1:length(out_r_int)
       fprintf(pack_fo_trunc,[num2bin(o_data_trunc ,s_out2(i)) '\n']);
       %fprintf(pack_fo_r_int,[num2str(out_r_int(i)) '\n']);
    end
    fclose(pack_fo_trunc);
end
