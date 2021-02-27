# Signal and image processing - simple Matlab tutorial

### Overview:
- [Description](#description)
- [Signal processing summary](#signal-processing)
- [Image processing summary](#image-processing)
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
