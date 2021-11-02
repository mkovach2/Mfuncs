function three_dplotting(xyzMat)
  if 0
    close all;
  end

  if 1
    hold on;
  end

  % xyzMat: coordinates of xyz triplets to be plotted as points
  % and joined into planes, three at a time.
  % Leftover points plotted individually.
  % Example:
  % xyzMat = [1 1 0; 1 2 0; 1 0 3;...
  %           2 3 4; 1 0 0; 0 1 0;...
  %           0 0 0]; 
                                         
  xP = xyzMat(:,1)';
  yP = xyzMat(:,2)';
  zP = xyzMat(:,3)';

  gloMin = min(xyzMat(not(isinf(xyzMat))));
  gloMax = max(xyzMat(not(isinf(xyzMat))));
  abMax = max(abs(gloMin),abs(gloMax));
  scatter3(xP, yP, zP, 'filled');

  sPlanes = floor(size(xyzMat,1)./3);

  for a = (1:sPlanes)
    rand("state","reset");
    solidCol = rand(1);
    if 0 %debugging_if
      a
      [xP(a) yP(a) zP(a)]
      [xP; yP; zP]
    end
    patch(xP((3.*a - 2):(3.*a)),...
          yP((3.*a - 2):(3.*a)),...
          zP((3.*a - 2):(3.*a)),...
          solidCol.*[1 1 1],'FaceAlpha',0.5);
    view(115,20);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    axis('equal');
    ticks = linspace(gloMin,gloMax,5);
    xticks(ticks);
    yticks(ticks);
    zticks(ticks);
  end
end