
function [CSF,ESF,CENT] = calcPropiedades(BW)     


%   CSF     coefficient circular elíptic
%   ESF     coefficient circular de elongation 


BW = imfill(BW, 'holes');
BW = imclearborder(BW);
BWE = bwlabel(BW);

% Extraction properties of región 
stats   = regionprops(BWE,'all');

cent    = cat(1, stats.Centroid);
mjaxis  = cat(1, stats.MajorAxisLength);   
mnaxis  = cat(1, stats.MinorAxisLength);
areas   = cat(1, stats.Area);
perms   = cat(1, stats.Perimeter);


areaprom = sum(areas)/length(areas);
selec = (areas > areaprom/2) & (areas < 2*areaprom);

areas  = areas(selec);
perms  = perms(selec);
mjaxis = mjaxis(selec);
mnaxis = mnaxis(selec);
CENT   = cent(selec,:);


CSF = 4.*pi.*(areas./(perms.^2)); %CSF = (CSF>1)+(CSF<=1).*CSF;
ESF = mnaxis./mjaxis;

