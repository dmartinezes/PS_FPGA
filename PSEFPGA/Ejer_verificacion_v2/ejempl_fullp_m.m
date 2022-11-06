% Numero de datos a verificar
num_datos = 10;

% Formato de entrada 
Win = 8; % # bits de la entrada
Win_f = Win-1; % # bits fraccionale de la entrada

% Generacion aleatoria de numeros
a=[-2^(Win-1) randi([-2^(Win-1),2^(Win-1)-1],1,num_datos-1)]*2^-(Win_f);
b=[-2^(Win-1) randi([-2^(Win-1),2^(Win-1)-1],1,num_datos-1)]*2^-(Win_f);
c=[2^(Win-1)-1 randi([-2^(Win-1),2^(Win-1)-1],1,num_datos-1)]*2^-(Win_f);

q_in = quantizer([Win Win_f],'fixed','wrap','floor');
a = quantize(q_in,a);
b = quantize(q_in,b);
c = quantize(q_in,c);

display('Entradas a b c');
[a' b' c']*2^Win_f

%% Modelo Matlab 1: usando la función floor
s1=zeros(1,num_datos);
for i = 1:num_datos
    s1(i) = a(i)*b(i)+c(i);
end
%% Modelo Matlab 2: usando el objeto quantizer


%% Modelo Simulink

sim('ejemp_fullp');
s3 = s_out(1:end-1);

display('salidas s');
[s1']*2^(2*Win_f)

%% Escritura de ficheros de datos de entrada
q_in = quantizer([Win Win_f],'fixed','wrap','floor');
aq = quantize(q_in,a);
bq = quantize(q_in,b);
cq = quantize(q_in,c);

f=sprintf(['datos_in.txt']);
pack_f=fopen(f,'w');

for i=1:length(a)
   fprintf(pack_f,[num2bin(q_in,aq(i)) ' ' num2bin(q_in,bq(i)) ' ' num2bin(q_in,cq(i)) '\n']);
end
fclose(pack_f);

%% Escritura de ficheros de datos de salida
q_out=quantizer([2*Win 2*Win_f],'fixed','wrap','floor');
%s=(a.*b+c);

sq = quantize(q_out,s3);

f=sprintf(['datos_out.txt']);
pack_f=fopen(f,'w');

for i=1:length(sq)
   fprintf(pack_f,[num2bin(q_out,sq(i)) '\n']);
end
%fprintf(pack_f,num2str(0));
fclose(pack_f);
