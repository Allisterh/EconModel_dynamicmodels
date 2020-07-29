//=======================================
// Chapter 4, RBC model, stochastic solution
//   modified on 2020/01/02
//=======================================

// 1. �����ϐ��A�O���ϐ��̐錾
var C L K Y w R A;
varexo e;

// 2. �p�����[�^�̐錾
parameters alpha beta delta mu gamma rho;

// �p�����[�^�l�̑��
alpha = 0.3;
beta = 0.99;
delta = 0.025;
mu = 1.0;
gamma = 1.0;
rho = 0.9;

// 3. �������̒�`
model;
exp(w)/exp(C) = (gamma+1)*mu*exp(L)^gamma;
exp(C(+1))/exp(C) = beta*(exp(R(+1))-delta);
exp(Y) = exp(A)*exp(K)^alpha*exp(L)^(1-alpha);
exp(w) = (1-alpha)*exp(A)*exp(K)^alpha*exp(L)^(-alpha);
exp(R)-1 = alpha*exp(A)*exp(K)^(alpha-1)*exp(L)^(1-alpha);
exp(K) = exp(Y(-1))+(1-delta)*exp(K(-1))-exp(C(-1));
A = rho*A(-1) + e;
end;

// 4. ����Ԃ̌v�Z
Astar = 1;
rstar = 1/beta + delta - 1;
K_L = (rstar/alpha/Astar)^(1/(alpha-1));
Y_L = Astar*K_L^alpha;
C_L = Y_L-delta*K_L;
wstar = (1-alpha)*Astar*K_L^alpha;
Lstar = (wstar/(gamma+1)/mu)^(1/(gamma+1))*C_L^(-1/(gamma+1));
Kstar = K_L*Lstar;
Ystar = Y_L*Lstar;
Cstar = C_L*Lstar;

// Dynare�ɒ���Ԃ��v�Z������ۂ̏����l
initval;
C = log(Cstar);
L = log(Lstar);
K = log(Kstar);
Y = log(Ystar);
w = log(wstar);
R = log(1+rstar);
A = log(Astar);
end;

// Dynare�ɒ���Ԃ��v�Z������
steady;

// �����l�ƌ��ʂ��ς��Ȃ����Ƃ��`�F�b�N
[log(Cstar); log(Lstar); log(Kstar); log(Ystar); log(wstar); log(rstar+1); log(Astar)]

// ���f���̃`�F�b�N
check;

// 5. �V�~�����[�V����(stochastic)
// �V�i���I�̐ݒ�
shocks;
var e = 1;
end;

// �V�~�����[�V�����̎��s
stoch_simul(order=1, irf = 100) C L K Y w R A;
