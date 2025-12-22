/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 
 /*
  * Template classes defined for callbacks
  * 
  * Template classes allow callbacks for either standard methods or for
  * methods which are part of a class to be used interchange for events such
  * as button / mouse clicks
  * 
  */
 
#ifndef CALLBACK_H
#define CALLBACK_H

//----------------------------------------
// l i b r a r y c o d e 
//----------------------------------------

//----------------------------------------
// no parameters,  no return
//----------------------------------------
class Callback0Base
{
public:
  virtual void operator()() const = 0;
  virtual Callback0Base* clone() const = 0;
};


// Defined for a class
//----------------------------------------
template <class Client>
class Callback0:
  public Callback0Base
{
public:
  typedef void (Client::*PMEMFUNC)();

  Callback0(Client& client_,PMEMFUNC pMemfunc_):
    _client(client_), 
    _pMemfunc(pMemfunc_)
{}

  /*virtual*/ void operator()() const
  {(_client.*_pMemfunc)();}

  /*virtual*/ Callback0<Client>* clone() const 
  {return new Callback0<Client>(*this);}

private:
  Client& _client;
  PMEMFUNC _pMemfunc;
};

// Defined for normal functions
//----------------------------------------
class Callback0s:
  public Callback0Base
{
public:
  typedef void (*PMEMFUNC)();

  Callback0s(PMEMFUNC pMemfunc_):
    _pMemfunc(pMemfunc_)
{}

  /*virtual*/ void operator()() const
  {(_pMemfunc)();}

  /*virtual*/ Callback0s* clone() const 
  {return new Callback0s(*this);}

private:
  PMEMFUNC _pMemfunc;
};

//----------------------------------------
// One parameter no return
//----------------------------------------
template <class P1>
class Callback1Base
{
public:
  virtual void operator()(P1) const = 0;
  virtual Callback1Base<P1>* clone() const = 0;
};


// Defined for a class
//----------------------------------------
template <class P1, class Client>
class Callback1:
  public Callback1Base<P1>
{
public:
  typedef void (Client::*PMEMFUNC)(P1);

  Callback1(Client& client_,PMEMFUNC pMemfunc_):
    _client(client_), 
    _pMemfunc(pMemfunc_)
{}

  /*virtual*/ void operator()(P1 parm_) const
  {(_client.*_pMemfunc)(parm_);}

  /*virtual*/ Callback1<P1,Client>* clone() const 
  {return new Callback1<P1,Client>(*this);}

private:
  Client& _client;
  PMEMFUNC _pMemfunc;
};

// Defined for normal functions
//----------------------------------------
template <class P1>
class Callback1s:
  public Callback1Base<P1>
{
public:
  typedef void (*PMEMFUNC)(P1);

  Callback1s(PMEMFUNC pMemfunc_):
    _pMemfunc(pMemfunc_)
{}

  /*virtual*/ void operator()(P1 parm_) const
  {(_pMemfunc)(parm_);}

  /*virtual*/ Callback1s<P1>* clone() const 
  {return new Callback1s<P1>(*this);}

private:
  PMEMFUNC _pMemfunc;
};


#endif // CALLBACK_H
