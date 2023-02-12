n1=200;n2=100;
 [X,Y] = meshgrid(linspace(min(Xnodes),max(Xnodes),n1), linspace(min(Ynodes),max(Ynodes),n2));
 Z = griddata(Xnodes,Ynodes,d,X,Y);
% % Plot a graph.
 figure
 contourf(X,Y,Z,30,'LineColor', 'none');
 %set(fig,'EdgeColor','none')


 xv = linspace(min(Xnodes), max(Xnodes), numel(Xnodes));
 yv = linspace(min(Ynodes), max(Ynodes), numel(Ynodes));
 [Xm,Ym] = ndgrid(xv, yv);
 Zm = griddata(Xnodes, Ynodes, d, Xm, Ym);
 figure
 surf(Xm, Ym, Zm)
 %set(fig,'EdgeColor','none')