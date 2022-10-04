pc = imread("Z:\research\paccitytest.jpg");
%figure
%imshow(pc)
%title("Pacific City color")

numclasses = 4;
L = imsegkmeans(pc,numclasses);
B = labeloverlay(pc,L,Transparency=0);
%figure
%imshow(B)
%title("4 kmeans classes")

% lab_pc = rgb2lab(pc);
% 
% ab = lab_pc(:,:,2:3);
% ab = im2single(ab);
% pixel_labels = imsegkmeans(ab,numclasses,NumAttempts=3);
% 
% B2 = labeloverlay(pc,pixel_labels);
% imshow(B2)
% title("Labeled Image a*b*")

im_left = pc; % opening two example images
im_right = B;
f = figure();
f.Position = [100 100 1500 1000];
ax = axes('Units', 'pixels');
imshow(im_left);
hold(ax);
im_handle = imshow(im_right);
im_handle.AlphaData = zeros(size(im_left, [1 2]));
axes_pos = cumsum(ax.Position([1 3]));
f.WindowButtonMotionFcn = {@cb,  size(im_left,2), im_handle, axes_pos};
function cb(obj, ~, im_width, im_handle, axes_pos)
    x_pos = obj.CurrentPoint(1);
    if x_pos > axes_pos(1) && x_pos < axes_pos(2)
        left_cols = floor(floor(x_pos - axes_pos(1))/diff(axes_pos) * im_width);
        im_handle.AlphaData(:, 1:left_cols) = 0;
        im_handle.AlphaData(:, left_cols+1:end) = 1;
    end
end