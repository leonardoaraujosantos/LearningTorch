-- Definign the Lenet
require 'nn';
LeNetInstance = nn.Sequential()
LeNetInstance:add(nn.SpatialConvolution(1, 6, 5, 5)) -- 1 input image channel, 6 output channels, 5x5 convolution kernel
LeNetInstance:add(nn.ReLU())                       -- non-linearity 
LeNetInstance:add(nn.SpatialMaxPooling(2,2,2,2))     -- A max-pooling operation that looks at 2x2 windows and finds the max.
LeNetInstance:add(nn.SpatialConvolution(6, 16, 5, 5))
LeNetInstance:add(nn.ReLU())                       -- non-linearity 
LeNetInstance:add(nn.SpatialMaxPooling(2,2,2,2))
LeNetInstance:add(nn.View(16*5*5))                    -- reshapes from a 3D tensor of 16x5x5 into 1D tensor of 16*5*5
LeNetInstance:add(nn.Linear(16*5*5, 120))             -- fully connected layer (matrix multiplication between input and weights)
LeNetInstance:add(nn.ReLU())                       -- non-linearity 
LeNetInstance:add(nn.Linear(120, 84))
LeNetInstance:add(nn.ReLU())                       -- non-linearity 
LeNetInstance:add(nn.Linear(84, 10))                   -- 10 is the number of outputs of the network (in this case, 10 digits)
LeNetInstance:add(nn.LogSoftMax())                     -- converts the output to a log-probability. Useful for classification problems

print('Lenet5\n' .. LeNetInstance:__tostring());

-- pass a random tensor as input to the network
input = torch.rand(1,32,32);

-- Calculate the output of this network
output = LeNetInstance:forward(input);
print(output);

-- zero the internal gradient buffers of the network (will come to this later)
LeNetInstance:zeroGradParameters();
gradInput = LeNetInstance:backward(input, torch.rand(10));
print(#gradInput);

-- a negative log-likelihood criterion for multi-class classification
-- Criterions are helpful to train a neural network. Given an input and a target, 
-- they compute a gradient according to a given loss function.
-- ClassNLLCriterion: negative log-likelihood for LogSoftMax (multi-class);
criterion = nn.ClassNLLCriterion() 
-- let's say the groundtruth was class number: 3
criterion:forward(output, 3) 
gradients = criterion:backward(output, 3)

gradInput = LeNetInstance:backward(input, gradients)

--[[ 
A neural network layer can have learnable parameters or not.
A convolution layer learns it's convolution kernels to adapt to the input data and the problem being solved.
A max-pooling layer has no learnable parameters. It only finds the max of local windows.
A layer in torch which has learnable weights, will typically have fields .weight (and optionally, .bias)

The operation in a convolution layer is: output = convolution(input,weight) + bias
--]]

m = nn.SpatialConvolution(1,3,2,2) -- learn 3 2x2 kernels
print(m.weight) -- initially, the weights are randomly initialized