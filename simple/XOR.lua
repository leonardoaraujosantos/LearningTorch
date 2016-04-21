require 'torch';
require 'nn';

inputs=torch.Tensor({{0, 0}, {0,1}, {1,0}, {1,1}})
outputs=torch.Tensor({{0},{1},{1},{0}})
dataset={};
function dataset:size() return 4 end 
for i=1,dataset:size() do
    print(i)
end
dataset={ {torch.Tensor({0,0}),torch.Tensor({0})}, {torch.Tensor({0,1}),torch.Tensor({1})}, {torch.Tensor({1,0}),torch.Tensor({1})} , {torch.Tensor({1,1}),torch.Tensor({0})}}
print(dataset:size())
