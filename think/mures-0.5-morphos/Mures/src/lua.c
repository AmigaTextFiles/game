#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "SDL.h"
#include "lua.h"

/*
static int lua_load_image(lua_State *L)
{
  if(lua_gettop(L) != 2)
    lua_error(L, "wrong number of arguments to register_image (should be 2)");

  if(!lua_isnumber(L, 1))
    lua_error(L, "bad first argument to register_image");
  
  if(!lua_isstring(L, 2))
    lua_error(L, "bad second argument to register_image");

  printf("LOADING image for surface %d as %s\n", (int)lua_tonumber(L, 1), lua_tostring(L, 2));
  
  return 0;
}
*/


static int lua_write(lua_State *L)
{
  if(lua_gettop(L) != 1)
    lua_error(L, "wrong number of arguments to write");
  
  if(!lua_isstring(L, 1))
    lua_error(L, "write takes a string");
  
  printf("%s", lua_tostring(L, 1));
  
  return 0;
}

int lua_init()
{
  printf("Initializing lua.\n");
  
  L = lua_open(0);
  
  if(L==NULL)
    return 0;
  
  lua_register(L, "write", lua_write);

  return 1;
}

void lua_exit()
{
  printf("Closing lua.\n");
  lua_close(L);
}  

/*
int main()
{
  lua_pushnumber(L, 100);
  lua_setglobal(L, "MOUSE");
  
  lua_register(L, "load-image", lua_load_image);
  lua_register(L, "write", lua_write);
  
  lua_dofile(L, "test.lua");
  
  return 0;
}

*/
