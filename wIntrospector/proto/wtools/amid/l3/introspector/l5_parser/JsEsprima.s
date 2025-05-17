( function _JsEsprima_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  _global_.Esprima = require( 'esprima' );

}

//

const _ = _global_.wTools;
const Parent = _.introspector.Parser;
const Self = wIntrospectionParserJsEsprima;
function wIntrospectionParserJsEsprima( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'JsEsprima';

// --
// inter
// --

function _form()
{
  let parser = this;
  let sys = parser.sys;
  if( !parser._parser )
  parser._parser = _global_.Esprima;
}

//

function _parse( o )
{
  let parser = this;
  _.routine.assertOptions( _parse, arguments );
  let opts = Object.create( null );
  opts.comment = true;
  opts.loc = true;
  opts.range = true;
  // let result = parser._parser.parse( o.src, opts );

  let result = Object.create( null );
  result.returned = parser._parser.parse( o.src, opts );
  result.root = result.returned;

  return result;
}

_parse.defaults = _.props.extend( null, Parent.prototype.parse.defaults );

//

function _nodeIs( node )
{
  let parser = this;
  if( !node )
  return false;
  return !!node.type;
}

//

function _nodeRange( node )
{
  let parser = this;

  _.assert( arguments.length === 1 );
  _.assert( parser.nodeIs( node ) );

  return [ node.range[ 0 ], node.range[ 1 ]-1 ];
  // return node.range;
}

//

function _nodeType( node )
{
  let parser = this;
  return node.type;
}

// --
// meta
// --

function _Setup()
{
  let parser = this;

  parser._TypeAssociationsFromSchema();

  _.props.keys( _global_.Esprima.Syntax ).forEach( ( name ) =>
  {
    parser.TypeAssociation[ name ] = [ name ];
  });

  parser._TypeAssociationsNormalize();
  parser._Register();

}

// --
// relations
// --

let TypeAssociation = Object.create( null );

var native = { native : true };
var general = { native : false, general : true };
let Schema = _.schema.system({ name : 'Js.EsprimaAst' });

Schema
.define([ 'Program' ])
.label( native )
.terminal();

Schema
.define( 'gRoot' )
.label( general )
.alternative()
.extend([ 'Program' ]);

Schema
.define([ 'FunctionDeclaration', 'FunctionExpression', 'ArrowFunctionExpression' ])
.label( native )
.terminal();

Schema
.define( 'gRoutine' )
.label( general )
.alternative()
.extend([ 'FunctionDeclaration', 'FunctionExpression', 'ArrowFunctionExpression' ]);

Schema
.define([ 'Block', 'Line' ])
.label( native )
.terminal();

Schema
.define( 'gComment' )
.label( general )
.alternative()
.extend([ 'Block', 'Line' ]);

Schema.form();

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  sys : null,
  _parser : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{

  _Setup,

  Schema,
  TypeAssociation,
  Exts : [ 'js', 'ss', 's' ],
  PrimeExts : [],

}

let Forbids =
{
}

let Accessors =
{
}

// --
// declare
// --

let Proto =
{

  // inter

  _form,
  _parse,
  _nodeIs,
  _nodeType,
  _nodeRange,

  // meta

  _Setup,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

Self._Setup();

_.introspector.Parser[ Self.shortName ] = Self;
if( !_.introspector.Parser.Js )
_.introspector.Parser.Js = Self;

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
