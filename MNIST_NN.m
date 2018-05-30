%% MNIST Hand-written Digit classification

% Author-S.Badhri Narayanan

% Loading and creating Dataset

load('mnist_all.mat');
x=[train0,ones(length(train0),1).*0;train1,ones(length(train1),1).*1;train2,ones(length(train2),1).*2;train3,ones(length(train3),1).*3;train4,ones(length(train4),1).*4;train5,ones(length(train5),1).*5;train6,ones(length(train6),1).*6;train7,ones(length(train7),1).*7;train8,ones(length(train8),1).*8;train9,ones(length(train9),1).*9];
y=x(:,785);
y=double(y);
x(:,785)=[];
m=length(x);
xtest=[test0,ones(length(test0),1).*0;test1,ones(length(test1),1).*1;test2,ones(length(test2),1).*2;test3,ones(length(test3),1).*3;test4,ones(length(test4),1).*4;test5,ones(length(test5),1).*5;test6,ones(length(test6),1).*6;test7,ones(length(test7),1).*7;test8,ones(length(test8),1).*8;test9,ones(length(test9),1).*9];
ytest=xtest(:,785);
ytest=double(ytest);
xtest(:,785)=[];

% Feature Extraction

input=280;  % The number of input units ( After Feature extraction)
x=double(x);
xtest=double(xtest);
[score,x,u]=pcab(x,input);     % Principal Component Analysis
xtest=(u'*xtest')';            % The transformation matrix (u1) obtained from training is used on test data set.

m=length(x);
mt=length(xtest);
xtest=[ones(mt,1),xtest];
x=[ones(m,1),x];

pp=randperm(m,m);              % The Training dataset is shuffled 
x=x(pp,:);
y=y(pp);

p2=randperm(mt,mt);            % The test dataset is shuffled
xtest=xtest(p2,:);
ytest=ytest(p2);

% Parameter initialization

alpha=0.9;                    % Learning rate
lambda=4*10^(-3);             % Regularization parameter
hid=300;                      % Number of Hidden units=300
iterations=2000;              % Number of Gradient descent (Batch gradient descent) iterations
theta1=rand(hid,input+1);      
theta2=rand(10,hid+1);

% Vectorizing the labels ( One-hot representation)

yt=zeros(10,m);
f=1;
while f<=m
    yt(y(f)+1,f)=1;
    f=f+1;
end

% Gradient descent 

cost=[];
i=1;

while i<=iterations
    bdel1=zeros(hid,input+1);
    bdel2=zeros(10,hid+1);
    
    % Forward Propogation
    
    z2=theta1*x';
    a2=sigmoid(z2);
    a2=[ones(1,m);a2];
    z3=theta2*a2;
    h=sigmoid(z3);
    
    
    
    % Back propogation
    
    del3=h-yt;
    del2=(theta2'*del3).*(a2.*(1-a2));
    del2(1,:)=[];
    
    bdel1=del2*x;
    bdel2=del3*a2';
    
    D1=(1/m)*bdel1;
    D2=(1/m)*bdel2;
    D1(:,2:end)=D1(:,2:end)+lambda*theta1(:,2:end);
    D2(:,2:end)=D2(:,2:end)+lambda*theta2(:,2:end);
    
    % For the last 500 iterations,the learning rate is slowly reduced to
    % avoid overshooting
    if i>=1500
        alpha=alpha-0.0014;
    end
    
    % Weight Update
    
    theta1=theta1-alpha*D1;
    theta2=theta2-alpha*D2;
    
    % Cost is computed every 2iterations
    
    if mod(i,2)==0
        
        temp=(-1/m)*( sum(sum( yt.*log(h) + (1-yt).*log(1-h) ) ) )  + (lambda/(2*m))*( sum(sum(theta1.^2)) + sum(sum(theta2.^2)));
        cost=[cost;temp];
    end
    
    i=i+1
end




% Testing

% Forward Propogation

zt2=theta1*xtest';
at2=sigmoid(zt2);
at2=[ones(1,mt);at2];
zt3=theta2*at2;
ht=sigmoid(zt3);


[v,w]=max(ht);                % The test example belongs to the class having largest probability
w=w(:);
w=w-1;
error=abs(w-ytest);
errors=error~=0;              % Misclassification error is computed
errors=sum(errors);
accuracy=(1-(errors/mt))*100
plot(cost)


% Testing with Training data
% ( This was done to check whether overfitting was occuring)

ztr2=theta1*x';
atr2=sigmoid(ztr2);
atr2=[ones(1,m);atr2];
ztr3=theta2*atr2;
htr=sigmoid(ztr3);
[vr,wr]=max(htr);
wr=wr(:);
wr=wr-1;
err=abs(wr-y);
err=err~=0;
errs=sum(err);
train_accuracy=(1-(errs/m))*100