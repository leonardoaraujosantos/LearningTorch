require "string"
-- Simple function without argument and return value
function saySomething()
	io.write("Some message from Lua.\n")
end

-- Function with 1 argument and 1 return value
function square(n)
	io.write("Within callfuncscript.lua fcn square, arg=")
	io.write(tostring(n))
	n = n * n
	io.write(", square=")
	io.write(tostring(n))
	print(".")
	return(n)
end

-- Function with 2 arguments and 1 return value
function addSomething(a,b)
	io.write('Add something')
	return (a+b)
end


-- Function with table argument
function showTableContent(tab_in)
	-- Iterate on lua table
	for idx,val in pairs(tab_in) do
		io.write(string.format("idx=%d val=%d\n",idx,val))
	end
end

function addTableContent(tab_in)
	-- Iterate on lua table
	acc = 0;
	for idx,val in pairs(tab_in) do
		acc = acc + val
	end
	return acc
end

function addOne(tab_in)
	local tab_out = {}
	-- Iterate on lua table
	for idx,val in pairs(tab_in) do
		tab_out[idx] = val+1
	end
	return tab_out
end


print("Priming run (Needed before calling functions)")
--b = {};
--b[1] = 0;
--b[2] = 10;
--b[3] = 20;
--b = {10,20,30,40}
--c = addOne(b)
--showTableContent(b)
--showTableContent(c)
