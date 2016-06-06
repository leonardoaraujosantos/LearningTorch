/*Call lua from C
Tutorials and Reference:
http://www.troubleshooters.com/codecorn/lua/lua_c_calls_lua.htm

Installing lua 5.1
sudo apt-get install lua5.1
sudo apt-get install liblua5.1-0-dev

Compiling
gcc callLuaFromC.c -o callLuaFromC -I/usr/include/lua5.1 -llua5.1
*/
#include <stdio.h>

// Always put those headers for calling lua functions
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include <stdlib.h>

// Called on lua Error
void luaError(lua_State *L, char *msg)
{
  fprintf(stderr, "\nFATAL ERROR:\n  %s: %s\n\n",msg, lua_tostring(L, -1));
  exit(1);
}

int main(void)
{
  printf("Calling a lua function from C\n");

  lua_State *L;

  // Create lua states and load libraries
  L = luaL_newstate();
  luaL_openlibs(L);

  // Load script, observe that we call luaError in case of error
  if (luaL_loadfile(L, "someLuaFuncs.lua"))
    luaError(L, "luaL_loadfile() failed");


  // Check first if file is ok (Need to call this prior to everything else)
  if (lua_pcall(L, 0, 0, 0))
    luaError(L, "lua_pcall() failed");

  // Indicate function that will be called (Push function to lua stack)
  lua_getglobal(L, "saySomething");

  // Call the function
  if (lua_pcall(L, 0, 0, 0))
    luaError(L, "lua_pcall() failed");

  // Call function with one argument and one output
  // Push to stack function name
  lua_getglobal(L, "square");

  // Push to stack first argument
  lua_pushnumber(L, 6);

  // Call function (one argument, 1 return value)
  if (lua_pcall(L, 1, 1, 0))
    luaError(L, "lua_pcall() failed");

  // Gather result (pop one item from stack)
  int resultLua = lua_tonumber(L, -1);
  printf("Returned number for lua_square(6)=%d\n",resultLua);


  // Call function with two argument and one output
  // Push to stack function name
  lua_getglobal(L, "addSomething");

  // Push to stack 2 arguments
  lua_pushnumber(L, 6);
  lua_pushnumber(L, 4);

  // Call function (two argument, 1 return value)
  if (lua_pcall(L, 2, 1, 0))
    luaError(L, "lua_pcall() failed");

  // Gather result (pop one item from stack)
  resultLua = lua_tonumber(L, -1);
  printf("Returned number for lua_addSomething(6,4)=%d\n",resultLua);

  printf("Back in C again\n");

  // Clean lua states
  lua_close(L);

  return 0;
}
