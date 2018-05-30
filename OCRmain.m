function [ v1 ] = OCRmain( i )
v1=[];

% Segmentation is done first where the input is raw image containing
% multiple digits

[v,x]=Slidingwindow(i,10);
i=rgb2gray(i);
l=length(v)
no=l-1;
k=1;

% The information about the spacing of the individual digits in the image
% is used and each segmented image is preprocessed and used for
% classification.

while k<=no
    itemp=i(:,v(k):v(k+1));     % Segmentation
    [a,b,c]=Singledigitpreprocess(itemp);   % Preprocessing
    a=a';
    [y,h]=mnist_predict(a);     % Prediction
    
    v1=[v1;y];
    k=k+1;
    
end
v1=v1(:);
t=1;
it=[];

% The following code was just for displaying the output and is not of
% importance.

while t<=no
    
    g=displ(v1(t));
    it=[it,g];
    
    
    t=t+1;
end

it=imresize(it,[100,200]);

imshow(it);    


end

