function DrawPoisson(x, y, z)
plot(x,z);
hold on
plot(y,z);
hold on;
grid on
set(gca, 'YDir', 'reverse');
xlabel('���ɱ�', 'fontsize', 18);
ylabel('����', 'fontsize', 18);
legend('��̬���ɱ�', '��̬���ɱ�');
end