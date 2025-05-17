( function _File_s_( )
{

'use strict';

//

const _ = _global_.wTools;
let vectorize = _.routineDefaults( null, _.vectorize, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeAll = _.routineDefaults( null, _.vectorizeAll, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeAny = _.routineDefaults( null, _.vectorizeAny, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeNone = _.routineDefaults( null, _.vectorizeNone, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } )

//

const Parent = null;
const Self = wIntrospectionFile;
function wIntrospectionFile( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'File';

// --
// lookers
// --

_.assert( !!_.looker.Looker );
let LookerOfIntrospector = _.looker.classDefine
({
  name : 'LookerOfIntrospector',
  parent : _.looker.Looker,
  iteration : { srcAsContainer : null },
});

//

_.assert( !!_.searcher.Searcher );
let SearcherOfIntrospector = _.looker.classDefine
({
  name : 'SearcherOfIntrospector',
  parent : _.searcher.Searcher,
  iteration : { srcAsContainer : null },
});

// --
// inter
// --

function FromData( dataStr )
{
  let cls = this.Self;
  let file = new cls();
  file.readBegin();
  file.data = dataStr;
  file.readEnd();
  return file;
}

//

function init( o )
{
  let file = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( file );
  Object.preventExtensions( file );

  if( o )
  file.copy( o );

  file.form();
}

//

function unform()
{
  let file = this;
  let sys = file.sys;

  if( !file.formed )
  return file;

  _.arrayRemoveOnce( sys.filesArray, file )

  file.formed = 1;
  return file;
}

// --
// perform
// --

function form()
{
  let file = this;

  if( file.formed )
  return file;

  if( !file.sys )
  file.sys = new _.introspector.System();
  if( !file.sys.formed )
  file.sys.form();

  let sys = file.sys;
  _.assert( sys instanceof _.introspector.System );

  _.arrayAppendOnce( sys.filesArray, file )

  file.path = Object.create( _.introspector._path );
  file.path.file = file;
  file.path.Init();

  file.formed = 1;
  return file;
}

//

function read()
{
  let file = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( file.dataFormed )
  return file;

  return file.reread();
}

//

function reread()
{
  let file = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  file.dataFormed = 0;

  if( file.formed === 0 )
  file.form();

  let sys = file.sys;
  let fs = sys.fileSystem;
  let path = fs.path;

  file.readBegin();

  file.data = fs.fileRead( file.filePath );

  file.readEnd();

  _.assert( file.dataFormed === 1 );
  return file;
}

//

function readBegin()
{
  let file = this;
  _.assert( file.dataFormed === 0 );
  return file;
}

//

function readEnd()
{
  let file = this;

  _.assert( file.dataFormed === 0 );

  if( _.routineIs( file.data ) )
  file.data = file.data.toString();

  file.dataFormed = 1;

  _.assert( _.strIs( file.data ) );

  return file;
}

//

function parse()
{
  let file = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( file.structure )
  return file;

  return file.reparse();
}

//

function reparse()
{
  let file = this;
  let sys = file.sys;

  if( file.data === null )
  file.read();

  let Parser = sys.parserClassFor( file );
  _.assert( _.routineIs( Parser ), `No parser for file ${file.filePath}` );
  file.parser = Parser({ sys }).form();
  file.structure = file.parser.parse( file.data );

  return file;
}

//

function fine()
{
  let file = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( file.product )
  return file;

  return file.refine();
}

//

function refine()
{
  let file = this;

  if( file.structure === null )
  file.parse();

  let sys = file.sys;
  let parser = file.parser;
  let product = file.product = Object.create( null );
  product.root = null;
  product.nodes = _.containerAdapter.from( new Set );
  product.nodeToDescriptorHashMap = new HashMap;
  product.byType = Object.create( null );

  let o2 = Object.create( null );
  o2.Seeker = LookerOfIntrospector;
  o2.src = file.structure.root;
  o2.onUp = onUp;
  o2.onDown = onDown;
  o2.pathJoin = pathJoin;
  o2.iterableEval = iterableEval;

  _.look( o2 );

  return file;

  /* */

  function pathJoin()
  {
    let it = this;
    return file._iterationPathJoin( it, ... arguments );
  }

  function iterableEval()
  {
    let it = this;
    if( !file.nodeIs( it.src ) )
    return it.Seeker.iterableEval.call( it );
    it.iterable = 'Node';
  }

  function onUp( node, k, it )
  {
    if( !file.nodeIs( node ) )
    return;
    nodeConsider( node, it );
    file._iterationUpNodesMap( it );
  }

  function onDown( src, k, it )
  {
  }

  function descriptorMake( node, it )
  {
    let descriptor = file.descriptorFromIteration( it );
  }

  function nodeConsider( node, it )
  {
    let type1 = parser.nodeType( node );
    _.assert( _.strIs( type1 ) );

    if( !product.nodes.length )
    product.root = node;
    product.nodes.append( node );

    descriptorMake( node, it );

    let nodes = product.byType[ type1 ];
    if( !nodes )
    nodes = product.byType[ type1 ] = _.containerAdapter.from( new Set );
    nodes.appendOnce( node );

    let association = parser.TypeAssociation[ type1 ];
    if( association )
    for( let a = 0 ; a < association.length ; a++ )
    {
      let type2 = association[ a ];
      if( type1 === type2 )
      continue;
      let nodes = product.byType[ type2 ];
      if( !nodes )
      nodes = product.byType[ type2 ] = _.containerAdapter.from( new Set );
      nodes.appendOnce( node );
    }

  }

}

// --
// node
// --

function _iterationUpNodesMapAndFields( it )
{
  let file = this;
  let parser = file.parser;
  let node = it.src;

  _.assert( file.nodeIs( node ), 'Not a node' );
  _.assert( arguments.length === 1 );
  _.assert( it.srcAsContainer !== undefined );

  if( it.srcAsContainer === null )
  {
    it.srcAsContainer = parser.nodeChildrenMapGet( node );
    it.srcAsContainer[ '@code' ] = file.nodeCode( node );
  }

  // it.onAscend = function nodeAscend()
  it.ascend = function nodeAscend()
  {
    let it = this;
    let node = it.src;
    _.assert( arguments.length === 0 );
    _.assert( file.nodeIs( node ), 'Not a node' );
    _.assert( it.srcAsContainer !== undefined );
    return this._auxAscend( it.srcAsContainer );
  }

  it.revisitedEval( it.originalSrc );

}

//

function _iterationUpNodesMap( it )
{
  let file = this;
  let parser = file.parser;
  let node = it.src;

  _.assert( file.nodeIs( node ), 'Not a node' );
  _.assert( arguments.length === 1 );
  _.assert( it.srcAsContainer !== undefined );

  if( it.srcAsContainer === null )
  {
    it.srcAsContainer = parser.nodeChildrenMapGet( node );
  }

  // it.onAscend = function nodeAscend()
  it.ascend = function nodeAscend()
  {
    let it = this;
    let node = it.src;
    _.assert( arguments.length === 0 );
    _.assert( file.nodeIs( node ), 'Not a node' );
    _.assert( it.srcAsContainer !== undefined );
    return this._auxAscend( it.srcAsContainer );
  }

  it.revisitedEval( it.originalSrc );

}

//

function _iterationUpNodesArray( it )
{
  let file = this;
  let parser = file.parser;
  let node = it.src;

  _.assert( file.nodeIs( node ), 'Not a node' );
  _.assert( it.srcAsContainer !== undefined );

  // it.onAscend = function nodeAscend()
  it.ascend = function nodeAscend()
  {
    let it = this;
    let node = it.src;
    _.assert( arguments.length === 0 );
    _.assert( file.nodeIs( node ), 'Not a node' );
    _.assert( it.srcAsContainer !== undefined );
    return this._arrayAscend( it.srcAsContainer );
  }

  it.revisitedEval( it.originalSrc );

}

//

function _iterationPathJoin( it, selectorPath, selectorName )
{
  let file = this;
  let parser = file.parser;
  let result;

  _.assert( arguments.length === 3 );
  // _.assert( isNaN( selectorName ) ); /* xxx : qqq : uncomment please */

  if( !isNaN( selectorName ) )
  selectorName = '#' + Number( selectorName );

  if( file.nodeIs( it.src ) )
  selectorName = `${file.nodeType( it.src )}::${selectorName}`

  selectorPath = _.strRemoveEnd( selectorPath, it.upToken );

  result = selectorPath + it.defaultUpToken + selectorName;

  return result;
}

//

function nodeSelect( node, path )
{
  let file = this;
  let sys = file.sys;

  if( _.strIs( arguments[ 0 ] ) )
  {
    node = null;
    path = arguments[ 0 ];
    _.assert( arguments.length === 1 );
  }
  else
  {
    _.assert( arguments.length === 2 );
  }

  if( node === null )
  node = file.product.root;

  _.assert( _.strIs( path ) );
  _.assert( file.nodeIs( node ), 'Not a node' );

  let result = _.select
  ({
    src : node,
    selector : path,
    onSelectorUndecorate,
  });

  return result;

  function onSelectorUndecorate()
  {
    let it = this;
    if( !_.strIs( it.selector ) )
    return;
    if( !_.strHas( it.selector, '::' ) )
    return;
    it.selector = _.strIsolateRightOrAll( it.selector, '::' )[ 2 ];
  }

}

//

function nodeIs( node )
{
  let file = this;
  let parser = file.parser;
  return parser.nodeIs( node );
}

//

function nodeType( node )
{
  let file = this;
  let parser = file.parser;
  let result = parser.nodeType( node );
  return result;
}

//

function nodePath( node )
{
  let file = this;
  let parser = file.parser;
  let descriptor = file.nodeDescriptor( node );
  return descriptor.path;
}

//

function nodeCode( node )
{
  let file = this;
  let sys = file.sys;
  let parser = file.parser;

  _.assert( arguments.length === 1 );

  if( _.strIs( node ) )
  node = file.nodeSelect( node );

  _.assert( file.nodeIs( node ), 'Not a node' );

  let result = parser.nodeCode( node, file.data );

  return result;
}

//

function nodeDescriptor( node )
{
  let file = this;
  let product = file.product;
  _.assert( file.nodeIs( node ), 'Not a node' );
  let descriptor = product.nodeToDescriptorHashMap.get( node );
  _.assert( file.descriptorIs( descriptor ) );
  return descriptor;
}

//

function search_head( routine, args )
{
  let file = this;
  let product = file.product;
  let o = args[ 0 ];

  if( !_.mapIs( o ) )
  {
    o = Object.create( null );
    if( file.nodeIs( args[ 0 ] ) )
    {
      o.src = args[ 0 ];
      o.ins = args[ 1 ];
    }
    else
    {
      o.ins = args[ 0 ];
    }
  }

  // o = _.routine.options( routine, o );
  _.map.assertHasOnly( o, routine.defaults );

  if( o.src === undefined || o.src === null )
  o.src = file.product.root;

  _.assert( file.nodeIs( o.src ) );
  _.assert( _.strIs( o.ins ) || _.numberIs( o.ins ) );
  _.assert( arguments.length === 2 );

  return o;
}

//

function search_body( o )
{
  let file = this;
  let parser = file.parser;
  let product = file.product;

  _.assert( arguments.length === 1 );

  let onUp0 = o.onUp;
  o.onUp = onUp1;
  o.pathJoin = pathJoin;
  o.returning = 'it';
  o.order = 'top-to-bottom';
  o.onValueForCompare = onValueForCompare;
  if( !o.Seeker )
  o.Seeker = SearcherOfIntrospector;

  let found = _.entity.search( o );

  return found;

  function pathJoin()
  {
    let it = this;
    return file._iterationPathJoin( it, ... arguments );
  }

  function iterableEval()
  {
    let it = this;
    if( !file.nodeIs( it.src ) )
    return it.Seeker.iterableEval.call( it );
    it.iterable = 'Node';
  }

  function onUp1( node, k, it )
  {

    if( k === '@code' )
    if( it.down.added )
    it.continue = false;

    if( !file.nodeIs( node ) )
    return;

    file._iterationUpNodesMapAndFields( it );

    if( onUp0 )
    return onUp0.apply( this, arguments );
  }

  function onValueForCompare( e )
  {
    let it = this;
    _.assert( it.srcAsContainer !== undefined );
    if( it.srcAsContainer !== null )
    return it.srcAsContainer;
    return e;
  }

}

search_body.defaults =
{
  // ... _.props.extend( null, _.entity.search.defaults ),
  ... _.props.extend( null, _.searcher.Searcher.Prime ),
  returning : 'it',
}

delete search_body.defaults.Seeker;

let search = _.routine.uniteCloning_replaceByUnite( search_head, search_body );

//

function nodesSearch_body( o )
{
  let file = this;
  let parser = file.parser;
  let product = file.product;

  let its = file.search.body.call( file, o );

  let nodesMap = Object.create( null );
  _.each( its, ( it ) =>
  {
    let path = it.path;
    while( it.down && !file.nodeIs( it.src ) )
    it = it.down;
    nodesMap[ it.path ] = it.src;
  })

  _.assert( _.mapIs( nodesMap ) );

  return nodesMap;
}

_.routineExtend( nodesSearch_body, search.body );

let nodesSearch = _.routine.uniteCloning_replaceByUnite( search_head, nodesSearch_body );

// --
// descriptor
// --

function descriptorIs( descriptor )
{
  if( !descriptor )
  return false;
  return descriptor instanceof _.introspector.NodeDescriptor;
  // if( !_.mapIs( descriptor ) )
  // return false;
  // return descriptor.node !== undefined && descriptor.path !== undefined;
}

//

function descriptorFromIteration( it )
{
  let file = this;
  let product = file.product;
  let node = it.src;

  _.assert( file.nodeIs( node ) );

  let descriptor = product.nodeToDescriptorHashMap.get( node );
  if( !descriptor )
  {
    descriptor = new _.introspector.NodeDescriptor({ iteration : it, file });
    // descriptor = Object.create( null );
    // product.nodeToDescriptorHashMap.set( node, descriptor );
  }

  // descriptor.node = node;
  // descriptor.iterations = descriptor.iterations || [];
  // descriptor.iterations.push( it );
  // descriptor.iteration = descriptor.iteration || it;
  // descriptor.path = descriptor.path || it.path;
  // descriptor.down = null;
  // if( it.down )
  // {
  //   it = it.down;
  //   while( it.down && !file.nodeIs( it.src ) )
  //   it = it.down;
  //   if( file.nodeIs( it.src ) )
  //   {
  //     let downDescriptor = product.nodeToDescriptorHashMap.get( it.src );
  //     _.assert( file.descriptorIs( downDescriptor ) );
  //     descriptor.down = downDescriptor;
  //   }
  // }

  _.assert( descriptor instanceof _.introspector.NodeDescriptor );

  return descriptor;
}

//

function descriptorToNode( descriptor )
{
  let file = this;
  let product = file.product;

  _.assert( file.descriptorIs( descriptor ) );

  let node = descriptor.node;

  _.assert( file.nodeIs( node ), 'Not a node' );

  return node;
}

//

function descriptorToCode( descriptor )
{
  let file = this;
  let product = file.product;
  let node = file.descriptorToNode( descriptor );
  return file.nodeCode( node );
}

//

function descriptorsSearch_body( o )
{
  let file = this;
  let product = file.product;

  let nodes = file.nodesSearch( ... arguments );
  nodes = _.props.vals( nodes );

  let visited = new Set();
  let descriptors = [];
  _.each( nodes, ( node ) =>
  {
    if( visited.has( node ) )
    return;
    visited.add( node );
    descriptors.push( file.nodeDescriptor( node ) );
  })

  return descriptors;
}

_.routineExtend( descriptorsSearch_body, search.body );

let descriptorsSearch = _.routine.uniteCloning_replaceByUnite( search_head, descriptorsSearch_body );

// --
// product
// --

function productExportInfo( o )
{
  let file = this;
  let product = file.product;
  let result = '';

  o = _.routine.options_( productExportInfo, arguments );

  result += `File ${file.filePath}\n`;

  if( !product )
  return result;

  if( o.verbosity >= 2 )
  {
    result += `  nodes : ${product.nodes.length}\n`;
    result += `  types : ${_.props.keys( product.byType ).length}\n`;

    if( o.verbosity >= 3 )
    result += `  types : ${_.props.keys( product.byType ).join( ' ' )}\n`;

    result += '\n';
  }

  if( o.verbosity >= 4 )
  {
    let types = _.props.keys( product.byType );
    types = types.map( ( k ) => [ k, product.byType[ k ].length ] );
    types = types.sort( ( a, b ) => a[ 1 ] - b[ 1 ] );
    types.forEach( ( pair ) =>
    {
      result += `  ${pair[ 0 ]} : ${pair[ 1 ]}\n`;
    });
  }

  return result;
}

productExportInfo.defaults =
{
  verbosity : 9,
}

// --
// relations
// --

let Composes =
{
  filePath : null,
}

let Aggregates =
{
  data : null,
  structure : null,
  product : null,
}

let Associates =
{
  sys : null,
  parser : null,
}

let Restricts =
{
  formed : 0,
  dataFormed : 0,
  path : null,
}

let Statics =
{
  FromData,
}

let Forbids =
{
  _nodeChildrenMapGet : '_nodeChildrenMapGet',
  _nodeMapGet : '_nodeMapGet',
}

let Accessors =
{
}

// --
// define class
// --

let Proto =
{

  // inter

  FromData,
  init,

  // perform

  form,

  read,
  reread,
  readBegin,
  readEnd,

  parse,
  reparse,
  fine,
  refine,

  // node

  _iterationUpNodesMapAndFields,
  _iterationUpNodesMap,
  _iterationUpNodesArray,
  _iterationPathJoin,

  nodeSelect,

  nodeIs,
  nodePath,
  nodesPaths : vectorize( nodePath ),
  nodeType,
  nodesTypes : vectorize( nodeType ),
  nodeCode,
  nodesCodes : vectorize( nodeCode ),
  nodeDescriptor,
  nodesDescriptors : vectorize( nodeDescriptor ),

  search,
  nodesSearch,

  // descriptor

  descriptorIs,
  descriptorFromIteration,
  descriptorToNode,
  descriptorsToNodes : vectorize( descriptorToNode ),
  descriptorToCode,
  descriptorsToCodes : vectorize( descriptorToCode ),
  descriptorsSearch,

  // product

  productExportInfo,

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
