load coordinates.mat;
figure;
hold on;
box on;
plot(all_nodes.true(1:all_nodes.anchors_n,1),all_nodes.true(1:all_nodes.anchors_n,2),'r*');
plot(all_nodes.true(all_nodes.anchors_n+1:all_nodes.nodes_n,1),all_nodes.true(all_nodes.anchors_n+1:all_nodes.nodes_n,2),'bo');
axis([0,all_nodes.square_L,0,all_nodes.square_L]);
title(' Node Distribution Map ');
try %draw a regularly distributed grid line	
    x=0:all_nodes.grid_L:all_nodes.square_L;
    set(gca,'XTick',x);
    set(gca,'XTickLabel',num2cell(x));
    set(gca,'YTick',x);
    set(gca,'YTickLabel',num2cell(x));
    grid on;
catch
    %none
end
try % draw the boundary of the C-type area
    square_L=all_nodes.square_L;
    area=all_nodes.area;
    plot([area(2) area(2)],[area(3) area(4)],'-k',[area(2) square_L],[area(3) area(3)],'-k',[area(2) square_L],[area(4) area(4)],'-k');    
catch
   %none 
end
disp('~~~~~~~~~~~~~~~~~~~~~~~~Node distribution graph~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp([num2str(all_nodes.nodes_n),'nodes,','where',num2str(all_nodes.anchors_n),' anchor nodes']);
disp('Red* means anchor node, blue O means unknown node');
