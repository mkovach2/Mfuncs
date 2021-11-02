function nicePlot(xVals, yVals, varargin)
% nicePlot makes a nice plot
% last modified:  2021-11-02 mkovach@bu.edu
% example: nicePlot([xv1; xv2],[yv1; yv2],nan,nan,nan,nan,5,6,7,1,1);
% 
% the first two arguments will be the x and y vectors (or x and y matrices where
% the rows act as vectors)to plot
% the variable-size input vector specifies the following:
% a nan in any position will skip setting the parameter in that position.
% if nothing is entered after yVals, default values will be assumed.
% varargin{1} = xLo, x axis minimum
%         {2} = xHi, x axis maximum
%         {3} = yLo, y axis minimum
%         {4} = yHi, y axis maximum
%         {5} = xTnum, number of x ticks
%         {6} = yTnum, number of y ticks
%         {7} = gridOn (1 for grid, 0 for no grid)
%         {8} = equalAspect (1 for force equal aspect ratio, 0 for not)
%         {9} = holdOn (1 for hold on, 0 to split plots into figures)    
% 

  if 0 %debugging_if
    close all;
  end

  truNarg = nargin;
  % if no inputs are provided, nicePlot
  % will (at least attempt to) apply the default state to the current plot  
  if not(nargin)
    xVals = get(get(gca, 'children'),"xdata");
    yVals = get(get(gca, 'children'),"ydata");
    truNarg = nargin + 2;
  end

  argMax = 9; % number of POSSIBLE arguments besides xVec and yVec
  xMin = min(min(xVals));
  xMax = max(max(xVals));
  yMin = min(min(yVals));
  yMax = max(max(yVals));
  xDif = xMax - xMin;
  yDif = yMax - yMin;
  
  argVec = [cell2mat(varargin) nan.*ones(1,argMax-(truNarg-2))];
  
  % eqAspDef forces equal aspect ratio when the ranges are within certain
  % bounds, depending on whether xDif or yDif is larger.
  eqAspDef = or(and(xDif/yDif <= 3,xDif >= yDif), ...
                and(yDif/xDif <= 2,yDif >= xDif));
  
  % default values
  defVec = [[0.1 .* xDif .* [-1 1] + [xMin xMax]] ... % [xLo xHi]
            [0.1 .* yDif .* [-1 1] + [yMin yMax]] ... % [yLo yHi]
            [10 10] ... % [xTnum yTnum]
             1 ... % gridOn
            eqAspDef ... % equalAspect
             1];   % holdOn
             
  if 0 %debugging_if
    defVec'
  end
  
  if 0 %debugging_if for equalAspect
    [xDif yDif]
    max(xDif,yDif) / min(xDif,yDif)
  end
  
  % replace nans with default values
  defVec2 = defVec;        
  defVec2(not(isnan(argVec))) = 0;
  argVec2 = argVec;
  argVec2(isnan(argVec)) = 0;
  finVec = defVec2 + argVec2;
  
  % if the axes are meant to be equal, then the ticks will be too.
  if and(finVec(8),xDif >= yDif) 
    finVec(5) = round(finVec(5) .* xDif/yDif);
  elseif and(finVec(8),yDif >= xDif) 
    finVec(6) = round(finVec(6) .* yDif/xDif);
  end
  
  if 0 %debugging_if
    fenVic = finVec'
  end  
  
  if finVec(9)
    hold on;
  end
  
  if 0 % from old code, delete soon
    sX = round(finVec(5)*-xMin/xDif);
    sY = round(finVec(6)*-yMin/yDif);
  end
  
  tickSize = [xDif/finVec(5) yDif/finVec(6)];
  
  % forcing ticks to include zero if zero is crossed
  if finVec(1) < 0
    xtickvec = [flip(0:-tickSize(1):finVec(1),1) ...
                tickSize(1):tickSize(1):finVec(2)];
  else
    xtickvec = (finVec(1):tickSize(1):finVec(2));
  end
  
  if finVec(3) < 0
    ytickvec = [flip(0:-tickSize(2):finVec(3),1) ...
                tickSize(2):tickSize(2):finVec(4)];
  else
    [finVec(3) tickSize(2) finVec(4)]
    ytickvec = (finVec(3):tickSize(2):finVec(4));
  end

  if 0 %old version of the above step, delete soon
    if and(xMin < 0, sX > 0)
      xtickvec = [linspace(finVec(1),0,sX)...
                  linspace(0,finVec(2),finVec(5)-sX)(2:end)];
    elseif and(xMin < 0, sX == 0)
      xtickvec = [-xDif./finVec(5) linspace(0,finVec(2),finVec(5)-1)];
      [-xDif./finVec(5) finVec(2) finVec(5)]
    else
      [finVec(1) finVec(2) finVec(5)]
      xtickvec = linspace(finVec(1),finVec(2),finVec(5));
    end
    % and for y
    if and(yMin < 0, sY > 0)
      ytickvec = [linspace(finVec(3),0,sY)...
                  linspace(0,finVec(4),finVec(6)-sY)(2:end)];
    elseif and(yMin < 0, sY == 0)
      ytickvec = [-yDif./finVec(6) linspace(0,finVec(4),finVec(6)-1)];
    else
      [finVec(3) finVec(4) finVec(6)]
      ytickvec = linspace(finVec(3),finVec(4),finVec(6));
    end
  end
  
  if 0 % more old code, delete soon
    if yDif > yMax
      ytickvec = [linspace(finVec(3),0,floor(finVec(6) * floor(-yMin/yDif)))...
                  linspace(0,finVec(4),finVec(6) * (1-floor(-yMin/yDif)))(2:end)];
    else
      ytickvec = linspace(finVec(3),finVec(4),finVec(6));
    end
  end
  
  % setting the params for a joined plot
  xlim(finVec(1:2));
  ylim(finVec(3:4));
  xticks(xtickvec);
  yticks(ytickvec);
  xExp = round(log10(abs(min(xtickvec)))); % hehe u cant pronounce xExp
  if xExp <= 2
    xExp = 0;
  endif
  xLabs = (round(100.*xtickvec./10.^xExp)./100);
  xticklabels(xLabs);
  yLabs = ytickvec;
  yticks(yLabs);
  if finVec(7)
    grid on;
  end
  if finVec(8)
    axis('equal');
  else
    axis("normal");
  end
      
  for curveNo = 1:size(xVals,1)
    % setting the params each time for separate plots
    if and(not(finVec(9)),nargin)
      figure;
      plot(xVals(curveNo,:),yVals(curveNo,:));
      xlim(finVec(1:2));
      ylim(finVec(3:4));
      xticks(linspace(finVec(1),finVec(2),finVec(5)));
      yticks(linspace(finVec(3),finVec(4),finVec(6)));
      if xExp > 2
        text(max(xLabs),min(yLabs),['* 10^' num2str(xExp)]);
      end
      if finVec(7)
        grid on;
      end
      if finVec(8)
        axis('equal');
      else
        axis("normal");
      end
    else if nargin
      plot(xVals(curveNo,:),yVals(curveNo,:));
    end
  
    if 0 %debugging_if
      [xVals(curveNo,:)' yVals(curveNo,:)']
    end
  end
  
  if xExp != 0
    if 1
      text(max(xLabs)*10.^xExp,min(yLabs),...
          ["x 10^{" num2str(xExp) "}"]);
    else
      xlabel(["x 10^{" num2str(xExp) "}"]);
    end
    
    if 1
      text(max(xLabs)*10.^xExp,min(yLabs),...
          ["x 10^{" num2str(xExp) "}"]);
    else
      xlabel(["x 10^{" num2str(xExp) "}"]);
    end
  end
  
end

















