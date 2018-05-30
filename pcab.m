function [ score,z,u1] = pcab( x,k )

% Description: This function uses Singular Value Decomposition to generate
% a matrix (u).The first k (Required Dimension) dimensions
% are taken and z is computed by applying u on the dataset x.
% The score is then calculated which represents the variance obtained with
% k dimension.
m=length(x);
sigma=(1/m)*x'*x;
[u,s,v]=svd(sigma);
u1=u(:,1:k);
z=(u1'*x')';
score=sum(diag(s(1:k,1:k)))/sum(diag(s));

end

