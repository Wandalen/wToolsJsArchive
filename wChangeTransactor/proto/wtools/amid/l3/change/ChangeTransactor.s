( function _ChangeTransactor_s_()
{

'use strict';

/**
 * Still sketch. Mixin to add the ability to track changes of an object, to reflect changes in a data structure and to make possible to apply the changes to another object. Use the module to mirror object's changes somehow elsewhere, for example on server-side or client-side.
  @module Tools/base/ChangeTransactor
*/

/**
 *  */

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../../node_modules/Tools' );
  _.include( 'wProto' );
  _.include( 'wCloner' );
  require( './Changes.s' );
}

const _ = _global_.wTools;
const _ObjectHasOwnProperty = Object.hasOwnProperty;

//

/**
 @classdesc Mixin to add the ability to track changes of an object, to reflect changes in a data structure and to make possible to apply the changes to another object.
 @class wChangeTransactor
 @namespace wTools
 @module Tools/base/ChangeTransactor
*/

function onMixinApply( mixinDescriptor, dstClass )
{

  var dstPrototype = dstClass.prototype;

  _.mixinApply( this, dstPrototype );
  // _.mixinApply
  // ({
  //   dstPrototype : dstPrototype,
  //   descriptor : Self,
  // });

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( dstPrototype.Events.changed ) );

}

//

/**
 @method changeBegin
 @class wChangeTransactor
 @namespace wTools
 @module Tools/base/ChangeTransactor
*/

function changeBegin()
{
  var self = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( self._changeLevel >= 0 );

  self._changeLevel += 1;

}

//

/**
 @method changeEnd
 @class wChangeTransactor
 @namespace wTools
 @module Tools/base/ChangeTransactor
*/

function changeEnd()
{
  var self = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( self._changeLevel >= 1 );

  self._changeLevel -= 1;

  if( self._changeLevel === 0 )
  self._changed();

}

//

/**
 @method changed
 @class wChangeTransactor
 @namespace wTools
 @module Tools/base/ChangeTransactor
*/

function changed()
{
  var self = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( self._changeLevel === 0 )
  self._changed();

}

//

function _changed()
{
  var self = this;

  if( _.routineIs( self.eventGive ) )
  self.eventGive({ kind : 'changed' });

}

// --
// declare
// --

var Composes =
{
}

var Restricts =
{
  _changeLevel : 0,
}

var Statics =
{
}

var Events =
{
  'changed' : 'changed',
}

var Functors =
{
}

var Supplement =
{

  changeBegin,
  changeEnd,
  changed,
  _changed,

  Composes,
  Restricts,
  Statics,
  Events,

}

//

const Self =
{

  onMixinApply,

  functors : Functors,
  supplement : Supplement,

  name : 'wChangeTransactor',
  shortName : 'ChangeTransactor',

}

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.shortName ] = _.mixinDelcare( Self );

})();
