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

-- Hijacked from tutorial remove later
function tweaktable(tab_in)
	local tab_out = {numfields=1}
	for k,v in pairs(tab_in) do
		tab_out.numfields = tab_out.numfields + 1
		tab_out[tostring(k)] = string.upper(tostring(v))
	end
	tab_out.numfields = tostring(tab_out.numfields)
	io.write("At bottom of callfuncscript.lua tweaktable(), numfields=")
	io.write(tab_out.numfields)
	print()
	return tab_out
end

print("Priming run (Needed before calling functions)")
--b = {};
--b[1] = 0;
--b[2] = 10;
--b[3] = 20;
b = {0,10,20,30}
showTableContent(b)
