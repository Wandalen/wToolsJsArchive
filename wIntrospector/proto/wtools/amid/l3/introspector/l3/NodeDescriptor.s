( function _NodeDescriptor_s_( )
{

'use strict';

//

const _ = _global_.wTools;
const Parent = null;
const Self = wIntrospectionNodeDescriptor;
function wIntrospectionNodeDescriptor( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'NodeDescriptor';

// --
// inter
// --

function init( o )
{
  let descriptor = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( descriptor );
  Object.preventExtensions( descriptor );

  if( o )
  descriptor.copy( o );

  return descriptor.form();
}

//

function form()
{
  let descriptor = this;

  _.assert( descriptor.file instanceof _.introspector.File );
  _.assert( _.object.isBasic( descriptor.file.product ) );
  _.assert( _.object.isBasic( descriptor.iteration ) );
  _.assert( descriptor.file.nodeIs( descriptor.iteration.src ) );

  let file = descriptor.file;
  let product = file.product;
  let node = descriptor.iteration.src;
  let it = descriptor.iteration;

  _.assert( product.nodeToDescriptorHashMap.get( node ) === undefined );

  product.nodeToDescriptorHashMap.set( node, descriptor );

  descriptor.node = node;
  _.arrayAppendOnceStrictly( descriptor.iterations, it );
  descriptor.path = descriptor.path || it.path;
  descriptor.down = null;

  if( it.down )
  {
    it = it.down;
    while( it.down && !file.nodeIs( it.src ) )
    it = it.down;
    if( file.nodeIs( it.src ) )
    {
      let downDescriptor = product.nodeToDescriptorHashMap.get( it.src );
      _.assert( file.descriptorIs( downDescriptor ) );
      descriptor.down = downDescriptor;
    }
  }

  return descriptor;
}

//

function codeGet()
{
  let descriptor = this;
  let file = descriptor.file;
  let product = file.product;
  let parser = file.parser;
  let node = descriptor.node;

  let result = file.nodeCode( node );

  return result;
}

//

function typeGet()
{
  let descriptor = this;
  let file = descriptor.file;
  let product = file.product;
  let parser = file.parser;
  let node = descriptor.node;

  let result = file.nodeType( node );

  return result;
}

//

function fieldsGet()
{
  let descriptor = this;
  let file = descriptor.file;
  let product = file.product;
  let parser = file.parser;
  let node = descriptor.node;

  let result = parser.nodeMapGet( node );
  _.assert( _.mapIs( result ) );
  _.props.extend( result, parser.nodeChildrenMapGet( node ) );

  return result;
}

// --
// relations
// --

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  file : null,
  node : null,
  iterations : _.define.own([]),
  iteration : null,
  path : null,
  down : null,
}

let Restricts =
{
}

let Statics =
{
}

let Forbids =
{
}

let Accessors =
{
  code : { writable : 0 },
  type : { writable : 0 },
  fields : { writable : 0 },
}

// --
// declare
// --

let Proto =
{

  // inter

  init,
  form,

  codeGet,
  typeGet,
  fieldsGet,

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
