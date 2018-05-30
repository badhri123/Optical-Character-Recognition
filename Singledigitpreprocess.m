function [ iscentered,icentered,iraw] = Singledigitpreprocess( i )




[m,n]=size(i);
i=imcomplement(i);
mi=min(min(i));
i=i-mi;
i2=i;
i=i>=100;       % Threshold pixel intensity 100 succesfully eliminates any noise present

iraw=i;                 

% Centering the digit in the segmented image



% Starting from the top,flag1 takes the row value at which the digit
% begins(Seen from top)

% flag1=Row value till which the image does not contain digit.
% flag2=Row value after which the image does not contain digit.
flag1=0;
p=1;
while p<=m && flag1==0
    
    if sum(i(p,:))>=10
        flag1=p;
    end
    p=p+1;
end

% Staring from the bottom,flag2 takes the row value at which the digit
% ends(Seen from bottom)
flag2=0;
q=m;
while q>=1 && flag2==0
    if sum(i(q,:))>=10
        flag2=m-q;
    end
    q=q-1;
end

% Same procedure is used for columns
% flag11=column value till which image does not contain the digit
% flag22=column value after which the image does not contain the digit.

flag11=0;
pp=1;
while pp<=n && flag11==0
    if sum(i(:,pp))>=10
        flag11=pp;
    end
    pp=pp+1;
end
flag22=0;
qq=n;
while qq>=1 && flag22==0
    if sum(i(:,qq))>=10
        flag22=n-qq;
    end
    qq=qq-1;
end

% Vertical Centering

% The difference of flag1 and flag2 represents the excess area (above or
% below) that can be removed.The removed area is equally split and added
% below and above the image.

if flag1>=flag2
    ex1=flag1-flag2;
    i(1:ex1,:)=[];
    exd1=ceil(ex1/2);
    i=[zeros(exd1,n);i];
    exd2=ex1-exd1;
    i=[i;zeros(exd2,n)];
else
    ex1=flag2-flag1;
    i(m-ex1:end,:)=[];
    exd1=ceil(ex1/2);
    i=[i;zeros(exd1,n)];
    exd2=ex1-exd1;
    i=[zeros(exd2,n);i];
end
[m,n]=size(i);

% Horizontal centering

% Similar procedure as above is used and the excess area either to the left of the digit 
% or right of the digit is removed and added equally on both sides.  

if flag11>=flag22
    ex1=flag11-flag22;
    i(:,1:ex1)=[];
    exd1=ceil(ex1/2);
    i=[zeros(m,exd1),i];
    exd2=ex1-exd1;
    i=[i,zeros(m,exd2)];
else
    ex1=flag22-flag11;
    i(:,n-ex1:end)=[];
    exd1=ceil(ex1/2);
    i=[i,zeros(m,exd1)];
    exd2=ex1-exd1;
    i=[zeros(m,exd2),i];
end

%  This extra step of centering was helpful and was found emperically

[m,n]=size(i);
h=ceil((m-n)/2);
i(1:h,:)=[];
i(end-(h-1):end,:)=[];
yt=ceil((m-n)/4);
i=[zeros(yt,n);i];
i=[i;zeros(yt,n)];


icentered=i;

% The centered image was resized to 28x28  and given as final output.

i=imresize(i,[28,28]);        
me=mean(mean(i));
i=i>me;
i=i*255;
iscentered=i;
  

    



