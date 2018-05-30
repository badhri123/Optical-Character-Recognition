function [y1,h] = mnist_predict( x)

% The input image is 28x28 and hence,is reshaped to a 784(28x28) length row
% vector
x=reshape(x,1,784);
% "pcatransform.mat" has the transformation matrix obtained from the
% training dataset.
load('pcatransform.mat');
x=(u'*x')';
x=[1,x];

% The training was done and the final weights were saved

load('theta1_mnist.mat');
load('theta2_mnist.mat');

% Prediction

% Forward Propogation

z2=theta1*x';
a2=sigmoid(z2);
a2=[1;a2];
z3=theta2*a2;
h=sigmoid(z3);
[a,b]=max(h);
% h is the vector containing the probabilities for all 10 classes.
% y1 is the predicted digit
y1=b-1;



end

