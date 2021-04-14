%any problem, contact at zhenzhongdong@gmail.com(valid before 7.1.2010)
%Zenzon Don 2010.5.3
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear;
clc;
close all;
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~ Arrange nodes and draw node distribution diagrams~~~~~~~~~~~~ ~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
cd 'Deploy Nodes'
square_random(1000,100,0.1);%GPS error of the layout node is 0
%square_random(1000,300,0.2,30) %GPS error is 30m
%C_random([1000,300,300,700],240,0.2);
%square_regular(1000,100,0.1,0.1);
%C_regular([1000,300,300,700],100,0.1,0.2);
Distribution_Of_WSN;%draw node distribution diagram
cd ..;
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~ Given a communication radius, select a communication model, calculate neighbor relationships, and draw neighbor relationship diagrams~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
cd 'Topology Of WSN';
comm_r=200; % given communication radius
% ~~~~~~~~~~~~~~~~~~ Choose a communication model~~~~~~~~~~~~~~~~
model='Regular Model';
%model='Logarithmic Attenuation Model';
%disp('Time may be longer...');model='DOI Model';DOI=0.015;
%disp('Time may be longer...');model='RIM Model';DOI=0.01;
% ~~~~~~~~~~~~~~~~~~Calculate neighbor relationship~~~~~~~~~~~~~~~~
anchor_comm_r=1;
% The anchor_comm_r parameter is only changed in APIT, and other algorithms are set to 1.
% It means that the communication radius of the anchor node is a multiple of half a catty for the unknown node communication.
% The WSN targeted by APIT is heterogeneous, and the communication radius of anchor nodes is larger than that of unknown nodes.
try
    calculate_neighbor(comm_r,anchor_comm_r,model,DOI);
catch
    calculate_neighbor(comm_r,anchor_comm_r,model);
end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Topology_Of_WSN;% Draw neighbor relationship diagram
cd ..;
load 'Deploy Nodes/coordinates.mat';
original_all_nodes = all_nodes;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~select positioning algorithm~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%cd Centroid;Centroid(20,0.9);%Centroid_second(20,0.9);%Centroid_third(...
%cd 'Bounding Box';Bounding_Box;%Bounding_Box_second;%Bounding_Box_third;
%cd 'Grid Scan';Grid_Scan(0.1*comm_r);%Grid_scan_second(...
%cd RSSI;RSSI;%RSSI_second;%RSSI_third;
%~~~~~~~~~~~~~~~~~~~~~~~~
%cd 'DV-hop';DV_hop;
algorithm = 'DV-hop';
cd(algorithm);DV_hop;
cd ..
%cd Amorphous;Amorphous;
%cd APIT;APIT(0.1*comm_r);
dist_available=true;cd 'MDS-MAP';MDS_MAP(dist_available);
cd ..
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~ Calculate positioning error, draw positioning error map~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd 'Localization Error'
calculate_localization_error(algorithm);
cd ..;

all_nodes = original_all_nodes;
save 'Deploy Nodes/coordinates.mat' all_nodes;
algorithm = 'Proposed Algorithm';
cd(algorithm);Proposed_algorithm;
cd ..
dist_available=true;cd 'MDS-MAP';MDS_MAP(dist_available);
cd ..
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~ Calculate positioning error, draw positioning error map~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd 'Localization Error'
calculate_localization_error(algorithm);
cd ..;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
