clc, clear, close all
load('p4.mat')
figure

%% Filtro
L = 30;
b = (1/L)*ones(1,L);

%% Voltaje
%V = squeeze(out.RandomPWM.signals.values);
V_ZOH_s = squeeze(out.PWM_ZOH.signals.values);
%V_ZOH = repelem(V_ZOH_s,30);
V_ZOH = interp1(V_ZOH_s,out.PWM_ZOH.time,out.Corriente.time);

%V_pulg = out.PWM_pulg.signals.values;
%% Corrientes [indice,medio,anular,pulgar]
I_pulg = out.Corriente.signals.values(:,4);
I_anul = out.Corriente.signals.values(:,3);
I_med = out.Corriente.signals.values(:,2);
I_ind = out.Corriente.signals.values(:,1);
I = I_pulg + I_anul + I_med + I_ind;
I = I/1000;
V_ZOH = V_ZOH*12/255;

%% Vector de tiempo
t = 0:0.1:(length(I_pulg)-1)*0.1;
t = t';
%% Potencia instantanea
% Pulgar
P_pulg = V_ZOH.*I_pulg/1000;
%P_pulg(P_pulg>0)= 0;

% Anular
P_anul = V_ZOH.*I_anul/1000;
%P_anul(P_anul>0)= 0;

% Medio
P_med = V_ZOH.*I_med/1000;
%P_med(P_med>0)= 0;

% Indice
P_ind = V_ZOH.*I_ind/1000;
%P_ind(P_ind>0)= 0;

% Potencia total
% Pulgar
P = P_pulg + P_anul + P_med + P_ind;

%% Potencia promedio
% filtro FIR ventana rectangular
PAV = filter(b,1,P);
% fiiltro exponencial
Tau = 10; % numero de muestras de retardo
alpha = 1/(1+Tau);
PAV2 = filter(alpha, [1 alpha-1], P);
%% Umbral de corriente
I_umb = max(I)*0.1;
index = find(I<I_umb);


%% Fuerza de agarre

F = sum(out.FSR.signals.values,2);

plot(t,F,t,PAV2,t,I)
title('Open loop experiment');
legend('Force (N)','Total Power avg (W)','Total current (A)')
xlabel('Time (s)');
ylabel('Amplitude');
xlim ([0, 51])
ylim auto

%% Estimación de modelo
Ts = 0.1; % Periodo de muestreo
data2 = iddata(F,PAV,Ts);
[data2_d,Tr] = detrend(data2);
figure
plot(data2,data2_d)
legend('Original Data','Detrended Data')

%% Medida de similitud

% Cálculo de la correlación cruzada
[correlation, lags] = xcorr(F, PAV);
figure;
stem(lags, correlation, 'LineWidth', 1.5);
grid on;
title('Correlación cruzada entre F y PAV');
xlabel('Desfase (lags)');
ylabel('Amplitud de la correlación');

% Cálculo de la correlación cruzada
[correlation, lags] = xcorr(F, I);
figure;
stem(lags, correlation, 'LineWidth', 1.5);
grid on;
title('Cross correlation Force and Current');
xlabel('lags');
ylabel('Amplitude');
xlim auto
ylim ([-2, 90])

% Cálculo de la correlación cruzada
[correlation, lags] = xcorr(F, PAV2);
figure;
stem(lags, correlation, 'LineWidth', 1.5);
grid on;
title('Cross correlation Force and Power');
xlabel('lags');
ylabel('Amplitude');
xlim auto
ylim ([-2, 120])

%% Otros datos para soportar correlacion
F = dtrend(F);
% Ajuste de modelo lineal salida F, entrada PAV
modelo_Pow = fitlm(PAV2,F);

% Ajuste de modelo lineal salida F, entrada I
modelo_I = fitlm(I,F);

% Comparación de las predicciones

% Predicciones del modelo según la PAV
F_est_pow = predict(modelo_Pow,PAV2);
F_est_pow = dtrend(F_est_pow);
% Predicciones del modelo según la I
F_est_I = predict(modelo_I, I);
F_est_I = dtrend(F_est_I);
figure
plot(t,F,t,F_est_pow,t,F_est_I)
title('Model predictions based on average power');
legend('Force','Force from power','Force from current')
xlabel('Time (s)');
ylabel('Amplitude');
xlim ([0, 51])
ylim auto
grid on
% Cálculo del coeficiente de determinación R^2 ajustado

r2_pow = modelo_Pow.Rsquared.Adjusted;
r2_I = modelo_I.Rsquared.Adjusted;

disp(['R2 desde PAV: ',num2str(r2_pow),' R2 desde I: ',num2str(r2_I)])

%% Estadística acerca del seguimiento de consigna del error de potencia promedio
% Carga señales de error
load('sin_03.mat')
error_sin = Power_Error.signals.values;
load('Square_012.mat')
error_sqr = Power_Error.signals.values;

% Estadísticas del error seguimiento senoidal

rmse_sin = sqrt(mean(error_sin.^2));
media_error_sin = mean(error_sin);
desv_error_sin = std(error_sin);

disp(['rmse_sin: ',num2str(rmse_sin),' media_sin: ',...
    num2str(media_error_sin), ' desv_error_sin: ',num2str(desv_error_sin)])

% Estadísticas del error seguimiento senoidal

rmse_sqr = sqrt(mean(error_sqr.^2));
media_error_sqr = mean(error_sqr);
desv_error_sqr = std(error_sqr);

disp(['rmse_sqr: ',num2str(rmse_sqr),' media_sqr: ',...
    num2str(media_error_sqr), ' desv_error_sqr: ',num2str(desv_error_sqr)])


%% Modelo para el lazo cerrado

F = FSR_force.signals.values(1,:);
F = F';
P = P_tot.signals.values;
F = dtrend(F);
t = 0:0.1:(length(F)-1)*0.1;
t = t';
% Ajuste de modelo lineal salida F, entrada PAV
%modelo_Pow = fitlm(P,F);
F_est_pow = predict(modelo_Pow,P);
F_est_pow = dtrend(F_est_pow);
figure
plot(t,F,t,F_est_pow)
legend('F real','F desde PAV')
grid on