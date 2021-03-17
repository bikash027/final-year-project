function Centroid_third(packet_sent_n,CM_threshold)
% packet_sent_n:�ڵ㷢�͵İ���Ŀ
% CM_threshold:��ͨ����ֵ
% Centroid�㷨������ļ����µ�pdf�ļ�
% ������ܽڵ���յ��İ���Ŀ�뷢�ͽڵ㷢�͵İ���Ŀ�ı�ֵ����CM_threshold,���������ڵ���Ϊ�ھӽڵ�
% ���ھ�ê�ڵ��δ֪�ڵ�ֻ�����ھ�ê�ڵ���ж�λ��û���ھ�ê�ڵ��δ֪�ڵ�������Ѿ���λ�˵��ھ�δ֪�ڵ���ж�λ��
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    directory=cd;
    cd '../Topology Of WSN';
    connectivity_metric=0;
    for i=1:packet_sent_n
        load neighbor.mat;
        connectivity_metric=connectivity_metric+neighbor_matrix;
        try
            calculate_neighbor(comm_r,anchor_comm_r,model,DOI);
        catch
            calculate_neighbor(comm_r,anchor_comm_r,model);
        end
    end
    cd(directory);
    CM=connectivity_metric>=packet_sent_n*CM_threshold;
    load '../Deploy Nodes/coordinates.mat';    
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    loop=1;%���ھ�ê�ڵ��δ֪�ڵ�ֻ�����ھ�ê�ڵ���ж�λ
    unknown_node_index=all_nodes.anchors_n+1:all_nodes.nodes_n;    
    while true
        for i=unknown_node_index         
            neighboring_anchor_index=intersect(find(CM(i,:)==1),find(all_nodes.anc_flag==1|all_nodes.anc_flag==loop));
            if ~isempty(neighboring_anchor_index)
                if ~isempty(neighboring_anchor_index)
                    all_nodes.estimated(i,:)=mean([all_nodes.estimated(neighboring_anchor_index,:);all_nodes.estimated(neighboring_anchor_index,:)]);
                    all_nodes.anc_flag(i)=2;
                end
            end
        end
        try
           unknown_node_index==transpose(find(all_nodes.anc_flag==0));
           break;
        catch
            unknown_node_index=transpose(find(all_nodes.anc_flag==0));
        end
        loop=2;%û���ھ�ê�ڵ��δ֪�ڵ�������Ѿ���λ�˵��ھ�δ֪�ڵ���ж�λ
    end
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    save '../Localization Error/result.mat' all_nodes comm_r;
end