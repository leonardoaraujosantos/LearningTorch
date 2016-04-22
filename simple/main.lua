--[[
  How to do a multiline comments on Lua
]]

-- Include file funcSoma.lua
require "funcSoma"

-- Print some message
print("Hello World");

-- Simple math
a = 4;
b = 3;
c = a*b;

-- How to do the if
if c>10 then
  print("Result " .. a .. " x " .. b .. " = " .. c);
else
  print("Should not be here");
end

print("Result " .. a .. " + " .. b .. " = " .. someFunc(a,b));

print("Check if z exist with nil")
if z == nil then
  print("Variable z does not exist\n")
end

for i=1,10 do
  print("Counter is " .. i);
end

-- Using tables
items = {1,"Bread", "Milk", 666}
print(items);
-- Like in matlab, cells,tables,arrays start at 1
print(items[2]);
print("Number of items ==" .. #items);

-- While example
cont = 1;
while cont <= #items do
  print("items[".. cont .. "]=" .. items[cont]);
  cont = cont + 1;
end
-- Get something from the keyboard
--someValue = io.read();
