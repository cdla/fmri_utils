function output_image = generate_rois(rois,roi_size)

% function roi_image = generate_rois(rois)
%
% For a given matrix of MNI coordinates, and a fourth column of values,
% this function will generate a 3-D image that is a compilation of the rois
% formed by centering spheres of size roi_size at center x,y,z.
% Dependenies: marsbar and spm

% for the creation of two rois centered at 0,0,0 (value 4) and 
% 10,10,10 (value 7), below is an example
%rois = [0,0,0,4;
%        10,10,10,7];
%roi_size = 3 % radius of sphere in mm



num_rois=size(rois,1);

for i=1:num_rois
    o = maroi_sphere(struct('centre',rois(i,1:3),'radius',roi_size));
    o= o*rois(i,4);
    if i==1 
       sum_rois=o;
    else
       sum_rois= o + sum_rois;
    end
end


% saves the image
save_as_image(sum_rois,'output.nii');
gzip('output.nii');

output_image='output.nii.gz';