--[[
  How to do a multiline comments on Lua, first introduction to the Lua Language
]]

-- Include file funcSoma.lua
require "funcSoma"

-- Emulate a namespace (factory.something)
local factory = require "objectSimple"

-- Print some message
print("Hello World");

-- Simple math
a = 4;
b = 3;

-- Here the variable c is local to the file main.lua
local c = a*b;

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

-- Using tables (You can put variables, constants and even functions)
-- Like in matlab, cells,tables,arrays start at 1
-- We do Object oriented programming in Lua with the tables...
items = {1,"Bread", "Milk", 666, otherFunc=function() print("CrazyFunc")end, 10}
items.otherFunc();

-- We can add other functions to the table items
function items:sayHi()
  print("Hi");
end
-- Call the other added function (two possible ways)
items.sayHi();
items:sayHi();

-- Get the number of items
print("Number of items ==" .. #items);

-- While example
cont = 1;
while cont <= #items do
  print("items[".. cont .. "]=" .. items[cont]);
  cont = cont + 1;
end

-- Play with OOP (Check file objectSimple.lua)
instLeo = factory.newPerson("Leonardo",33);
print(instLeo)

print("Get leo age");
print(instLeo.getAge());
instLeo.doBirthDay();
print("Get leo age after one year");
print(instLeo.getAge());

-- Get something from the keyboard
--someValue = io.read();
