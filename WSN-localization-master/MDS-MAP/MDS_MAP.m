function MDS_MAP(dist_available)
% MDS_MAP Alg.
% dist_available:Whether the distance between nodes can be true-available false-unavailable
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    load '../Deploy Nodes/coordinates.mat';
    load '../Topology Of WSN/neighbor.mat'; 
    if all_nodes.anchors_n<3
        disp('Anchor nodes are less than 3, the MDS_MAP algorithm cannot be executed ');
        return;
    end
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    %shortest_path_hop: adjacency matrix in hop count
    %shortest_path_dist:adjacency matrix in distance
    %shortest_path:When the distance is measurable, it is equal to shortest_path_dist; otherwise, it is shortest_path_hop
    shortest_path_hop=neighbor_matrix;
    shortest_path_hop=shortest_path_hop+eye(all_nodes.nodes_n)*2;
    shortest_path_hop(shortest_path_hop==0)=Inf;
    shortest_path_hop(shortest_path_hop==2)=0;
    directory=cd;
    cd(['../Topology Of WSN/Transmission Model/',model]);
    shortest_path_dist=ones(size(neighbor_rss));
    try
        shortest_path_dist(neighbor_matrix==1)=rss2dist(neighbor_rss(neighbor_matrix==1),1);
    catch
        shortest_path_dist(neighbor_matrix==1)=rss2dist(neighbor_rss(neighbor_matrix==1));
    end
    shortest_path_dist=shortest_path_dist-eye(size(neighbor_rss));
    shortest_path_dist(shortest_path_dist==1)=Inf;
    cd(directory);
    if dist_available
        shortest_path=shortest_path_dist;
    else
        shortest_path=shortest_path_hop;
    end
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    %Execute Floyd algorithm to calculate the shortest distance between any two points (according to dist_available, in hops or distance)
    for k=1:all_nodes.nodes_n
        for i=1:all_nodes.nodes_n
            for j=1:all_nodes.nodes_n
                if shortest_path(i,k)+shortest_path(k,j)<shortest_path(i,j)%min(h(i,j),h(i,k)+h(k,j))
                    shortest_path(i,j)=shortest_path(i,k)+shortest_path(k,j);
                end
            end
        end
    end
    if length(find(shortest_path==Inf))~=0
        disp('The network is not connected...the connected subgraph needs to be divided...this situation is not considered here ');
        return;
    end
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    % Perform the MDS method on the shortest distance matrix shortest_path
    J=eye(all_nodes.nodes_n)-ones(all_nodes.nodes_n)/all_nodes.nodes_n;
    H=-0.5*J*shortest_path.^2*J;
    [V S T]=svd(H);
    X=T*sqrt(S);
    relative_map=X(:,1:2);
    save maps_and_all_nodes.mat relative_map all_nodes;    
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    warning off;
    disp('The time may be long, please wait ' );
    disp(' If you are still running when you come back, you can adjust the parameters, increase the parameters behind TolX and TolFun by e.g0.01, and change MaxIter and MaxFunEvals to 10000 ');
    [q r]=fsolve('relative_to_absolute',[1,1,0,0,all_nodes.square_L/2,all_nodes.square_L/2],optimset('Display','off','TolX',0.001,'TolFun',0.001,'MaxIter',inf,'MaxFunEvals',inf));
    q
    absolute_map=relative_map*[q(1)*cos(q(3)) q(2)*sin(q(4));-q(1)*sin(q(3)) q(2)*cos(q(4))]+repmat([q(5) q(6)],all_nodes.nodes_n,1);
    save maps_and_all_nodes.mat absolute_map -APPEND;
    all_nodes.estimated(all_nodes.anchors_n+1:all_nodes.nodes_n,:)=absolute_map(all_nodes.anchors_n+1:all_nodes.nodes_n,:);
    all_nodes.anc_flag(all_nodes.anchors_n+1:all_nodes.nodes_n)=2;
    save '../Localization Error/result.mat' all_nodes comm_r;
end 
