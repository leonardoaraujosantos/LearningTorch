-- This is needed on lua 5.0 to have a name on the require (emulate namespace)
module(..., package.seeall)
--[[
  Simple class example in lua
]]

-- Imagine this as a object factory
function newPerson(name, age)

  -- We're going to return a Person class with name and age, with methods
  -- getName, getAge and doBirthday
  local objectInstance = {};
  objectInstance.name = name;
  objectInstance.age = age;

  function objectInstance:getName()
    return objectInstance.name;
  end

  function objectInstance:getAge()
    return objectInstance.age;
  end

  function objectInstance:doBirthDay()
    objectInstance.age = objectInstance.age + 1;
    return objectInstance.age;
  end

  return objectInstance;
end
