(function _ToString_s_() {

'use strict';

// require

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }
  var _global = _global_;
  var _ = _global_.wTools;

  _.include( 'wLogger' );

}

//
var _global = _global_;
var _ = _global_.wTools;
var Parent = _.PrinterTop;
var Self = function wPrinterToString( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'PrinterToString';

//

function init( o )
{
  var self = this;

  Parent.prototype.init.call( self,o );

}

//

function write()
{
  var self = this;

  var o = _.PrinterBase.prototype.write.apply( self,arguments );

  _.assert( _.arrayIs( o.output ) );
  _.assert( o.output.length === 1 );
  _.assert( _.strIs( o.pure ) );

  self.outputData += o.pure;

  return o;
}

// --
// relations
// --

var Composes =
{
}

var Aggregates =
{
  outputData : '',
}

var Associates =
{
}

var Restricts =
{
}

// --
// prototype
// --

var Proto =
{

  init : init,

  write : write,

  // relations

  /* constructor * : * Self, */
  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_global_[ Self.name ] = _[ Self.shortName ] = Self;

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.shortName ] = Self;

})();
