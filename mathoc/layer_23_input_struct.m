function [params]=layer_23_input_struct(varagin)

if ~exist('ffi_somap')
  ffi_somap = 1;
end
if ~exist('ffe_somap')
  ffe_somap = 0;
end

if ~exist('rei_somap')
  rei_somap = 1;
end
if ~exist('ree_somap')
  ree_somap = 0;
end


params = struct;

if ~exist('rei_e'), params.rei_e = -85; end 
if ~exist('rei_g'), params.rei_g = 5.00e-4; end 
if ~exist('rei_tau'), params.rei_tau = 11; end 
if ~exist('rei_dist'), params.rei_dist = 0; end 
if ~exist('rei_width'), params.rei_width = 30; end 

if ~exist('ree_e'), params.ree_e = 0; end 
if ~exist('ree_g'), params.ree_g = .0015; end 
if ~exist('ree_tau'), params.ree_tau = 3; end 
if ~exist('ree_dist'), params.ree_dist = 90; end 
if ~exist('ree_width'), params.ree_width = 35; end 

if ~exist('ffi_e'), params.ffi_e = -85; end 
if ~exist('ffi_g'), params.ffi_g = 5.00e-4; end 
if ~exist('ffi_tau'), params.ffi_tau = 11; end 
if ~exist('ffi_dist'), params.ffi_dist = 0; end 
if ~exist('ffi_width'), params.ffi_width = 30; end 

if ~exist('ffe_e'), params.ffe_e = 0; end 
if ~exist('ffe_g'), params.ffe_g = .0015; end 
if ~exist('ffe_tau'), params.ffe_tau = 3; end 
if ~exist('ffe_dist'), params.ffe_dist = 90; end 
if ~exist('ffe_width'), params.ffe_width = 35; end 

if ~exist('tdi_e'), params.tdi_e = -85; end 
if ~exist('tdi_g'), params.tdi_g = 5.00e-4; end 
if ~exist('tdi_tau'), params.tdi_tau = 11; end 
if ~exist('tdi_dist'), params.tdi_dist = 0; end 
if ~exist('tdi_width'), params.tdi_width = 30; end 

if ~exist('tde_e'), params.tde_e = 0; end 
if ~exist('tde_g'), params.tde_g = .0015; end 
if ~exist('tde_tau'), params.tde_tau = 3; end 
if ~exist('tde_dist'), params.tde_dist = 90; end 
if ~exist('tde_width'), params.tde_width = 35; end 

if ~exist('exc_env'), exc_env = inline('1/1000','t'); end 
if ~exist('inh_env'), inh_env = inline('5/1000','t'); end 




basilarsref = map(@(x) [x 'ref'], sections_re('basil.*'));
nbas = length(basilarsref);
if ~exist('rei_n'), params.rei_n = 500/nbas;; end 
if ~exist('ree_n'), params.ree_n = 2000/nbas;; end 

if ~exist('ffi_n'), params.ffi_n = 500/nbas;; end 
if ~exist('ffe_n'), params.ffe_n = 2000/nbas;; end 


% first create basilar inhibitory signal

pin = inh_syn_params(params.ffi_n);
pex = exc_syn_params(params.ffe_n);
for i=1:nbas
  
  if ffi_somap
    target = { basilarsref{i} 'somaref' };
  else
    target = { basilarsref{i} };
  end
  pin.list_or_name = target;
  pin.env = inh_env;
 
  if ffe_somap
    target = { basilarsref{i} 'somaref' };
  else
    target = { basilarsref{i} };
  end
  pex.list_or_name = target;
  pex.env = exc_env;
  params.basilar_ffe(i) = pex;
  params.basilar_ffi(i) = pin;
end

pin = inh_syn_params(params.rei_n);
pex = exc_syn_params(params.ree_n);
for i=1:nbas
  
  if rei_somap
    target = { basilarsref{i} 'somaref' };
  else
    target = { basilarsref{i} };
  end
  pin.list_or_name = target;
  pin.env = inh_env;
 
  if ree_somap
    target = { basilarsref{i} 'somaref' };
  else
    target = { basilarsref{i} };
  end
  pex.list_or_name = target;
  pex.env = exc_env;
  params.basilar_ree(i) = pex;
  params.basilar_rei(i) = pin;
end

tuftsref = map(@(x) [x 'ref'], sections_re('tuft.*'));
ntuft = length(tuftsref);
if ~exist('tdi_n'), params.tdi_n = 500/ntuft; end 
if ~exist('tde_n'), params.tde_n = 2000/ntuft; end 


pin = inh_syn_params(params.tdi_n);
pex = exc_syn_params(params.tde_n);
for i=1:ntuft
  
  if ffi_somap
    target = { tuftsref{i} 'somaref' };
  else
    target = { tuftsref{i} };
  end
  pin.list_or_name = target;
  pin.env = inh_env;
 
  if ffe_somap
    target = { tuftsref{i} 'somaref' };
  else
    target = { tuftsref{i} };
  end
  pex.list_or_name = target;
  pex.env = exc_env;
  params.tuft_e(i) = pex;
  params.tuft_i(i) = pin;
end
