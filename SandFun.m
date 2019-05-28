function B = SandFun(E, P, DP)
B = E./(3*(1-2*P)) + 2*E./(3*(1+P));
m = length(DP);
plot(B, DP);
hold on
plot([2e4, 2e4],[1500, 4500],'LineWidth',3);
hold on
plot([1.4e4, 1.4e4],[1500, 4500],'LineWidth',3);
xlabel('��ɳ', 'fontsize', 18);
ylabel('����', 'fontsize', 18);
set(gca, 'YDir', 'reverse');
legend('Bָ��','΢����ɳ�ֽ���','���س�ɳ�ֽ���');
end