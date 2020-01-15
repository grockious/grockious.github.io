%this scrpit initializes the simulation parameters
%copyrigh (c) University of Oxford

clc
clear all
close all

%%Defining the area 
X=linspace(1,40,40);
Y=linspace(1,40,40)';
[x,y]=meshgrid(X,Y);

%%Reward function
r=zeros(40,40,3);
r(:,:,2)=100;

%%Quality function
f=ones(40,40,3);
f(:,:,3)=0;

%%Q function
Q=ones(40,40,3);

%%Discount Factor and Step Size
discount_factor=0.9;
alpha=0.75;

%%Assignment matrix
u=ones(40,40);
u(1:5,1:5)=4;
u(6:35,6:35)=3;
u(16:25,16:25)=2;
u(26:35,19:22)=1;
