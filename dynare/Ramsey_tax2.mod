//=======================================
// Chapter 3, Ramsey model with tax 2
//   modified on 2020/01/02
//=======================================

// 1. �����ϐ��A�O���ϐ��̐錾
var C K;
varexo tauc tauk g;

// 2. �p�����[�^�̐錾
parameters alpha beta delta At;

// �p�����[�^�l�̑��
alpha = 0.3;
beta = 0.99;
delta = 0.25;
At = 1.0;

// 3. �������̒�`
model;
(1+tauc(+1))*C(+1)/(1+tauc)/C-beta*((1-tauk(+1))*alpha*At*K^(alpha-1)-delta+1) = 0;
K-At*K(-1)^alpha-(1-delta)*K(-1)+C+g = 0;
end;

// 4. �����l�̒�`
initval;
C = 1;
K = 1;
tauc = 0;
tauk = 0;
g = 0.1;
end;

steady;

// 5. �I�[�l�i����ԁj�̒�`
endval;
C = 1;
K = 1;
tauc = 0;
tauk = 0.1;
g = 0.1;
end;

steady;

// 6. ���f���̃`�F�b�N
check;

// 7. �V�~�����[�V�����̎��s
shocks;
var tauk; periods 1:9; values 0;
end;

simul(periods=31);

// �O���t�`��
figure(2)
subplot(2,1,1)
plot(0:30, C(1:31))
subplot(2,1,2)
plot(0:30, K(1:31))
