( function _Sample_js_()
{

'use strict';

if( typeof module !== 'undefined' )
require( 'wProto' );

// --
// constructor
// --

let _ = wTools;
let Parent = null;
let Self = BaseClass;
function BaseClass()
{
  return _.workpiece.construct( Self, this, arguments );
}

// --
// routines
// --

/* optional method to initialize instance with options */

function init()
{
  var self = this; /* context */

  _.workpiece.initFields( self ); /* extends object by fields from relationships */

  Object.preventExtensions( self ); /* disables object extending */
}

//

/* optional method to finalize instance if it is intended to be recycled */

function finit()
{
  var self = this;
  Object.freeze( self );
}

//

function print()
{
  var self = this;
  console.log( self.name, 'a :', self.a );
}

//

function staticFunction()
{
  var self = this;

  if( self === Self )
  console.log( self.name, 'static function called as static' );
  else
  console.log( self.name, 'static function called as method' );

}

// --
// relationships
// --

var Composes =
{
  name : '',
  a : 1,
}

var Statics =
{
  staticFunction,
}

// --
// proto
// --

var Proto =
{

  init,
  finit,

  print,

  Composes,
  Statics,

}

/* make class */

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

/* make the class global */

_global_[ Self.name ] = Self;

// --
// usage
// --

var base1 = new BaseClass();
base1.name = 'base1';
base1.a = 11;

base1.print();
// base1 a : 11
base1.staticFunction();
// base1 static function called as method
BaseClass.staticFunction();
// BaseClass static function called as static
console.log();

})();
