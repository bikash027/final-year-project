% Zenzon Don  5.15.2010
% ��MDS�õ����м���ͼ--relative map
% ��relative map����MAP��õ������ս��ͼ--absolute map
% �ڵ����ʵ�ֲ�ͼ����'../Deploy Nodes/Distribution_Of_WSN.m'
% ��λ�Ľ��ͼ����'../Localization Error/calculate_localization_error.m'
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

load maps_and_all_nodes.mat;
figure;%��relative map
hold on; 
plot(relative_map(1:all_nodes.anchors_n,1),relative_map(1:all_nodes.anchors_n,2),'r*');
plot(relative_map(all_nodes.anchors_n+1:all_nodes.nodes_n,1),relative_map(all_nodes.anchors_n+1:all_nodes.nodes_n,2),'bo');
title('relative map');

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

figure;%��absolute map
hold on; 
plot(absolute_map(1:all_nodes.anchors_n,1),absolute_map(1:all_nodes.anchors_n,2),'r*');
plot(transpose([absolute_map(1:all_nodes.anchors_n,1),all_nodes.estimated(1:all_nodes.anchors_n,1)]),...
    transpose([absolute_map(1:all_nodes.anchors_n,2),all_nodes.estimated(1:all_nodes.anchors_n,2)]),'r-');
plot(absolute_map(all_nodes.anchors_n+1:all_nodes.nodes_n,1),absolute_map(all_nodes.anchors_n+1:all_nodes.nodes_n,2),'bo');
title('absolute map');
disp('absolute map�к��߱�ʾê�ڵ���absolute map�е�����������ʵ�����ƫ��');