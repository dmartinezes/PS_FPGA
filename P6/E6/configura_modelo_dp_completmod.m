clear all
close all
warning ('off','all');
 
%%
sim_time = 2000;
%% MOD AM/FM CONFIGURATION

% Control FM --> 1, AM --> 0
control_fm_am=1;

% Sampling frequency (MHz)
fsc=100; % MHz

% Carrier frequency (MHz)
fc=1; % MHz

% AM modulation index (range [0,1[)
m_am=1*(1-2^-15);

% FM modulation index (kHz)
Kfm=5000; % kHz

% Modulator source signal: SIN ->0; RAMP->1; SQR->2;
source_sel = 0;

% Modulating frequency (kHz)
fmod= 1; % kHz


conf_mod_filter_design

%% Simulink
sim('modelo_dp_completmod');

%% Verilog simulation values
frec_por = round(fc/fsc*2^24);
im_am = round(m_am*2^15);
im_fm = round(Kfm*1e-3/fsc*2^16);
Pfrec_mod = round(2^Macc*fmod*1e-3/(fsc/f_interpolacion));
disp(' ')
disp('*****************************************')
disp('Values for HDL simulation')
disp('*****************************************')
disp(['c_fm_am = ' num2str(control_fm_am)])
disp(['c_source = ' num2str(source_sel)])
disp(['frec_mod = ' num2str(Pfrec_mod)])
disp(['frec_por = ' num2str(frec_por)])
disp(['im_am = ' num2str(im_am)])
disp(['im_fm = ' num2str(im_fm)])
disp('*****************************************')

%% Generacion de ficheros de datos

file_dir = './';
%Output files
    if control_fm_am == 1
        % output files FM
        o_data_fm = quantizer([14 13],'saturate','floor');
        ff=sprintf([file_dir 'out_waves_fm.txt']);
        pack_ff=fopen(ff,'w');
        for i=1:length(s_dp_fmam)
           fprintf(pack_ff,[num2bin(o_data_fm ,s_dp_fmam(i)) '\n']);
        end
        fclose(pack_ff);
    end

    if control_fm_am == 0
        % output files AM
        o_data_am = quantizer([14 13],'saturate','floor');
        fa=sprintf([file_dir 'out_waves_am.txt']);
        pack_fa=fopen(fa,'w');
        for i=1:length(s_dp_fmam)
           fprintf(pack_fa,[num2bin(o_data_am ,s_dp_fmam(i)) '\n']);
        end
        fclose(pack_fa);
    end

