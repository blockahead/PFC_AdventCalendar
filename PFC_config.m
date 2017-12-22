close all;
clear;

% �T���v�����O���� (s)
dSamplingPeriod = 0.1;

% �V�X�e���̒�`
sys = tf( [ 1 ], [ 1, 2*0.5, 1 ] );
sysc = ss( sys );
sysd = c2d( sysc ,dSamplingPeriod );

figure( 'Name', 'Basis function', 'NumberTitle', 'off', 'Position', [0,100,600,800] );

%% �Œ�l�̌v�Z
% �V�X�e���ϐ�
Ad = sysd.a;
Bd = sysd.b;
Cd = sysd.c;
Dd = sysd.d;

% �ڕW���[�v�������� (s)
TCLRT = 1.0;

% ���������̏�����
SF = zeros( 3, 3 );

%% �ЂƂ߂̈�v�_�ł̋�������
h = ceil( TCLRT / ( dSamplingPeriod * 3 ) );

buff1 = zeros( length( Cd(:,1) ), h );
buff2 = eye( size( Ad ) );

for cnt = 1:h
    buff1(:,h-cnt+1) = Cd * buff2 * Bd;
    buff2 = buff2 * Ad;
end

Time = ( 0:dSamplingPeriod:( ( h - 1 ) * dSamplingPeriod ) )';

% �X�e�b�v����
U0 = Time.^0;
G0 = buff1 * U0;

% �����v����
U1 = Time.^1;
G1 = buff1 * U1;

% �p���{������
U2 = Time.^2;
G2 = buff1 * U2;

SF(1,:) = [ G0, G1, G2 ];

subplot( 3, 1, 1 );
scatter( h * dSamplingPeriod, G0, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' ); hold on;

subplot( 3, 1, 2 );
scatter( h * dSamplingPeriod, G1, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' ); hold on;

subplot( 3, 1, 3 );
scatter( h * dSamplingPeriod, G2, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' ); hold on;


%% �ӂ��߂̈�v�_�ł̋�������
h = ceil( TCLRT / ( dSamplingPeriod * 2 ) );

buff1 = zeros( length( Cd(:,1) ), h );
buff2 = eye( size( Ad ) );

for cnt = 1:h
    buff1(:,h-cnt+1) = Cd * buff2 * Bd;
    buff2 = buff2 * Ad;
end

Time = ( 0:dSamplingPeriod:( ( h - 1 ) * dSamplingPeriod ) )';

% �X�e�b�v����
U0 = Time.^0;
G0 = buff1 * U0;

% �����v����
U1 = Time.^1;
G1 = buff1 * U1;

% �p���{������
U2 = Time.^2;
G2 = buff1 * U2;

SF(2,:) = [ G0, G1, G2 ];

subplot( 3, 1, 1 );
scatter( h * dSamplingPeriod, G0, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' );

subplot( 3, 1, 2 );
scatter( h * dSamplingPeriod, G1, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' );

subplot( 3, 1, 3 );
scatter( h * dSamplingPeriod, G2, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' );

%% �݂��߂̈�v�_�ł̋�������
h = ceil( TCLRT / ( dSamplingPeriod * 1 ) );

buff1 = zeros( length( Cd(:,1) ), h );
buff2 = eye( size( Ad ) );

for cnt = 1:h
    buff1(:,h-cnt+1) = Cd * buff2 * Bd;
    buff2 = buff2 * Ad;
end

Time = ( 0:dSamplingPeriod:( ( h - 1 ) * dSamplingPeriod ) )';

% �X�e�b�v����
U0 = Time.^0;
G0 = buff1 * U0;

% �����v����
U1 = Time.^1;
G1 = buff1 * U1;

% �p���{������
U2 = Time.^2;
G2 = buff1 * U2;

SF(3,:) = [ G0, G1, G2 ];

subplot( 3, 1, 1 );
scatter( h * dSamplingPeriod, G0, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' );

subplot( 3, 1, 2 );
scatter( h * dSamplingPeriod, G1, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' );

subplot( 3, 1, 3 );
scatter( h * dSamplingPeriod, G2, 'MarkerFaceColor', [0.0,0.0,1.0], 'MarkerEdgeColor', 'None' );

%% �v�Z�ŏo�������������ƃV�~�����[�V�������ʂ��r
sim( 'BasisFunction' );

subplot( 3, 1, 1 );
plot( Output(:,1), Output(:,2), 'Color', [0.5,0.5,0.5] );
plot( Output(:,1), Output(:,3), 'Color', [1.0,0.0,0.0] );
title('zero order function G_0(h_1, h_2, h_3)');

subplot( 3, 1, 2 );
plot( Output(:,1), Output(:,4), 'Color', [0.5,0.5,0.5] );
plot( Output(:,1), Output(:,5), 'Color', [1.0,0.0,0.0] );
title('1st order function G_1(h_1, h_2, h_3)');

subplot( 3, 1, 3 );
plot( Output(:,1), Output(:,6), 'Color', [0.5,0.5,0.5] );
plot( Output(:,1), Output(:,7), 'Color', [1.0,0.0,0.0] );
title('2nd order function G_2(h_1, h_2, h_3)');

%% PFC�̎��s
figure( 'Name', 'PFC result', 'NumberTitle', 'off', 'Position', [650,100,600,800] );

SWITCH = 1;
sim( 'PFC' );
subplot( 2, 1, 1 );
plot( PFC_Output(:,1), PFC_Output(:,2), 'Color', [0.5,0.5,0.5] ); hold on;
plot( PFC_Output(:,1), PFC_Output(:,3), 'Color', [1.0,0.0,0.0] );
title('Step result');

SWITCH = 0;
sim( 'PFC' );
subplot( 2, 1, 2 );
plot( PFC_Output(:,1), PFC_Output(:,2), 'Color', [0.5,0.5,0.5] ); hold on;
plot( PFC_Output(:,1), PFC_Output(:,3), 'Color', [1.0,0.0,0.0] );
title('Sine result');

%% PFC�̎��s�i�ʑ��⏞�j
figure( 'Name', 'PFC_FutureSetpoint result', 'NumberTitle', 'off', 'Position', [1300,100,600,800] );

SWITCH = 1;
sim( 'PFC_FutureSetpoint' );
subplot( 2, 1, 1 );
plot( PFC_Output(:,1), PFC_Output(:,2), 'Color', [0.5,0.5,0.5] ); hold on;
plot( PFC_Output(:,1), PFC_Output(:,3), 'Color', [1.0,0.0,0.0] );
title('Step result');

SWITCH = 0;
sim( 'PFC_FutureSetpoint' );
subplot( 2, 1, 2 );
plot( PFC_Output(:,1), PFC_Output(:,2), 'Color', [0.5,0.5,0.5] ); hold on;
plot( PFC_Output(:,1), PFC_Output(:,3), 'Color', [1.0,0.0,0.0] );
title('Sine result');