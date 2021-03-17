load '../Deploy Nodes/coordinates.mat';
load neighbor.mat;
figure;
hold on;
box on;
for i=1:all_nodes.nodes_n
    for j=i+1:all_nodes.nodes_n
        if neighbor_matrix(i,j)==1
            plot(all_nodes.true([i,j],1),all_nodes.true([i,j],2),'-b');
        end
    end
end
plot(all_nodes.true(all_nodes.anchors_n+1:all_nodes.nodes_n,1),all_nodes.true(all_nodes.anchors_n+1:all_nodes.nodes_n,2),'ro');
plot(all_nodes.true(1:all_nodes.anchors_n,1),all_nodes.true(1:all_nodes.anchors_n,2),'r*');
axis([0,all_nodes.square_L,0,all_nodes.square_L]);
title('Neighbor Relationship Diagram ');
disp('~~~~~~~~~~~~~~~~~~~~~~~~Neighbor Relationship Graph~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp([num2str(all_nodes.nodes_n),'nodes,','where',num2str(all_nodes.anchors_n),'anchor nodes']);
disp(' Red* means anchor node, red O means unknown node ');
disp(['Communication radius:',num2str(comm_r),'m']);
disp(['Communication radius of anchor node:',num2str(comm_r*anchor_comm_r),'m']);
disp(['Communication model:',model]);
try
    disp(['DOI=',num2str(DOI)]);
catch
    %none
end
if anchor_comm_r==1
    disp([' The average connectivity of the network is:',num2str(sum(sum(neighbor_matrix))/all_nodes.nodes_n)]);
    disp(['The average number of neighbor anchor nodes in the network is:',num2str(sum(sum(neighbor_matrix(1:all_nodes.nodes_n,1:all_nodes.anchors_n)))/all_nodes.nodes_n)]);
else
    disp(['The average number of anchor nodes that an unknown node can hear is: ',num2str(sum(sum(neighbor_matrix(all_nodes.anchors_n+1:all_nodes.nodes_n,1:all_nodes.anchors_n)))/(all_nodes.nodes_n-all_nodes.anchors_n))]);
    disp(['The average number of unknown nodes in the unknown node communication area is:',num2str(sum(sum(neighbor_matrix(all_nodes.anchors_n+1:all_nodes.nodes_n,all_nodes.anchors_n+1:all_nodes.nodes_n)))/(all_nodes.nodes_n-all_nodes.anchors_n))]); 
end

