function Amorphous()
    load '../Deploy Nodes/coordinates.mat';
    load '../Topology Of WSN/neighbor.mat'; 
    if all_nodes.anchors_n<3
        disp('ê�ڵ�����3��,DV-hop�㷨�޷�ִ��');
        return;
    end
    %~~~~~~~~~~~~~~~~~~~~~~~~~���·���㷨����ڵ������~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    shortest_path=neighbor_matrix;
    shortest_path=shortest_path+eye(all_nodes.nodes_n)*2;
    shortest_path(shortest_path==0)=inf;
    shortest_path(shortest_path==2)=0;
    for k=1:all_nodes.nodes_n
        for i=1:all_nodes.nodes_n
            for j=1:all_nodes.nodes_n
                if shortest_path(i,k)+shortest_path(k,j)<shortest_path(i,j)%min(h(i,j),h(i,k)+h(k,j))
                    shortest_path(i,j)=shortest_path(i,k)+shortest_path(k,j);
                end
            end
        end
    end
    if length(find(shortest_path==inf))~=0
        disp('���粻��ͨ...��Ҫ������ͨ��ͼ...����û�п����������');
        return;
    end
    %~~~~~~~~~~~~~~~~~~~~~~~~~ÿ������~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    % Amorphous�����߼�������ÿ������ģ�����Ҫ�����粿��֮ǰ��֪�������ƽ����ͨ��
    % ���߼�������ƽ����ͨ�ȣ�connectivity=(�ڵ���/����������)*pi*R^2
    % ��ʵ������ƽ����ͨ�ȣ�(�����粿����Ϻ�ͨ���ڵ�ͨ���ռ������������Ϣ)
    % connectivity=sum(sum(neighobr_matrix))/all_nodes.nodes_n;
    try%C������
        area=all_nodes.area(1)^2-(all_nodes.area(4)-all_nodes.area(3))*(all_nodes.area(1)-all_nodes.area(2));
    catch
        area=all_nodes.square_L^2;
    end
    connectivity=all_nodes.nodes_n/area*pi*comm_r^2;
    syms t;
    temp=@(t)(exp(-connectivity/pi*(acos(t)-t.*sqrt(1-t.^2)))); 
    hopsize=comm_r*(1+exp(-connectivity)-sum(temp(-1:0.001:1)*0.001));%��У��ֵ�Ļ���matlab�󲻳�����ֻ����ͱƽ���
    %~~~~~~~~~~~~~~~~~~~~~~~ÿ��δ֪�ڵ㿪ʼ�����Լ���λ��~~~~~~~~~~~~~~~~~~~~
    for i=all_nodes.anchors_n+1:all_nodes.nodes_n  
        neighboring_node_index=find(neighbor_matrix(i,:)==1);
        hop=mean(shortest_path([neighboring_node_index,i],1:all_nodes.anchors_n))-0.5;        
        unknown_to_anchors_dist=hopsize*hop';%���㵽ê�ڵ�ľ���=����*У��ֵ
        %~~~~~~~~~~��С���˷�~~~~~~~~~~~~~~~`
        A=2*(all_nodes.estimated(1:all_nodes.anchors_n-1,:)-repmat(all_nodes.estimated(all_nodes.anchors_n,:),all_nodes.anchors_n-1,1));
        anchors_location_square=transpose(sum(transpose(all_nodes.estimated(1:all_nodes.anchors_n,:).^2)));
        dist_square=unknown_to_anchors_dist.^2;
        b=anchors_location_square(1:all_nodes.anchors_n-1)-anchors_location_square(all_nodes.anchors_n)-dist_square(1:all_nodes.anchors_n-1)+dist_square(all_nodes.anchors_n);
        all_nodes.estimated(i,:)=transpose(A\b);
        all_nodes.anc_flag(i)=2;
    end
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    save '../Localization Error/result.mat' all_nodes comm_r;
end