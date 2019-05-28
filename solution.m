clear all;
clc;
%% ==================== ������ȡ =================================
DP = xlsread('A���⾮�������꾮Һ�ܶ�','�⾮����', 'B1:B2502');%���
GR = xlsread('A���⾮�������꾮Һ�ܶ�','�⾮����', 'E1:E2502');%Ŀ�Ĳ���Ȼ٤��ֵ
delta_tp = xlsread('A���⾮�������꾮Һ�ܶ�','�⾮����', 'F1:F2502');%����
rho_rock = xlsread('A���⾮�������꾮Һ�ܶ�','�⾮����', 'G1:G2502');%��ʯ�ܶ�
G_0 = xlsread('A���⾮�������꾮Һ�ܶ�','�⾮����', 'M1:M2502');%�ϸ��Ҳ�ѹ���ݶ�
%% ==================== �����ز�ز����ʺ��� =======================
GRmax = 120;
GRmin = 60;
I_GR = (GR-GRmin)/(GRmax-GRmin);
GCUR = 3.7;
VCL = (power(2,(GCUR*I_GR)-1))./(power(2,(GCUR)-1));
figure1(VCL, DP);
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== ��̬/��̬����ģ���Ͳ��ɱ� ==================
[E_d, Poisson_d] = DynamicsEv(delta_tp, rho_rock); 
[E_s, Poisson_s] = StaticsEv(G_0, DP, E_d, Poisson_d);
hold off
DrawYoung(E_d, E_s, DP);
fprintf('Program paused. Press enter to continue.\n');
pause;
hold off
DrawPoisson(Poisson_d, Poisson_s, DP);
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== ����Biotϵ���뾮��Ĺ�ϵ ===================
hold off
Boit = figure2(VCL, DP);
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== �ϸ��Ҳ�ѹ���Ĳ������ =====================
%ʹ��cftool���������.��Ϻ�����y = a + b*x - c*exp(-d*x)������:x=DP��y=G_0
%% ==================== �ϸ��Ҳ�ѹ�� ==============================
% ��Ϲ�ʽ G_0(x) = 2.155 + 0.00000408*x - 0.1189*exp(-0.7577*x)
[P_0, P_n] = Overburden(DP, G_0);
rho_Sdf = DrillingFluid(rho_df, Depth, DP);
[P_p, Pp] = PorePressure(G_0, P_0, DP,rho_Sdf, delta_tp);
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== ����ʱ�� =================================
DrawSDT(delta_tp, DP);
%% ==================== ճ��������Ħ���� ==========================
sigma_1 = [39.5 146.4 215.4;50.6 155.2 201.4;52.5 148.2 187.7;18.4 97.5 128.5];
sigma_3 = [0 20 40;0 20 40;0 20 40;0 20 40;];
%������ϣ�sigma_1 = (tan(beta))^2*sigma_3 + 2*C*tan(beta)
for i=1:size(sigma_1,1)
    x = sigma_3(i,:);
    y = sigma_1(i,:);
    p = polyfit(x, y, 1);
    P(i,:) =p;
end
for i=1:size(P,1)
    tan_beta(i) = sqrt(P(i,1));
    phi(i) = (atan(tan_beta(i))-pi/4)*360/pi;
    C(i) = P(i,2)/2/tan_beta(i);
end
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== ճ��������Ħ������ز㿹��ǿ�ȵ��������� =====
C = Cohesion(Poisson_d, rho_rock, delta_tp, VCL);%a, b, a_1, b_1��Ϊ��ʯ�йس�����
a = 2.654;   b = 20;   a_1 = 58.93;   b_1 = 1.785;
phi_all = PhiFun(C, a, b, a_1, b_1);
K_tc = 15;
S_t = StFun(E_d, VCL, K_tc);
DrawCPhiSt(C, phi_all, S_t, DP);
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== ˮƽ�����С��Ӧ�� =======================
[sigma_H, sigma_h] = HorizontalStress(DP, Poisson_s, G_0, VCL, P_p);
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== ��ȫ�ཬ�ܶȴ��� ==========================
[P_b, P_f] = SafetyFun(sigma_H, sigma_h, phi_all, C, P_p, DP, S_t, Boit);
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== ��ɰ�����Է��� ============================
B = SandFun(E_d, Poisson_d, DP);
fprintf('Program paused. Press enter to continue.\n');
pause;
%% ==================== ����ѹ�� =================================
[P_fmax, P_fmin] = IniPressure(DP, rho_rock, sigma_H, sigma_h, Boit, P_p, S_t);
fprintf('Program paused. Press enter to continue.\n');
pause;