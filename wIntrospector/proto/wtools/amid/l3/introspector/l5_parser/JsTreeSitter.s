( function _JsTreeSitter_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  _global_.TreeSitterParser = require( 'tree-sitter' );
  _global_.TreeSitterJsGrammar = require( 'tree-sitter-javascript' );

}

//

const _ = _global_.wTools;
const Parent = _.introspector.Parser;
const Self = wIntrospectionParserJsTreeSitter;
function wIntrospectionParserJsTreeSitter( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'JsTreeSitter';

// --
// inter
// --

function _form()
{
  let parser = this;
  let sys = parser.sys;

  if( !parser._parser )
  {
    parser._NodeClass = _global_.TreeSitterParser.SyntaxNode;
    parser._parser = new _global_.TreeSitterParser();
    parser._parser.setLanguage( _global_.TreeSitterJsGrammar );
    _.assert( _.constructorIs( parser._NodeClass ) );
  }

}

//

function _parse( o )
{
  let parser = this;
  _.routine.assertOptions( _parse, arguments );

  let result = Object.create( null );
  result.returned = parser._parser.parse( o.src );
  result.root = result.returned.rootNode;

  return result;
}

_parse.defaults = _.props.extend( null, Parent.prototype.parse.defaults );

//

function _nodeIs( node )
{
  let parser = this;
  if( !node )
  return false;
  return node instanceof parser._NodeClass;
}

//

function _nodeType( node )
{
  let parser = this;
  let constructorName = node.constructor.name;
  if( constructorName === 'SyntaxNode' && node.type !== 'comment' )
  return 'syntax';
  return node.type;
}

//

function _nodeRange( node )
{
  let parser = this;

  _.assert( arguments.length === 1 );
  _.assert( parser.nodeIs( node ) );
  _.assert( node.startIndex >= 0 && node.endIndex >= 0 );

  return [ node.startIndex, node.endIndex-1 ];
  // return [ node.startIndex, node.endIndex ];
}

//

function _nodeChildrenMapGet( node )
{
  let parser = this;
  let result = Object.create( null );
  result.children = node.children;
  return result;
}

//

function _nodeChildrenArrayGet( node )
{
  let parser = this;
  return node.children;
}

//

function _nodeMapGet( node )
{
  let parser = this;
  _.assert( parser.nodeIs( node ) );

  let result = node.fields ? _.mapOnly_( null, node, node.fields ) : Object.create( null );

  return result;
}

// --
// meta
// --

function _Setup()
{
  let parser = this;

  parser._TypeAssociationsFromSchema();
  parser._TypeAssociationsNormalize();
  parser._Register();

}

// --
// relations
// --

let TypeAssociation = Object.create( null );

var native = { native : true };
var general = { native : false, general : true };
let Schema = _.schema.system({ name : 'Js.TreeSitterAst' });

Schema
.define([ 'program' ])
.label( native )
.terminal();

Schema
.define( 'gRoot' )
.label( general )
.alternative()
.extend([ 'program' ]);

Schema
.define([ 'function', 'arrow_function', 'function_declaration', 'method_definition' ])
.label( native )
.terminal();

Schema
.define( 'gRoutine' )
.label( general )
.alternative()
.extend([ 'function', 'arrow_function', 'function_declaration', 'method_definition' ]);

Schema
.define([ 'comment' ])
.label( native )
.terminal();

Schema
.define( 'gComment' )
.label( general )
.alternative()
.extend([ 'comment' ]);

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
  _NodeClass : null,
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

  _nodeChildrenMapGet,
  _nodeChildrenArrayGet,

  _nodeMapGet,

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
// if( !_.introspector.Parser.Default )
// _.introspector.Parser.Default = Self;

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
