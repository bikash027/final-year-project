Zenzon Don  (any problem, contact at zhenzhongdong@gmail.com    valid before 7.1.2010)
4.25.2010
------------------------------------------------------------------------------------------------------------

�ļ�����
�ļ���:
Transmission Model
����:
������4��ͨ��ģ��: Regular Model, DOI Model, Logarithmic Attenuation Model, RIM Model


-------------------------------------------------------------------------------------------------------------

calculate_neighbor.m
���ܣ�
����ͨ�Ű뾶��ѡ������ģ�ͣ�����'../Deploy Nodes/coordinates.mat'�Ľڵ��ھӹ�ϵ
�ھӹ�ϵ����neighbor_matrix���ھӼ���ź�ǿ������neighbor_rss�����������ļ�neighbor.mat��
���ø�ʽ��
calculate_neighbor(comm_r,times,model,DOI)
comm_r:δ֪�ڵ��ͨ�Ű뾶
times:ê�ڵ�ͨ�Ű뾶��δ֪�ڵ�ͨ�Ű뾶�ı�����APIT���칹WSN��ê�ڵ�ͨ�Ű뾶��δ֪�ڵ�ͨ�Ű뾶�󡣶����������㷨��times��Ϊ1��
model:'Regular Model','Logarithmic Attenuation Model','DOI Model','RIM Model',ȱʡΪ'Regular Model'
modelΪ'DOI Model','RIM Model'ʱ,��ҪDOI����

-------------------------------------------------------------------------------------------------------------

�ļ�����
neighbor.mat
���ܣ�
����ڵ���ھӹ�ϵ����neighbor_matrix���ھӼ���ź�ǿ������neighbor_rss
����neighbor_matrix��
	
	1	2	3	4	5	�����ͷ�
       _______________________________________________________
  1       |	0	0	1	0	1
           |
  2       |	0	0       	0	1	0
           |
  3       |	1	0	0	1	0
           |
  4       |	0	1	1	0	1
           |
  5       |	1	0	0	1	0
  .        |
  .        |
 ��      |
 ��      |
 ��      |
neighbor_matrix(i,j)==1����ʾ"�ڵ�i "�ܽ��յ�"�ڵ�j "���ź�;
neighbor_matrix��һ���Գ�,��"�ڵ�i"�ܽ��յ�"j"���ź�,������"�ڵ�j"Ҳ�ܽ��յ�"i"���ź�;

"�ڵ�i"�������ھӽڵ���ж�λ,�����ھӽڵ���neighbor_matrix(i,:)����neighbor_matrix(:,i)��??
Ӧ����neighbor_matrix(i,:),����"�ڵ�i"�ܽ��յ��źŵ���Щ�ڵ�.
��Ϊ:����APIT�е��칹WSN,ê�ڵ��ͨ�Ű뾶��δ֪�ڵ�ͨ�Ű뾶��ܶ�,�ڵ���ھ�Ӧ�������ܽ��ܵ��źŵ���Щ��,����δ֪�ڵ�Ϳ������������Զ��ê�ڵ����Ϣ��.
-------------------------------------------------------------------------------------------------------------

�ļ�����
Topology_Of_WSN.m
���ܣ�
����'../Deploy Nodes/coordinates.mat'��neighbor.mat�����ڵ���ھӹ�ϵͼ
��ȷ��neighbor.mat��'../Deploy Nodes/coordinates.mat'��Ӧ����neighbor.mat�Ǵӵ�ǰ��'../Deploy Nodes/coordinates.mat'����calculate_neighbor.m�õ���
���ø�ʽ��
Topology_Of_WSN


-------------------------------------------------------------------------------------------------------------
�ļ��У�
Figures
�ڵ��ھӹ�ϵͼ�����ڴ�
