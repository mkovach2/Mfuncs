function newFlat = flatInterp(shortOne, longOne, dim, sIn, lIn);
  % this function takes two matrices, shortOne and longOne, and interpolates...
  % ...shortOne to the size of longOne along dimension dim just by repeating...
  % ...the last output of shortOne until the input of longOne exceeds the...
  % ...input of shortOne. dim = 1 for rows, 2 for columns.  sIn and lIn are...
  % ...the (row or column) to be considered the input of shortOne and longOne...
  % ...respectively.
  
  sSiz = size(shortOne);
  lSiz = size(longOne);
  if dim == 1,
    newFlat = zeros(lSiz(1),sSiz(2));
  elseif dim == 2,
    newFlat = zeros(lSiz(2),sSiz(1));
    shortOne = shortOne';
    longOne = longOne';
  endif
  
  shortCheck = 1;
  for longCheck = 1:size(newFlat,1),
    
    %shortOne(shortCheck,sIn)
    %longOne(longCheck, lIn)
    
    
    if (shortOne(shortCheck,sIn) < longOne(longCheck, lIn)) &&...
      (shortCheck + 1 <= size(shortOne,1)),
      shortCheck++;
    endif

  
    newFlat(longCheck,:) = shortOne(shortCheck,:);
    newFlat(longCheck,sIn) = longOne(longCheck, lIn);
  endfor

  if dim == 2,
    newFlat = newFlat';
  endif
  
  %size(newFlat)
  
endfunction
