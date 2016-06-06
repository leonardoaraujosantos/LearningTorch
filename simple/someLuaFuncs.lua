function saySomething()
	io.write("Some message from Lua.\n")
end

function square(n)
	io.write("Within callfuncscript.lua fcn square, arg=")
	io.write(tostring(n))
	n = n * n
	io.write(", square=")
	io.write(tostring(n))
	print(".")
	return(n)
end

function addSomething(a,b)
	io.write('Add something')
	return (a+b)
end

print("Priming run")
