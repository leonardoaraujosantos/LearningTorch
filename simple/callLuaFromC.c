/*Call lua from C
Tutorials and Reference:
http://www.troubleshooters.com/codecorn/lua/lua_c_calls_lua.htm
https://john.nachtimwald.com/2014/07/26/calling-lua-from-c/

Installing lua 5.1
sudo apt-get install lua5.1
sudo apt-get install liblua5.1-0-dev

Compiling
gcc callLuaFromC.c -o callLuaFromC -I/usr/include/lua5.1 -llua5.1

Future notes: Add this arround a mex file and deal with matlab arrays
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

// Used to push an array of integers
void pushIntegetArray(lua_State *L, int *array, int size)
{
  lua_newtable(L);
  int idx;
  for (idx=0;idx < size; idx++)
  {
      lua_pushinteger(L, idx); //-2
      lua_pushinteger(L, array[idx]); // -3
      lua_settable(L,-3);
  }
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
  printf("SAY SOMETHING ###################################################\n");
  lua_getglobal(L, "saySomething");

  // Call the function (No arguments, no return value)
  if (lua_pcall(L, 0, 0, 0))
    luaError(L, "lua_pcall() failed");

  // Call function with one argument and one output
  // Push to stack function name
  printf("SQUARE ##########################################################\n");
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
  printf("ADD SOMETHING ###################################################\n");
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

  printf("SEND ARAY #######################################################\n");
  printf("In C, calling Lua->tweaktable()\n");
  int c_array[] = {10,20,30,40};
  lua_getglobal(L, "showTableContent");

  pushIntegetArray(L,c_array,4);

  if (lua_pcall(L, 1, 0, 0))                  /* Run function, !!! NRETURN=1 !!! */
    luaError(L, "lua_pcall() failed");


  printf("SEND ARAY GET SCALAR RESULT #####################################\n");
  printf("In C, calling Lua->tweaktable()\n");
  lua_getglobal(L, "addTableContent");

  pushIntegetArray(L,c_array,4);

  if (lua_pcall(L, 1, 1, 0))                  /* Run function, !!! NRETURN=1 !!! */
    luaError(L, "lua_pcall() failed");

  // Gather result (pop one item from stack)
  resultLua = lua_tonumber(L, -1);
  printf("Returned number for addTableContent(10,20,30,40)=%d\n",resultLua);

  printf("SEND ARAY GET ARRAY RESULT ######################################\n");
  printf("In C, calling Lua->tweaktable()\n");
  lua_getglobal(L, "addOne");

  pushIntegetArray(L,c_array,4);

  if (lua_pcall(L, 1, 1, 0))                  /* Run function, !!! NRETURN=1 !!! */
    luaError(L, "lua_pcall() failed");

  // Gather result (pop one item from stack)
  lua_pushnil(L);  /* Make sure lua_next starts at beginning */
  int k, v;
  while (lua_next(L, -2)) {                    /* TABLE LOCATED AT -2 IN STACK */
      v = lua_tonumber(L, -1);                 /* Value at stacktop */
      lua_pop(L,1);                            /* Remove value */
      k = lua_tonumber(L, -1);                 /* Read key at stacktop, */
                                               /* leave in place to guide next lua_next() */
      printf("On C/C++ array_out[%d]=%d\n", k, v);
  }

  printf("Back in C again\n");

  // Clean lua states
  lua_close(L);

  return 0;
}
