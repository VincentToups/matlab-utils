function [signal,XDF]=labview(varargin)
% Loads LabVIEW binary data into Matlab
% [signal,XDF]=labview(Filename [[,first] ,last]); 
% loads into signal variable the binary record number
% comprised between first and last numbers. 
% If two input arguments are given, the second argument it will be assumed as last.

% This routine was tested with 3 channels
% Future versions for accessing the LABVIEW dataformat shall contain 
% various functions with the same input/output arguments as the EDF/SDF-toolbox for Matlab. 
% This toolbox shall contain at least LVFOPEN, LVFREAD, LVFCLOSE, 
% (later also LVFSEEK, LVFEOF, LVFTELL, LVFWRITE)  
% Send your comments to <a.schloegl@ieee.org>\n');

% Filename
% signal data
% XDF    header information
%
%	Version 0.20
%	4. Jan. 2001
%	Copyright (c) 1997-2001 by  Alois Schloegl
%	a.schloegl@ieee.org	
%

% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the  License, or (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

% Changes by Pierre Bonnard (pbon@vmfr.vibro-meter.ch):
% 2) unsigned chars reading of strings
% 3) Corrected fteel to ftell
% 4) Removed unused H output argument 
% 5) Modified input arguments to allow partial file reading (else "out of memory")
%
%Header = Total header length (4 bytes) followed by channel list string 
%length and string (constructed into one string from channel array), 
%channel settings cluster returned by hardware config, actual scan rate
%returned by clock config (4 bytes), date, time, and user header string.
%

if nargin<1
	fprintf(2,'missing argument "Filename"\n');         
	return;        
else
	FILENAME=varargin{1};
end;        
%if nargin<2 arg2='r'; end;

% Determine the first and last binary records to read:
first=1;
if nargin==2
   	last=varargin{2};
elseif nargin>=2
   	first=varargin{2};
   	last=varargin{3};	% other inputs ignored..
else
   	last = inf;
end;

%%%%% OPEN FILE
[fid,MESSAGE]=fopen(FILENAME,'r','ieee-be')  % LABVIEW binary format is always big-endian         
XDF.FILE.FID=fid;

if XDF.FILE.FID<0 
   	H1=MESSAGE; H2=FILENAME;
	XDF.ERROR=sprintf('Invalid Filename %s', FILENAME);
   	XDF.ErrNo = XDF.ErrNo + 32;
	return;
end;

XDF.FILE.OPEN = 1;
XDF.FileName = FILENAME;
PPos=min([max(find(FILENAME=='.')) length(FILENAME)+1]);
SPos=max([0 find(FILENAME==filesep)]);
XDF.FILE.Ext = FILENAME(PPos+1:length(FILENAME));
XDF.FILE.Name = FILENAME(SPos+1:PPos-1);

if SPos==0
	XDF.FILE.Path = pwd;
else
	XDF.FILE.Path = FILENAME(1:SPos-1);
end;

XDF.FileName = [XDF.FILE.Path filesep XDF.FILE.Name '.' XDF.FILE.Ext];

%%%%% READ HEADER from Labview 5.1 supplied VI "create binary header"

XDF.HeadLen  = fread(XDF.FILE.FID,1,'int32') % 4 first bytes = total header length
XDF.LenM     = fread(XDF.FILE.FID,1,'int32')  % 4 next bytes = channel list string length
XDF.ChanList = fread(XDF.FILE.FID,XDF.LenM,'uchar') % channel string

% Number of channels = 1 + ord(lastChann) - ord(firstChann):
%   Works only for Channels numbered from 0 to 9 ! PROVISIONNAL Q and D trick:
XDF.ChanNb = 1 + XDF.ChanList(end) - XDF.ChanList(1);
XDF.LenN     = fread(XDF.FILE.FID,1,'int32'); % Hardware config length
XDF.HWconfig = fread(XDF.FILE.FID,XDF.LenN,'uchar'); % its value
XDF.SampleRate = fread(XDF.FILE.FID,1,'float32');
XDF.InterChannelDelay = fread(XDF.FILE.FID,1,'float32');
tmp=fread(XDF.FILE.FID,XDF.HeadLen - ftell(XDF.FILE.FID),'uchar'); % read rest of header
XDF.Date= char(tmp(1:10)') ; % date is the first 10 elements of this tmp array (strip out tab)
XDF.Time= char(tmp(12:19)'); % and time is the next 8 ones
% XDF.T0 = [yyyy mm dd hh MM ss];   %should be Matlab date/time format like in clock()
XDF.Description= char(tmp(21:end)'); % description is the rest of elements.

% Empirically determine the number of bytes per multichannel point:
debut=ftell(XDF.FILE.FID) ; 
dummy10 = fread(XDF.FILE.FID,[XDF.ChanNb,1],'int32');
size_per_point=(ftell(XDF.FILE.FID) - debut ); % hope it's an int !

% move to first point beginning:
if (fseek(XDF.FILE.FID,-size_per_point,'cof')  <0) 
   error('file position error @1') ; end;

% position file at first point to be read:
if (fseek(XDF.FILE.FID,(last-first)*size_per_point,'cof')  <0) 
   error('file position error @2') ; end;


%%%%% READ DATA
if nargin<2
   signal = fread(XDF.FILE.FID,[XDF.ChanNb,inf],'int32');  
else
   signal = fread(XDF.FILE.FID,[XDF.ChanNb,last-first],'int32');
end;


%%%%% CLOSE FILE 
fclose(XDF.FILE.FID);
XDF.FILE.OPEN=0;
