function bool = cellequal(c1,c2)
% CELLEQUAL compares to cell arrays for element wise equality
%   BOOL = CELLEQUAL(C1, C2) returns true if the two cell arrays are the same
%   under element wise comparision.  May call itself recursively or call
%   STRUCTEQUAL.
%
%   See also STRUCTEQUAL

if length( c1 ) == length( c2 )
  bool = 1;
  for i = 1:length(c1)
    cls1 = class( c1{i} );
    cls2 = class( c2{i} );
    if strcmp(cls1,cls2)
      switch cls1
       case 'struct'
        bool = bool & structequal( c1{i}, c2{i} );
       case {'double', 'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32' }
        ob1 = c1{i};
        ob2 = c2{i};
        bool = bool & ( length( ob1(:) ) == length( ob2(:) ) );
        if bool
          bool = bool & all( ob1(:) == ob2(:) );
        end
       case 'inline'
        bool = bool & inlineeq(c1,c2);
       case 'function_handle'
        s1 = functions(c1{i});
        s2 = functions(c2{i});
        bool = bool & strcmp(s1.function, s2.function);
       case 'cell'
        bool = bool & cellequal(c1{i}, c2{i});
       case 'char'
        bool = bool & strcmp(c1{i}, c2{i});
       case 'logical'
        bool = bool & (length(c1{i})==length(c2{i}));
        if bool
          bool = bool & all(c1{i}==c2{i});
        end
       otherwise
        bool = bool & strcmp(cls1,cls2);
        disp('Warning: Unknown object type, using class names for comparison.');
      end
      if ~bool
        return
      end
    end
  end
else
  bool = 0;
  return
end
