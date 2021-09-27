clc; clear all; close all;
%% Data with dist.
data1 = load('chirp1.mat');
data2 = load('chirp2.mat');
data3 = load('chirp3.mat');
data4 = load('chirp4.mat');
data5 = load('chirp5.mat');
data6 = load('chirp6.mat');
data7 = load('chirp7.mat');
data8 = load('chirp8.mat');
data9 = load('chirp9.mat');
data10 = load('chirp10.mat');
data11 = load('chirp11.mat');
data12 = load('chirp12.mat');
% data13 = load('chirp13.mat');
% data14 = load('chirp14.mat');
% data15 = load('chirp15.mat');
% data16 = load('chirp16.mat');
% data17 = load('data_freefall.mat');
% data18 = load('MPCdata_18.mat');
% data19 = load('MPCdata_19.mat');
% data20 = load('MPCdata_20.mat');
% data23 = load('MPCdata_23.mat');
% data24 = load('MPCdata_24.mat');
% data25 = load('MPCdata_25.mat');
% data26 = load('MPCdata_26.mat');

x  = [data1.x ;data2.x ;data3.x ;data4.x; data5.x; data6.x; data7.x; data8.x ; data9.x; data10.x];
%;...
 %   data11.x ;data12.x; data13.x ;data14.x; data15.x; data16.x; data17.x];
%data15.x; data16.x; data17.x; data18.x; data19.x; data20.x data23.x; data24.x; data25.x; data26.x];
dx = [data1.dx ;data2.dx ;data3.dx ;data4.dx; data5.dx; data6.dx; data7.dx; data8.dx ; data9.dx; data10.dx];
u  = [data1.u ;data2.u ;data3.u ;data4.u; data5.u; data6.u; data7.u; data8.u;...
    data9.u; data10.u];
% ; data11.u ;data12.u; data13.u;data14.u; data15.u; data16.u; data17.u];...
%     ; data17.u; data18.u; data19.u; data20.u data23.u; data24.u; data25.u; data26.u ];

save data_fixed_freefall.mat x dx u