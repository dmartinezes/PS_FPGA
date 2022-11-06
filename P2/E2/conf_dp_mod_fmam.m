%%
% Generación de ficheros para TB_DP_MOD
%% 
graficas_si = 1; % 1 -> si; 0 -> no
ficheros_si = 1; % 1 -> si; 0 -> no
file_dir = './';
%% MOD AM/FM CONFIGURATION

% Control FM --> 1, AM --> 0
control_fm_am=0;

% Sampling frequency (MHz)
fsc=100; % MHz

% Carrier frequency (MHz)
fc=10.7; % MHz

% AM modulation index (range [0,1[)
m_am=1*(1-2^-15);

% FM modulation index (kHz)
Kfm=5000; % kHz

% Modulating frequency (kHz)
fmod= 150; % kHz

% Number of period to display 
n_periods_to_display = 1;


%% Simulink
% Simulation time
sim_time = n_periods_to_display/fmod*1e3;

sim('mod_fmam_pf');


%% Verilog simulation values
% Frecuencia portadora: U[24,24]
frec_por = round(fc/fsc*2^24);            
% Índice de modulacion de AM: U[16,15]
im_am =  round(m_am*2^15);
% Índice de modulacion de FM: U[16,16]
im_fm =  round(Kfm*1e-3/fsc*2^16);

% Display por consola
disp(' ')
disp('*****************************************')
disp('Values for HDL simulation')
disp('*****************************************')
disp(['c_fm_am = ' num2str(control_fm_am)])
disp(['frec_por = ' num2str(frec_por)])
disp(['im_am = ' num2str(im_am)])
disp(['im_fm = ' num2str(im_fm)])
disp('*****************************************')

%% Graficas AM/FM
L_s_in= length(s_in);
if graficas_si ==1
    if control_fm_am == 0 % graficas AM
        subplot(2,1,1)
        plot((1:L_s_in),s_in(1:L_s_in))
        ylabel('s\in(n)')
        axis([0 L_s_in -1 1])
        subplot(2,1,2)
        plot((1:L_s_in),s_am(1:L_s_in))
        ylabel('s\_am(n)')
        xlabel('n')
        axis([0 L_s_in -1 1])
    else % Graficas FM
        subplot(2,1,1)
        plot((1:L_s_in),s_in(1:L_s_in))
        ylabel('s\in(n)')
        axis([0 L_s_in -1 1])
        subplot(2,1,2)
        plot((1:L_s_in),s_fm(1:L_s_in))
        ylabel('s\_fm(n)')
        xlabel('n')
        axis([0 L_s_in -1 1])
    end
end
%% Generacion de ficheros de datos 
if ficheros_si == 1
    %Config data file
    conf_frec_por = quantizer([24 24],'saturate','floor');
    conf_im_fm = quantizer([16 16],'saturate','floor');
    conf_im_am = quantizer([16 15],'saturate','floor');
    fconf=sprintf([file_dir 'conf_datain_am.txt']); %cambiar a conf_datain_am para generación fichero AM
    pack_fc=fopen(fconf,'w');
    for i=1:length(s_in)
       %fprintf(pack_fc,[num2bin(conf_frec_por,frec_por*2^(-24)) ' ' num2bin(conf_im_fm,im_fm*2^(-16)) ' ' num2bin(conf_im_am,im_am*2^(-15)) ' ' num2str(control_fm_am) '\n']);
       fprintf(pack_fc,[num2str(frec_por) ' ' num2str(im_fm) ' ' num2str(im_am) ' ' num2str(control_fm_am) '\n']);
    end
    fclose(pack_fc);
    
    % Input data file
    i_data = quantizer([16 15],'saturate','floor');
    fi=sprintf([file_dir 'in_waves_idata.txt']);
    pack_fi=fopen(fi,'w');
    for i=1:length(s_in)
       fprintf(pack_fi,[num2bin(i_data ,s_in(i)) '\n']);
       %fprintf(pack_fi,[num2str(s_in(i)) '\n']);
    end
    fclose(pack_fi);

    %Output files
    if control_fm_am == 1
        % output files FM
        o_data_fm = quantizer([16 15],'saturate','floor');
        ff=sprintf([file_dir 'out_waves_fm.txt']);
        pack_ff=fopen(ff,'w');
        for i=1:length(s_fm)
           fprintf(pack_ff,[num2bin(o_data_fm ,s_fm(i)) '\n']);
        end
        fclose(pack_ff);
    end

    if control_fm_am == 0
        % output files AM
        o_data_am = quantizer([16 15],'saturate','floor');
        fa=sprintf([file_dir 'out_waves_am.txt']);
        pack_fa=fopen(fa,'w');
        for i=1:length(s_am)
           fprintf(pack_fa,[num2bin(o_data_am ,s_am(i)) '\n']);
        end
        fclose(pack_fa);
    end
    
end


