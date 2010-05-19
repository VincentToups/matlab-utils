function y=b2h(x)

%B2H  Converts binary to hex.
%   B2H(x), where x is a vector of binary numbers ranging from
%   1 to n where element #1 represents the least significant number
%   and element #n represents the most significant number.
%   The function will return a string that represents the binary number in hex.
%

% Copyright (c), B. Rasmus Anthin.
% Revision: 2002-11-27.

%[LSB     MSB]

if all(size(x)>1), error('Input must be scalar or vector'),end
if mod(length(x),4), error('Length must be n*4'),end
x=x(:)';
len=length(x);
%rows=size(x,1);
x=fliplr(x);
nibbles=len/4;
xx=zeros(nibbles,4);
for i=1:nibbles
   y='0';
end
for i=0:nibbles-1
   xx(i+1,:)=fliplr(x((1:4)+4*i));
end
xxx=xx*2.^(0:3)';
for i=1:nibbles
   if xxx(i)<10
     	y(i)=int2str(xxx(i));
   elseif xxx(i)==10
      y(i)='A';
   elseif xxx(i)==11
      y(i)='B';
   elseif xxx(i)==12
      y(i)='C';
   elseif xxx(i)==13
      y(i)='D';
  	elseif xxx(i)==14
      y(i)='E';
  	elseif xxx(i)==15
      y(i)='F';
   end
end