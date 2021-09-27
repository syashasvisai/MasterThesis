clc;clear all;close all;
Ts = 0.005;
Tsim = 17;
t = 0:Ts:Tsim;
%% KMPC
load data_3s.mat

x1 = XX_koop3';
x1_ref = ref60;

load data_1point5s.mat 

x2 = XX_koop3';
x2_ref = ref58;

load data_1s.mat

x3 = XX_koop3';
x3_ref = ref54;
%%
plotComparediffTraj(x1,x2,x3,x1_ref,x2_ref,x3_ref,t,Ts)


%% qLMPC
load data_qLMPC_3s.mat

x1 = x;
x1_ref = ref60;

load data_qLMPC_1point5s.mat 

x2 = x;
x2_ref = ref60;

load data_qLMPC_1s.mat

x3 = x;
x3_ref = ref60;

plotComparediffTraj_qLMPC(x1,x2,x3,x1_ref,x2_ref,x3_ref,t,Ts)
