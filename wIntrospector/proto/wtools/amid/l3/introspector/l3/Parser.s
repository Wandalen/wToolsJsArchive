( function _Parser_s_( )
{

'use strict';

//

const _ = _global_.wTools;
const Parent = null;
const Self = wIntrospectionParser;
function wIntrospectionParser( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Parser';

// --
// inter
// --

function init( o )
{
  let parser = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( parser );
  Object.preventExtensions( parser );

  if( o )
  parser.copy( o );

}

//

function form()
{
  let parser = this;
  if( parser.formed )
  return;

  let sys = parser.sys;
  _.assert( sys instanceof _.introspector.System );

  parser._form();
  _.assert( !!parser._parser );

  parser.formed = 1;
  return parser;
}

//

function parse( o )
{
  let parser = this;

  if( !_.mapIs( o ) )
  o = { src : o }

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.src ), `Expects string {- o.src -}, but got ${o.src}` );
  _.routine.options_( parse, o );

  let result = parser._parse( o );

  _.assert( _.mapHasOnly( result, parser.ParsedStructure ), 'Parser returned unknown field of parsed structure' );
  _.assert( result.returned !== undefined );
  _.assert( parser.nodeIs( result.root ) );

  return result;
}

parse.defaults =
{
  src : null,
  filePath : null,
}

//

function nodeIs( node )
{
  let parser = this;
  return parser._nodeIs( node );
}

//

function _nodeCode( node, data )
{
  let parser = this;

  _.assert( arguments.length === 2 );
  _.assert( parser.nodeIs( node ) );

  let result = _.strOnly( data, parser.nodeRange( node ) );

  return result;
}

//

function nodeCode( node, data )
{
  let parser = this;

  _.assert( arguments.length === 2 );
  _.assert( parser.nodeIs( node ) );

  let result = parser._nodeCode( node, data );

  return result;
}

//

function nodeType( node )
{
  let parser = this;
  let result = parser._nodeType( node );
  _.assert( _.strIs( result ) );
  return result;
}

//

function nodeRange( node )
{
  let parser = this;
  let result = parser._nodeRange( node );
  _.assert( _.intervalIs( result ) );
  return result;
}

//

function _nodeMapGet( node )
{
  let parser = this;
  _.assert( parser.nodeIs( node ) );
  if( parser.nodeIs( node ) )
  {
    return _.props.extend( null, node );
  }
  else
  {
    return node;
  }
}

//

function nodeMapGet( node )
{
  let parser = this;
  let result = parser._nodeMapGet( node );
  return result;
}

//

function _nodeChildrenMapGet( node )
{
  let parser = this;

  let result = Object.create( null );
  for( let n in node )
  {
    let field = node[ n ];
    if( parser.nodeIs( field ) )
    {
      result[ n ] = field;
    }
    // else if( _.longIs( field ) && field.length && parser.nodeIs( field[ 0 ] ) )
    else if( _.longIs( field ) )
    {
      result[ n ] = [];
      for( let f = 0 ; f < field.length ; f++ )
      if( parser.nodeIs( field[ f ] ) )
      result[ n ].push( field[ f ] );
    }
  }

  return result;
}

//

function nodeChildrenMapGet( node )
{
  let parser = this;
  return parser._nodeChildrenMapGet( node );
}

//

function _nodeChildrenArrayGet( node )
{
  let parser = this;
  let result = [];

  for( let n in node )
  {
    let field = node[ n ];
    if( parser.nodeIs( field ) )
    result.push( field );
    else if( _.longIs( field ) && field.length && parser.nodeIs( field[ 0 ] ) )
    result.push( field );
  }

  return result;
}

//

function nodeChildrenArrayGet( node )
{
  let parser = this;
  return parser._nodeChildrenArrayGet( node );
}

// --
// meta
// --

function _TypeAssociationsFromSchema( schema )
{
  let parser = this;

  if( schema === undefined )
  schema = parser.Schema;

  schema.definitionsArray.forEach( ( definition ) =>
  {
    if( definition.kind === definition.Kind.predefined )
    return;

    _.assert( _.strDefined( definition.name ) );

    if( definition.kind === definition.Kind.terminal )
    parser.TypeAssociation[ definition.name ] = [ definition.name ];
    else if( definition.kind === definition.Kind.alternative )
    parser.TypeAssociation[ definition.name ] = definition.product.elementsArray.map( ( e ) => e.type );
    // else _.assert( 0, `Not clear how to handle ${definition.product.qualifiedName}` ); /* xxx : uncomment */

  });

}

//

function _TypeAssociationsNormalize()
{
  let parser = this;

  _.each( parser.TypeAssociation, ( association, type1 ) =>
  {
    association.forEach( ( type2 ) =>
    {
      _.assert( _.strIs( type2 ), () => `Expects string, but ${type1} has ${_.entity.strType( type2 )}` );
      _.assert( _.arrayIs( parser.TypeAssociation[ type2 ] ), () => `Type association ${type2} was not defined` );
      _.arrayAppendOnce( parser.TypeAssociation[ type2 ], type1 );
    });
  });

  _.assert( !!parser.TypeAssociation.gRoutine && parser.TypeAssociation.gRoutine.length > 0 );

}

//

function _Register()
{
  let cls = this;

  _.assert( _.arrayIs( cls.Exts ) );
  _.assert( _.arrayIs( cls.PrimeExts ) );

  cls.Exts.forEach( ( ext ) =>
  {
    let array = _.introspector.extToAllParsersMap[ ext ] = _.introspector.extToAllParsersMap[ ext ] || [];
    _.arrayAppendOnceStrictly( array, cls );
  });

  cls.PrimeExts.forEach( ( ext ) =>
  {
    _.assert( !_.introspector.extToDefaultParserMap[ ext ], `Only one parser can have prime extension "${ext}"` );
    _.introspector.extToDefaultParserMap[ ext ] = cls;
  });

}

//

function SetAsDefault()
{
  let cls = this;

  _.assert( _.arrayIs( cls.Exts ) );

  cls.Exts.forEach( ( ext ) =>
  {
    _.introspector.extToDefaultParserMap[ ext ] = cls;
  });

}

// --
// relations
// --

let ParsedStructure =
{
  returned : null,
  root : null,
  comments : null,
}

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

  _TypeAssociationsFromSchema,
  _TypeAssociationsNormalize,
  ParsedStructure,

  _Register,
  SetAsDefault,
  Exts : null,
  PrimeExts : null,

}

let Forbids =
{
  RoutineTypes : 'RoutineTypes',
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

  init,

  _form : null,
  form,

  _parse : null,
  parse,

  _nodeIs : null,
  nodeIs,

  _nodeCode,
  nodeCode,

  _nodeType : null,
  nodeType,

  _nodeRange : null,
  nodeRange,

  _nodeMapGet,
  nodeMapGet,

  _nodeChildrenMapGet,
  nodeChildrenMapGet,

  _nodeChildrenArrayGet,
  nodeChildrenArrayGet,

  // meta

  _TypeAssociationsFromSchema,
  _TypeAssociationsNormalize,

  //

  Exts : null,
  PrimeExts : null,
  _Register,
  SetAsDefault,

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

_.Copyable.mixin( Self );
_.introspector[ Self.shortName ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
