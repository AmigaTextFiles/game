#ifndef LUA_H
#define LUA_H

#include "lua/lua.h"


lua_State *L;

int lua_init();
void lua_exit();

#endif
