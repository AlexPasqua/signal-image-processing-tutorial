# Signal and image processing - simple Matlab tutorial

### Overview:
- [Description](#description)
- [Signal processing summary](#signal-processing)
- [Image processing summary](#image-processing)
- [More in depth signal processing](#more-in-depth-signal-processing)
- [More in depth image processing](#more-in-depth-image-processing)
---

### Description
This is a very short and simple demo/tutorial for signal and image processing with **Matlab** without using specific high-level libraries

#### Signal processing:
- We start from a clean sinusoid
- Add some Gaussian noise and few other sinusoids ad different frequencies to mess the signal up a little bit.
- Perform a **low pass filtering**
- Perform a **moving average filtering**
- Finally perform a moving average filtering on the previously low-pass filtered signal
- plot the signals to see the results

#### Image processing:
- Read the input image `lena_noise.png` -> it is a grayscale image with Gaussian noise
- Create kernels/filters:
  - **Laplacian filtering:** edges enphasizing
  - **Directional filtering**
  - **High-pass filtering:** sharpening
- Perform **convolution** between the image and the filters
- Show the better-looking output image

## More in depth explanation
### More in depth signal processing:
#### Low-pass filter:
**LTI filter** --> system equation:
<img src="https://render.githubusercontent.com/render/math?math=\Large \Sigma_{i=0}^n a_i v[k-i] = \Sigma_{i=0}^n b_i u[k-i]"><br>

For filters, it is useful to design in the _frequency domain_ --> **Z Transform**

<img src="https://render.githubusercontent.com/render/math?math=\Large Y(z) = H(z)X(z)">

Transfer function H(z): a filter's behavior can be entirely described by its transfer function

<img src="https://render.githubusercontent.com/render/math?math=\Large H(z) = \frac{b_0%2B\Sigma_{j=1}^n b_j z^{-j}}{a_0%2B\Sigma_{k=1}^m a_k z^{-k}}"><br>

In Matlab we have a signal with white noise and some high frequency disturbing components, so I used `butter` to get the transfer function of a low-pass filter to cut off those waves

Output:

<img src="https://render.githubusercontent.com/render/math?math=\Large \Sigma_{k=0}^m a_k y[i-k] = \Sigma_{j=0}^n b_J x[i-j]"><br><br>
<img src="https://render.githubusercontent.com/render/math?math=\LARGE y[i] = \frac{(\Sigma_{j=0}^n b_j x[i-j])-(\Sigma_{k=1}^m a_k y[i-k])}{a_0}">

The i-th value of the output needs the previous output values, how many depends on the degree of the transfer function.<br>
In out case the degree is 8, so I forced the first 7 values of the output to zero.<br>
**Collateral effect:** this introduced a slight phase shifting

#### Moving average:
We have a window of dimension d, make it slide through the signal and every point of it is 	approximated to the average of the adjacent d values.<br>
It’s important to choose a correct window dimension:<br>
<div>
  <img src="assets/moving_average-too_small_window.png" height=240>
  <img src="assets/moving_average-too_large_window.png" height=240>
</div>

### More in depth image processing
**Image filtering:** create a kernel/filter and make it slide on the image performing **convolutions**

<img src="https://render.githubusercontent.com/render/math?math=\Large g(x,y) = \omega * f(x,y) = \Sigma_{s=-a}^a \Sigma_{t=-b}^b \omega(s,t) f(x-s,y-t)"><br><br>
<img src="assets/convolution.png" height=180>

In our case, the input image is blurred and we apply:
- **Laplacian** filter for _edge enphasizing_
- **Directional** filter
- **High-pass** filter for _sharpening_

<div>
  <img src="assets/laplacian_filter.png" height=80 width=100>
  <img src="assets/directional_filter.png" height=80 width=100>
  <img src="assets/high-pass_filter.png" height=80 width=100>
</div>
