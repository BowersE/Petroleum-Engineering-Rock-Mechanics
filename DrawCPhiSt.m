function DrawCPhiSt(C, phi_all, S_t, DP)
plot(C, DP)
hold on
plot(phi_all, DP);
hold on 
plot(S_t, DP,'r');
set(gca, 'YDir', 'reverse');
grid on
xlabel('ճ��������Ħ������ز㿹��ǿ��', 'fontsize', 18);
ylabel('����', 'fontsize', 18);
legend('ճ����','��Ħ����','�ز㿹��ǿ��');
end