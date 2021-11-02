function outMat = millerPlane(inMat)
  % takes inMat, a 3-by-anything or anything-by-3 matrix of coordinates
  % and converts them to miller indices, or the other way around, as the
  % operations are preeeeeeetty much reciprocal
  
  if and(size(inMat,1) == 3,size(inMat,2) != 3)
    inMat = inMat'; % now it is something-by-3
  end
  
  lcmVec = zeros(size(inMat,1),1);
  
  for mR = 1:length(lcmVec)
    interm = [inMat(mR,1) inMat(mR,2) inMat(mR,3)];
    interm = interm(and(interm != 0, interm != Inf));
    if 0 %debugging_if
      ["mR " num2str(mR)]
    end
    
    for b = 1:length(interm)
      if lcmVec(mR) != 0
        lcmVec(mR) = lcm(lcmVec(mR),interm(b));
      else
        lcmVec(mR) = interm(b);
      end
    end
  end
      
  outMat = lcmVec./inMat;
  fillers = zeros(size(outMat,1),2);
  outX = [outMat(:,1) fillers];
  outY = [fillers(:,1) outMat(:,2) fillers(:,2)];
  outZ = [fillers outMat(:,3)];
  for pL = 1:size(inMat,1)
    [pL 0 0; outX(pL,:); outY(pL,:); outZ(pL,:)];
    %three_dplotting(outMat([outX(pL,:); outY(pL,:); outZ(pL,:)])); % a custom function
  end
  %three_dplotting(outMat); 
end
    