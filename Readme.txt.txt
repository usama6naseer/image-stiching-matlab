*****RUN TEST.M TO SEE RESULT*****


I took image and converted it into gray scale.
I applied the Gaussian filter.
I then calculated x and y derivatives to find edges using conv2()
To apply KLT i found the A matrix by moving a window on entire gray scale and finding the A matrix by:
		    a(1,1) = a(1,1) + devx.^2;
                    a(1,2) = a(1,2) + devx.*devy;
                    a(2,1) = a(2,1) + devx.*devy;
		    a(2,2) = a(2,2) + devy.^2;
                
For each window, I found its eigen value and applied a screening process that min of its eigen values must be greater than threshold.
I then applied maxima sippression to reduce the number of points in clusters.

In the correspondence part, I calculted a window of pixels around each corner point and finding its squared difference with every such window of all corner points in other 
image. Points having least difference will have most correspondence.

*****RUN TEST.M TO SEE RESULT*****
