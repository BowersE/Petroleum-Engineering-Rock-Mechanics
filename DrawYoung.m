function DrawYoung(x, y, z)
plot(x,z);
hold on
plot(y,z);
hold on;
grid on
set(gca, 'YDir', 'reverse');
xlabel('����ģ��', 'fontsize', 18);
ylabel('����', 'fontsize', 18);
legend('��̬����ģ��', '��̬����ģ��');
end