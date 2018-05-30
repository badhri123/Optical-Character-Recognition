MNIST Handwritten Digit Recognition( MATLAB Implementation)

The descriptions for all functions are given briefly.

1.MNIST_NN.m : A Neural network (1-hidden layer) was trained using Back propogation with 60000 examples of Hand written digit images and made.

The trained weights were stored after good performance of the classifier was obtained.
The trained weights ,transformation matrix in PCA ,the dataset used are also present in the zip file.


2.mnist_predict:This function takes as input a new test image and predicts the digit in it with the trained weights available.

3.windowing.m: This function segments a raw image containing multiple digits into images having only one digit.
The output of this function are column numbers representing the values at which segmentation needs to be done.

4.Singledigitpreprocess:This function takes as input the image containing a single digit and preprocesses it.

5.OCRmain:This is main program combining all the other functions.This takes the raw image containing multiple digits as input and produces a list of digits as output.

