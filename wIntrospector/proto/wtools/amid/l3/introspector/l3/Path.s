( function _Path_s_( )
{

'use strict';

const _global = _global_;
const _ = _global_.wTools;
const Parent = _.path;
_.introspector._path = _.introspector._path || Object.create( Parent );

// --
// inter
// --

function dirNodes( root, filePath, dLevel )
{
  let file = this.file;

  if( !file.nodeIs( root ) )
  {
    root = file.product.root;
    filePath = arguments[ 0 ];
    dLevel = arguments[ 1 ];
  }

  if( dLevel === undefined )
  dLevel = 1;

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( file instanceof _.introspector.File );
  _.assert( file.nodeIs( root ) );
  _.assert( dLevel >= 0 );

  filePath = this._closestNode( root, filePath );

  while( dLevel > 0 )
  {
    dLevel -= 1;
    filePath = _.path.dir( filePath );
    filePath = this._closestNode( root, filePath );
  }

  return filePath;
}

//

function dirClosest( root, filePath, dLevel )
{
  let file = this.file;

  if( !file.nodeIs( root ) )
  {
    root = file.product.root;
    filePath = arguments[ 0 ];
    dLevel = arguments[ 1 ];
  }

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( file instanceof _.introspector.File );
  _.assert( file.nodeIs( root ) );
  _.assert( dLevel >= 0 );

  let result = dLevel === 0 ? filePath : _.path.dir( filePath, dLevel );

  return this._closestNode( root, result );
}

//

function _closestNode( root, filePath )
{
  let file = this.file;

  while( this.ends( filePath, '..' ) )
  {
    // _.assert( 0, 'not tested' );
    // debugger; /* xxx */
    filePath = _.path.join( filePath, '_' );
  }

  if( filePath === '' || filePath === '/' )
  return '/';

  let node = file.nodeSelect( root, filePath );

  do
  {

    if( file.nodeIs( node ) )
    return filePath;

    filePath = this.path.dir( filePath );

    node = file.nodeSelect( root, filePath );

    _.assert( !this.ends( filePath, '..' ) );
  }
  while( filePath !== '/' );

  _.assert( file.nodeIs( node ) );

  return filePath;
}

//

function closestNode( root, filePath )
{
  let file = this.file;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( file instanceof _.introspector.File );

  if( !file.nodeIs( root ) )
  {
    root = file.product.root;
    filePath = arguments[ 0 ];
  }

  filePath = this.canonize( filePath );

  _.assert( file.nodeIs( root ) );

  return this._closestNode( root, filePath );
}

// --
// declare
// --

let Extension =
{

  file : null,

  dirNodes,
  dirClosest,
  _closestNode,
  closestNode,

}

/* _.props.extend */Object.assign( _.introspector._path, Extension );

})();
