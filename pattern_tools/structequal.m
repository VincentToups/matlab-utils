function bool=structequal(uct1,uct2,preserve_order)
% STRUCTEQUAL compares structs for identity.
%
% BOOL=STRUCTEQUAL(UCT1, UCT2) returns 1 if the structures UCT1 and UCT2
% are equal under pairwise comparison.  Is called recurisively on
% substructures.
%
% See also CELLEQUAL
%

if ~exist('preserve_order')
  preserve_order = 0;
end

if preserve_order
  str1 = fieldnames(uct1);
  str2 = fieldnames(uct2);
else
  str1 = sort(fieldnames(uct1));
  str2 = sort(fieldnames(uct2));
end

if length(uct1) == length(uct2)
  for j=1:length(uct1)
    if cellequal(str1,str2)
      bool = 1;
      for i=1:length(str1)
        ob1 = uct1(j).( str1{i} );
        cls1= class(ob1);
        
        ob2 = uct2(j).( str1{i} );
        cls2= class(ob2);
        
        bool = bool & strcmp(cls1,cls2);
        if bool
          switch cls1
           case {'double', 'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32' }
            bool = bool & ( length( ob1(:) ) ==  length( ob2(:) ) );
            if bool
              bool = bool & all( ob1(:)==ob2(:) );
            end
           case 'struct'
            bool = bool & structequal( ob1, ob2, preserve_order );
           case 'inline'
            bool = bool & structequal(ob1,ob2);
           case 'function_handle'
            s1 = functions(ob1);
            s2 = functions(ob2);
            bool = bool & strcmp(s1.function, s2.function);
           case 'cell'
            bool = bool & cellequal(ob1, ob2);
           case 'char'
            bool = bool & strcmp(ob1, ob2);
           case 'logical'
            bool = bool & (length(ob1)==length(ob2));
            if bool
              bool = bool & all(ob1==ob2);
            end
           otherwise
            bool = bool & strcmp(cls1,cls2);
            disp('Warning: Unknown object type, using class names for comparison.');
          end
        end
        if ~bool
          return
        end
      end
    else
      bool = 0;
      return;
    end
  end
else
  bool = 0;
  return;
end

