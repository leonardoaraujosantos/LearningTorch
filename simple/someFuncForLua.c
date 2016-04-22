/*
  One of the most coolest stuff on Lua is that is easy to mix with C/C++ in both
  directions, here we want to expose a function to lua

  How to compile:
  gcc -Wall -shared -fPIC -o someFunForLua.so -I/usr/include/lua5.1 -L/home/leo/.luarocks/lib/lua/5.1 -lluaT someFuncForLua.c

  Using:
  leo@leodev:~/work/Lua/Learning_Torch/simple$ th

  ______             __   |  Torch7
 /_  __/__  ________/ /   |  Scientific computing for Lua.
  / / / _ \/ __/ __/ _ \  |  Type ? for help
 /_/  \___/_/  \__/_//_/  |  https://github.com/torch
                          |  http://torch.ch

th> require("someFunForLua")
true
                                                                      [0.0003s]
th> addFast(1,2)
3
                                                                      [0.0001s]
th>

*/
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int addFast(lua_State *L);
// Function that will be available to Lua
int addFast(lua_State *L) {
  // Get parameters from Lua state
  double n1 = lua_tonumber(L,1);
  double n2 = lua_tonumber(L,2);

  lua_pushnumber(L,n1+n2);

  // Return the number of values that will be pushed to the Lua stack
  return 1;
}

// Observe that the name luaopen_someFunForLua is related to the name of the
// shared library
int luaopen_someFunForLua(lua_State *L){
	lua_register(
			L,               /* Lua state variable */
			"addFast",        /* func name as known in Lua */
			addFast          /* func name in this file */
			);
	return 0;
}
