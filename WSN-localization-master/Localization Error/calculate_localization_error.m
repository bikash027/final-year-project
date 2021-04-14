function [Localization_error,Unresolve_num]=calculate_localization_error(algorithm)
% Draw the positioning result diagram of the positioning algorithm
% There is no positioning error for the anchor node, which is indicated by red *,
% Unknown nodes can be located (blue O indicates the estimated position of these nodes, blue-indicates the error from the estimated position of these nodes to the true position)
% Some unknown nodes cannot be located (black O means that these nodes have no positioning error)
% Localization_error:Average positioning error-the ratio of the Euclidean distance from the estimated position to the real position and the communication radius
% Unresolved_num:There are some isolated points in the network or they cannot be located because of few neighbors. The number of these points
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    load result.mat;
    figure;
    hold on;
    box on;
    plot(all_nodes.true(1:all_nodes.anchors_n,1),all_nodes.true(1:all_nodes.anchors_n,2),'r*');%the anchors
    Unresolved_unknown_nodes_index=find(all_nodes.anc_flag==0);%the unresolved unknown nodes
    Unresolved_num=length(Unresolved_unknown_nodes_index);
    plot(all_nodes.true(Unresolved_unknown_nodes_index,1),all_nodes.true(Unresolved_unknown_nodes_index,2),'ko');
    resolved_unknown_nodes_index=find(all_nodes.anc_flag==2);%estimated locations of the resolved unkonwn nodes
    plot(all_nodes.estimated(resolved_unknown_nodes_index,1),all_nodes.estimated(resolved_unknown_nodes_index,2),'bo');
    plot(transpose([all_nodes.estimated(resolved_unknown_nodes_index,1),all_nodes.true(resolved_unknown_nodes_index,1)]),...
        transpose([all_nodes.estimated(resolved_unknown_nodes_index,2),all_nodes.true(resolved_unknown_nodes_index,2)]),'b-');
    axis auto;
    title(['positioning error map: ', algorithm]);    
    try % draw a regularly distributed grid line
        x=0:all_nodes.grid_L:all_nodes.square_L;
        set(gca,'XTick',x);
        set(gca,'XTickLabel',num2cell(x));
        set(gca,'YTick',x);
        set(gca,'YTickLabel',num2cell(x));
        grid on;
    catch
        %none
    end    
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    disp('~~~~~~~~~~~~~~~~~~~~~~~~Positioning error map~~~~~~~~~~~~~~~~~~~~~~~~~~');
    disp('Red* indicates anchor node ');
    disp('Blue O indicates the estimated position of the unknown node');
    disp('Black O means unknown nodes that cannot be located ');
    disp(' Blue-indicates the positioning error of the unknown node (connecting the estimated position and the true position of the unknown node) ');
    disp(['total ',num2str(all_nodes.nodes_n),'nodes:',num2str(all_nodes.anchors_n),'anchor nodes,',...
        num2str(all_nodes.nodes_n-all_nodes.anchors_n),'Unknown nodes,',num2str(Unresolved_num),' Unresolved nodes that cannot be located']);
    Localization_error=sum(sqrt(sum(transpose((all_nodes.estimated(resolved_unknown_nodes_index,:)-all_nodes.true(resolved_unknown_nodes_index,:)).^2))))/...
        (length(resolved_unknown_nodes_index)*comm_r);
    disp(['The positioning error for ',algorithm,' is ',num2str(Localization_error)]);
end
