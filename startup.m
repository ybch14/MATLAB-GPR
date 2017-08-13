% startup script to make Octave/Matlab aware of the GPML package
%
% Copyright (c) by Carl Edward Rasmussen and Hannes Nickisch 2016-10-16.

disp(['executing gpml startup script...']);

OCT = exist('OCTAVE_VERSION') ~= 0;           % check if we run Matlab or Octave

me = mfilename;                                            % what is my filename
mydir = which(me); mydir = mydir(1:end-2-numel(me));        % where am I located
if OCT && numel(mydir)==2 
  if strcmp(mydir,'./'), mydir = [pwd,mydir(2:end)]; end
end                 % OCTAVE 3.0.x relative, MATLAB and newer have absolute path

toolbox_path='gpml-matlab\';
addpath(mydir(1:end-1))
addpath([mydir,toolbox_path(1:end-1)])
addpath([mydir,toolbox_path,'cov'])
addpath([mydir,toolbox_path,'doc'])
addpath([mydir,toolbox_path,'inf'])
addpath([mydir,toolbox_path,'lik'])
addpath([mydir,toolbox_path,'mean'])
addpath([mydir,toolbox_path,'prior'])
addpath([mydir,toolbox_path,'util'])

clear me mydir toolbox_path OCT
