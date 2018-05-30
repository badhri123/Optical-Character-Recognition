function [v,x] = Slidingwindow(x,t)

% t=minimum sum of pixel values for assuming the beginning or end of digit in the image. 
x=rgb2gray(x);
x=imcomplement(x);
mi=min(min(x));
x=x-mi;
x=x>=100;

% entry and exit are the variables containing the range of column numbers
% inside which the digit lies.

entry=1;
exit=1;
v=[1];
k=1;
flag1=0;
flag2=0;
[m,n]=size(x);

% Segmentation 

while k<=n
    
if sum(x(:,k))>=t                % When the column number k touches the beginning of an image(t=minimum threshold for assuming the beginning of a digit)
    flag1=1;
end

if flag1==1 && flag2==1 && sum(x(:,k))>=t          % When the column number exits a digit
    entry=k;
    v=[v;ceil((entry+exit)/2)];    % Average is taken to ensure maximum margin
    flag2=0;
end
if flag1==1 && sum(x(:,k))==0                      % When the column number enters the next digit
    exit=k;
    flag2=1;
    flag1=0;
end
k=k+1;

end

v=[v;n];                          % All the columns values containing the information about the spacing of digit are stored in vector v

    


end

