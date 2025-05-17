( function _Namespace_s_( ) {

'use strict';

const _ = _global_.wTools;
_.stxt = _.stxt || Object.create( null );

let vectorize = _.routineDefaults( null, _.vectorize, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeAll = _.routineDefaults( null, _.vectorizeAll, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeAny = _.routineDefaults( null, _.vectorizeAny, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeNone = _.routineDefaults( null, _.vectorizeNone, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );

// --
// inter
// --

function nodeIs( node )
{
  if( !_.mapIs( node ) )
  return false;
  if( !node.kind )
  return false;
  return true;
}

//

function nodeText( node, parser )
{
  if( node.text !== null )
  return node.text;
  _.assert( _.pair.is( node.lines ) );
  return parser.line.slice( node.lines[ 0 ], node.lines[ 1 ]+1 ).join( '\n' );
}

//

function nodeRaw( node, parser )
{
  if( node.raw !== null )
  return node.raw;
  _.assert( _.pair.is( node.lines ) );
  return parser.line.slice( node.lines[ 0 ], node.lines[ 1 ]+1 ).join( '\n' );
}

//

function nodeExportStr( o )
{

  _.routine.options_( nodeExportStr, o );
  _.assert( arguments.length === 1 );
  _.assert( o.parser instanceof _.stxt.Parser );
  _.assert( _.stxt.nodeIs( o.src ) );
  _.assert( _.numberIs( o.recursive ) );
  _.assert( _.numberIs( o.verbosity ) );

  if( o.dst === null )
  o.dst = '';

  o.dst += `${o.tab}node::${o.src.kind}`;

  if( o.verbosity > 1 )
  {
    let but = { node : null, nodes : null, head : null, kind : null, subPages : null, supPages : null };
    if( o.verbosity <= 8 )
    {
      but.raw = null;
      but.text = null;
    }
    let fields = _.mapBut_( null, o.src, but );

    for( let k in fields )
    if( fields[ k ] === null )
    delete fields[ k ];

    if( o.src.nodes )
    fields.nodes = o.src.nodes.length;

    if( _.entity.lengthOf( fields ) )
    o.dst += '\n' + _.entity.exportStringNice( fields, { tab : o.tab } );
  }

  if( o.recursive )
  {
    let children = _.stxt.nodesChildrenOnly( o.src );

    if( children.length )
    for( let s = 0 ; s < children.length ; s++ )
    {
      let node = children[ s ];
      o.dst += '\n';
      o.dst = nodeExport( node );
    }

  }

  return o.dst;

  function nodeExport( node )
  {
    let o2 = _.props.extend( null, o );
    o2.src = node;
    if( o2.recursive === 1 )
    o2.recursive = 0;
    o2.tab += '  ';
    return _.stxt.nodeExportStr( o2 );
  }

}

nodeExportStr.defaults =
{
  parser : null,
  src : null,
  dst : null,
  verbosity : 8,
  recursive : 0,
  tab : '',
}

//

function nodesIndex( nodes )
{
  _.assert( _.longIs( nodes ) );
  _.assert( arguments.length === 1 );

  let indexed = _.indexAppending( nodes, '*/kind' );

  return indexed;
}

//

function nodesChildren( nodes )
{
  let result = [];

  nodes = _.array.as( nodes );
  _.assert( arguments.length === 1 );

  _.arrayAppendArray( result, nodes );
  _.arrayAppendArray( result, _.stxt.nodesChildrenOnly( nodes ) );

  return result;
}

//

function nodesChildrenOnly( nodes )
{
  let result = [];

  nodes = _.array.as( nodes );
  _.assert( arguments.length === 1 );

  for( let i = 0 ; i < nodes.length ; i++ )
  {
    let node = nodes[ i ];

    // if( node.kind === 'List' )
    // debugger;

    if( node.head )
    _.arrayAppendOnce( result, node.head );

    if( node.nodes )
    _.arrayAppendArray( result, node.nodes );

    if( node.comments )
    _.arrayAppendArray( result, node.comments );

  }

  return result;
}

//

function nodesDescendants( nodes )
{
  let result = [];

  nodes = _.array.as( nodes );
  _.assert( arguments.length === 1 );

  _.arrayAppendArray( result, nodes );
  _.arrayAppendArray( result, _.stxt.nodesChildrenOnly( nodes ) );

  return result;
}

// //
//
// function nodesDescendantsOnly( nodes )
// {
//   let result = [];
//
//   nodes = _.array.as( nodes );
//
//   _.assert( arguments.length === 1 );
//
//   for( let i = 0 ; i < nodes.length ; i++ )
//   {
//     let node = nodes[ i ];
//     let children = _.stxt.nodesChildrenOnly( nodes );
//     add( children );
//   }
//
//   return result;
//
//   function add( nodes )
//   {
//
//     for( let i = 0 ; i < nodes.length ; i++ )
//     {
//       let node = nodes[ i ];
//       _.arrayAppend( result, node );
//       let children = _.stxt.nodesChildrenOnly( nodes );
//       _.arrayAppendArray( result, children );
//     }
//
//   }
//
// }

// --
// structure
// --

let Node = _.blueprint.define
({
  kind : 'Node',
  text : null,
  raw : null,
  lines : null,
  properties : null,
})

let Collection = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'Collection',
  nodes : null,
})

let Page = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'Page',
  head : null,
  nodes : null,
  subPages : null,
  supPages : null,
  // isEmpty : 0,
  level : -1,
  number : -1,
})

let Span = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'Span',
})

let Line = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'Line',
  nodes : null,
})

let LineEmpty = _.blueprint.define
({
  extension : _.define.extension( Line ),
  kind : 'LineEmpty',
})

let List = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'List',
  nodes : null,
  lines : null,
  comments : null,
})

let ListNode = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'ListNode',
  nodes : null,
  level : -1,
})

let Directive = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'Directive',
  properties : null,
  level : -1,
})

let Label = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'Label',
  properties : null,
  level : -1,
})

let CommentLine = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'CommentLine',
  properties : null,
  level : -1,
})

let Link = _.blueprint.define
({
  extension : _.define.extension( Node ),
  kind : 'Link',
  ref : null,
  nodes : null,
})

// --
// declare
// --

let Restricts =
{

  vectorize,
  vectorizeAll,
  vectorizeAny,
  vectorizeNone,

}

let Extension =
{

  nodeIs,
  nodeText,
  nodeRaw,
  nodeExportStr,
  nodesIndex,

  nodesChildren,
  nodesChildrenOnly,
  nodesDescendants,
  // nodesDescendantsOnly,

  Node,
  Collection,
  Page,
  Span,
  Line,
  LineEmpty,
  List, /* qqq : add parsing test routine */
  ListNode,
  Directive, /* qqq : add parsing test routine */
  Label, /* qqq : add parsing test routine */
  CommentLine,
  Link, /* qqq : add parsing test routine */

  _ : Restricts,

}

Object.assign( _.stxt, Extension );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
