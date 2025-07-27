clc, close all
% Cargar datos
load('Square_012.mat');

% Configuración de estilo de gráfica
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultLineLineWidth', 1.5);

% Posición deseada del índice
% Crear una figura con 4 subplots (4 filas y 1 columna)
figure;

% Subplot 1: Gráfica de y1 = sin(x)
subplot(4, 1, 1); % (filas, columnas, índice)
B = squeeze(Ref_track.signals.values);
plot(Ref_track.time, B);

xlabel('Time (s)');
ylabel('');
title('(a)');
grid on;


% Subplot 3: Gráfica de y3 = sin(2x)
subplot(4, 1, 2);
D =  P_tot.signals.values;
plot(P_tot.time, D);

xlabel('Time (s)');
ylabel('Avg Power (W)');
title('(b)');
grid on;

% Subplot 4: Gráfica de y4 = cos(2x)
subplot(4, 1, 3);
F = squeeze( Power_Error.signals.values);
plot( Power_Error.time, F);

xlabel('Time (s)');
ylabel('Avg Power (W)');
title('(c)');
grid on;

% Subplot 5: Gráfica de y4 = cos(2x)
subplot(4, 1, 4);
A = squeeze( FSR_force.signals.values);
plot( FSR_force.time, A);

xlabel('Time (s)');
ylabel('Force (N)');
title('(d)');
grid on;


% Crear una figura con 4 subplots (4 filas y 1 columna)
figure;

% Subplot 2: Gráfica de y2 = cos(x)
subplot(4, 1, 1);
Ci = squeeze(pos_vastagoind.signals.values);
plot(pos_vastagoind.time, Ci);

xlabel('Time (s)');
ylabel('Position (mm)');
title('(a)');
grid on;

% Subplot 2: Gráfica de y2 = cos(x)
subplot(4, 1, 2);
Cm = squeeze(pos_vastagomed.signals.values);
plot(pos_vastagoind.time, Cm);

xlabel('Time (s)');
ylabel('Position (mm)');
title('(b)');
grid on;

% Subplot 2: Gráfica de y2 = cos(x)
subplot(4, 1, 3);
Ca = squeeze(pos_vastagoanul.signals.values);
plot(pos_vastagoind.time, Ca);

xlabel('Time (s)');
ylabel('Position (mm)');
title('(c)');
grid on;

% Subplot 2: Gráfica de y2 = cos(x)
subplot(4, 1, 4);
Cp = squeeze(pos_vastagopul.signals.values);
plot(pos_vastagoind.time, Cp);

xlabel('Time (s)');
ylabel('Position (mm)');
title('(d)');
grid on;
