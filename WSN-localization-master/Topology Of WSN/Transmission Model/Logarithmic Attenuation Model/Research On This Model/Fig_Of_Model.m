clear;
clc;
close all;
directory=cd;
cd ..;
try
    figure;
    hold on;
    grid on;
    box on;
    dist=5:5:100;
    [RSS,RSS_NOFADING]=dist2rss(dist);
    plot(dist,RSS,'-b*',dist,RSS_NOFADING,'-rd');
    xlabel('distance(meter)');
    ylabel('RSS(dBm)');
    legend('logarithmic attenuation model','regular model');
    %~~~~~~~~~~~~~~~~~~~~~~~~
    figure;
    hold on;
    box on;
    axis square;
    comm_r=[30;80];
    dist=repmat(comm_r,1,360);
    polar(0:pi/180:2*pi,[dist(1,:),dist(1,1)],'--k');
    polar(0:pi/180:2*pi,[dist(2,:),dist(2,1)],':k');
    RSS=dist2rss(dist);
    dist=rss2dist(RSS);    
    polar(0:pi/180:2*pi,[dist(1,:),dist(1,1)],'-b*');
    polar(0:pi/180:2*pi,[dist(2,:),dist(2,1)],'-rd');
    legend('30m Disc','80m Disc','RSSΪPr(30)�ĵ�','RSSΪPr(80)�ĵ�');
    %~~~~~~~~~~~~~~~~~~~~~~~~
    figure;
    hold on;
    box on;
    comm_r=10:10:100;
    dist=repmat(comm_r,360,1);
    RSS=dist2rss(dist);
    dist=rss2dist(RSS);  
    bar(comm_r,mean(dist),0.3,'w');
    errorbar(comm_r,mean(dist),mean(dist)-min(dist),max(dist)-mean(dist),'b.');
    plot(comm_r,sqrt(sum((dist-repmat(mean(dist),360,1)).^2)),'-rd');
    axis auto;
    legend('RSSΪPr(X)�ĵ㵽���ͽڵ��ƽ������','RSSΪPr(X)�ĵ㵽���ͽڵ�����/Զ����','RSSΪPr(X)�ĵ㵽���ͽڵ����ı�׼��');
    title('�ɼ�:���뷢�ͽڵ�ԽԶ��RSS��ͬ�ĵ�������Խ��');
    set(gca,'XTick',comm_r);
    set(gca,'XTickLabel',num2cell(comm_r));    
    %~~~~~~~~~~~~~~~~~~~~~~~~
    %~~~~~~~PS:
    %    logarithmic attenuation model����Regular model����Fading component of
    % RSS�õ��ġ�
    %    ģ�ͽ��ܾ����~/Transmission Model/readme.bmp��Models_Soln_RIM_TOSN.pdf
    %    ��ģ���¾��뷢�ͽڵ�ԽԶ�Ľ��ܽڵ��ܵ�Fading componen��Ӱ����Խϴ�
    %    �Ͼ�������10m���ڣ�һ�׵ľ���仯�ɵ��¼�ʮdb���ź�˥�䣬Fading component��db��Ӱ����Խ�С��
    %    ��100m���⣬10�׵ľ���仯Ҳ�����ż�db���ź�˥�䣬��ʱFading component��db��Ӱ����Զ����Ǻܴ�ġ�
    %~~~~~~~~~~~~~~~~~~~~~~~~
catch
    disp('ERROR');
    cd(directory);
end
%~~~~~~~~~~~~~~~~~~~~~~~~
cd(directory);