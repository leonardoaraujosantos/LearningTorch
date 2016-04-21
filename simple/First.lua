-- First contact with Lua and Torch

-- Create a function
function addValues(a,b)
  return a + b;
end

function addTensors(a,b)
    return a + b;
end

-- Assign a string
a = 'Some String';
-- Print something
print(a);
a = 'First element of b';

-- Create a "cell" in lua table
b = {};
b[1] = a;
b[2] = 10;

for cont=1,10 do
  print(cont)
end

-- Iterate on all elements of b
for i=1,#b do
  print(b[i]);
end

print(addValues(3,4));

-- Start torch module
require 'cutorch';

print('\nCreate 5x3 tensor');
a = torch.Tensor(5,3);
a = torch.ones(5,3);
print(a);

print('\nCreate 3x4 random tensor');
c = torch.rand(5,3);
print(c);

print('\nCreate 3x4 tensor and fill it with values 2(B)');
b = torch.Tensor(3,4):fill(2);
print(b);
print('Tensor A');
print(a);

-- Different syntax for matrix multiplication
c = a * b;
c = torch.mm(a,b);
c = torch.Tensor(5,4);
c:mm(a,b);
print(a*b)


-- Send data do the GPU
a = a:cuda();
b = b:cuda();
-- Re-do on the GPU
c = a*b;
print('a*b on GPU');
print(a*b)

-- Test function to add Tensors
print('Adding tensors')
a = torch.ones(5,2);
b = torch.Tensor(2,5):fill(4);
print(addTensors(a,b));