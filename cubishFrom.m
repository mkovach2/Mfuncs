function cubishFrom(sidesIn, basis, fccMode=0, bccMode=0)
  % args:
  % function cubishFrom(sidesIn, basis, fccMode=0, bccMode=0)
  % plots a right 6-hedron from a vector sidesIn and a vector basis like so:
  % basis specifies the coordinates of the corner of the cube closest to the 
  % origin and acts as the offset
  % if sidesIn has length 1, a cube is plotted with corners at basis and
  % basis + sidesIn in each direction
  % length 2 will assign x and y one side-length and z the other side-length
  % length 3 will assign a side-length to x, y, and z in that order.
  
  if 0 %debugging_if
    close all;
  end
  
  switch length(sidesIn)
    case 1
      cornerVec = sidesIn(1) .* [1 1 1];
    case 2
      cornerVec = sidesIn(1) .* [1 1 0] + [0 0 sidesIn(2)];
    case 3
      cornerVec = sidesIn;
  end
  
  qolor = rand(1,3);
  colorMode = 0; % 1 = faces filled in.  0 = faces no fill

  unitCube = [0 0 0;1 0 0;1 0 1;0 0 1;0 1 1;1 1 1;1 1 0;0 1 0];
  plotCube = (cornerVec .* unitCube + basis);
  if 0 %debugging_if
    plotCube(:,[1 2 3])
  end
  
  if colorMode
    for a = 0:2
      patch(plotCube((1+2*a):(4+2*a),1),...
            plotCube((1+2*a):(4+2*a),2),...
            plotCube((1+2*a):(4+2*a),3),...
            'FaceAlpha',0.5);
            %'FaceColor',qolor,'FaceAlpha',0.5);
    end
    figure;
    patch(plotCube([7 8 1 2],1),...
          plotCube([7 8 1 2],2),...
          plotCube([7 8 1 2],3),...
          'FaceColor',qolor,'FaceAlpha',0.5);
    figure;
    patch(plotCube([7 6 3 2],1),...
          plotCube([7 6 3 2],2),...
          plotCube([7 6 3 2],3),...
          'FaceColor',qolor,'FaceAlpha',0.5);
    figure;
    patch(plotCube([8 1 5 4],1),...
          plotCube([8 1 5 4],2),...
          plotCube([8 1 5 4],3),...
          'FaceColor',qolor,'FaceAlpha',0.5);
  else
    k = 1.5;
    d = (plotCube(:,1).^2+plotCube(:,2).^2+plotCube(:,3).^2).^0.5;
    %q = 100./(1 + e.^(-k.*(d-(max(d)-min(d))./2)));
    q = 100.*(e.^(d-max(d)));
    scatter3(plotCube(:,1),plotCube(:,2),plotCube(:,3),q,'MarkerFaceColor',qolor,"filled");
    hold on;
    if fccMode
      fccPts = 0.5.*[1 1 0; 1 0 1; 0 1 1; 2 1 1; 1 2 1; 1 1 2].*cornerVec + basis;
      d_f = (fccPts(:,1).^2+fccPts(:,2).^2+fccPts(:,3).^2).^0.5;
      %q_f = 100./(1 + e.^(-k.*(d_f-(max(d_f)-min(d_f))./2)));
      q_f = 100.*(e.^(d_f-max(d)));
      scatter3(fccPts(:,1),fccPts(:,2),fccPts(:,3),q_f,'MarkerFaceColor',qolor,"filled");
    elseif bccMode
      hold on;
      bccPts = 0.5.*cornerVec + basis;
      d_b = (bccPts(1).^2+bccPts(2).^2+bccPts(3).^2).^0.5;
      q_b = 100.*(e.^(d_b-max(d)));
      scatter3(bccPts(1),bccPts(2),bccPts(3),q_b,'MarkerFaceColor',qolor,"filled");
    end
  end

  if 1 %debugging_if
    view(115,20);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    axis('equal');
  end
end