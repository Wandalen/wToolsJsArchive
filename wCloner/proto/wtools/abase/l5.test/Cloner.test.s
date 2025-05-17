( function _Cloner_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  require( '../l5/Cloner.s' );

  _.include( 'wTesting' );

}
const _global = _global_;
const _ = _global_.wTools;

// --
// tests
// --

function traverseMapWithClonerRoutines( test )
{
  var onMapElementUp = ( it, eit ) => eit;
  var onMapUp = _._cloneMapUp;
  var onMapElementDown = _._cloneMapElementDown;

  /* */

  test.case = 'before changes in private routine _cloneMapUp';
  var src =
  {
    map : { y : 2, z : undefined },
    primitive : 'abc',
    notDefined : undefined
  };
  var got = _.traverse({ src, onMapUp, onMapElementUp, onMapElementDown });
  // var exp =
  // {
  //   'map' : { 'y' : 2, 'z' : undefined },
  //   'primitive' : 'abc',
  //   'notDefined' : undefined
  // };
  var exp =
  {
    map : { y : 2 },
    primitive : 'abc'
  };
  test.identical( got, exp );

  /* */

}

//

function _cloneMapUp( test )
{
  test.case = 'dst - null, src - empty map, should be cloned';
  var it =
  {
    dst : null,
    src : {}
  };
  var got = _._cloneMapUp( it );
  test.identical( got, it );
  test.identical( it.dst, {} );
  test.true( it.dst !== it.src );

  test.case = 'dst - not null, src - empty map, should save dst';
  var it =
  {
    dst : 'dst',
    src : {}
  };
  var got = _._cloneMapUp( it );
  test.identical( got, it );
  test.identical( it.dst, 'dst' );
  test.identical( it.src, {} );

  test.case = 'dst - null, src - map, should be cloned';
  var it =
  {
    dst : null,
    src : { a : 1, b : undefined },
  };
  var got = _._cloneMapUp( it );
  test.identical( got, it );
  // test.identical( it.dst, { 'a' : 1, 'b' : undefined } );
  test.identical( it.dst, {} );
  test.true( it.dst !== it.src );

  test.case = 'dst - not null, src - empty map, should save dst';
  var it =
  {
    dst : 'dst',
    src : { a : 1, b : undefined }
  };
  var got = _._cloneMapUp( it );
  test.identical( got, it );
  test.identical( it.dst, 'dst' );
  test.identical( it.src, { a : 1, b : undefined } );

  /* */

  test.case = 'copyingDegree - 1, dst - null, src - empty map, should be identical';
  var it =
  {
    copyingDegree : 1,
    dst : null,
    src : {}
  };
  var got = _._cloneMapUp( it );
  test.identical( got, _.dont );
  test.identical( it.dst, {} );
  test.true( it.dst === it.src );

  test.case = 'copyingDegree - 1, dst - not null, src - empty map, should be identical';
  var it =
  {
    copyingDegree : 1,
    dst : 'should be replaced',
    src : {}
  };
  var got = _._cloneMapUp( it );
  test.identical( got, _.dont );
  test.identical( it.dst, {} );
  test.true( it.dst === it.src );

  test.case = 'copyingDegree - 1, dst - null, src - map, should be identical';
  var it =
  {
    copyingDegree : 1,
    dst : null,
    src : { a : 1, b : undefined }
  };
  var got = _._cloneMapUp( it );
  test.identical( got, _.dont );
  test.identical( it.dst, { a : 1, b : undefined } );
  test.true( it.dst === it.src );

  test.case = 'copyingDegree - 1, dst - not null, src - map, should be identical';
  var it =
  {
    copyingDegree : 1,
    dst : 'should be replaced',
    src : { a : 1, b : undefined }
  };
  var got = _._cloneMapUp( it );
  test.identical( got, _.dont );
  test.identical( it.dst, { a : 1, b : undefined } );
  test.true( it.dst === it.src );

  /* */

  test.case = 'copier in it.down.dst';
  var Constr = constr;
  function constr()
  {
    this.Copiers = { copy : ( it ) => it.src };
    return this;
  }
  var it =
  {
    down : { dst : new Constr() },
    key : 'copy',
    dst : null,
    src : { a : 1, b : undefined }
  };
  var got = _._cloneMapUp( it );
  test.identical( got, undefined );
  test.identical( it.dst, { a : 1, b : undefined } );
  test.true( it.dst === it.src );

  test.case = 'copier in it.down.src';
  var Constr = constr;
  function constr()
  {
    this.Copiers = { copy : ( it ) => it.src };
    return this;
  }
  var it =
  {
    down : { src : new Constr() },
    key : 'copy',
    dst : null,
    src : { a : 1, b : undefined }
  };
  var got = _._cloneMapUp( it );
  test.identical( got, undefined );
  test.identical( it.dst, { a : 1, b : undefined } );
  test.true( it.dst === it.src );

  /* */

  test.case = 'dst - null, src - definition, should be identical';
  var definition = new _.Definition({ ini : 1, defGroup : 'definition.unnamed' });
  var it =
  {
    dst : null,
    src : definition
  };
  var got = _._cloneMapUp( it );
  test.identical( got, _.dont );
  test.identical( it.dst, definition );
  test.true( it.dst === it.src );

  test.case = 'dst - null, src - definition, should be identical';
  var definition = new _.Definition({ ini : 1, defGroup : 'definition.unnamed' });
  var it =
  {
    dst : 'should be replaced',
    src : definition
  };
  var got = _._cloneMapUp( it );
  test.identical( got, _.dont );
  test.identical( it.dst, definition );
  test.true( it.dst === it.src );

  /* */

  test.case = 'dst - null, src - not a map like, instanceAsMap - 1, should be identical';
  var it =
  {
    dst : null,
    src : [ 1, 2 ],
    instanceAsMap : 1,
  };
  var got = _._cloneMapUp( it );
  test.identical( got, it );
  test.identical( it.dst, [ undefined, undefined ] );
  test.true( it.dst !== it.src );

  test.case = 'dst - not null, src - not a map like, instanceAsMap - 1, should save dst';
  var it =
  {
    dst : 'dst',
    src : [ 1, 2 ],
    instanceAsMap : 1,
  };
  var got = _._cloneMapUp( it );
  test.identical( got, it );
  test.identical( it.dst, 'dst' );
  test.identical( it.src, [ 1, 2 ] );

  /* */

  test.case = 'dst - null, proto - constructor';
  var Constr = constr2;
  function constr2()
  {
    this.x = 1;
    return this;
  }
  var it =
  {
    dst : null,
    src : {},
    proto : new Constr,
  };
  var got = _._cloneMapUp( it );
  test.identical( got, it );
  test.identical( it.dst.x, 1 );

  test.case = 'dst - not null, proto - constructor';
  var Constr = constr2;
  function constr2()
  {
    this.x = 1;
    return this;
  }
  var it =
  {
    dst : 'dst',
    src : {},
    proto : new Constr,
  };
  var got = _._cloneMapUp( it );
  test.identical( got, it );
  test.identical( it.dst, 'dst' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _._cloneMapUp() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _._cloneMapUp( {}, {} ) );

  test.case = 'wrong type of src - null, have not constructor, copyingDegree !== 1, instanceAsMap - undefined';
  var it = { dst : null, src : null };
  test.shouldThrowErrorSync( () => _._cloneMapUp( it ) );

  test.case = 'wrong type of src - function, copyingDegree !== 1, instanceAsMap - undefined';
  var onErrorCallback = ( err, arg ) =>
  {
    test.true( _.errIs( err ) );
    test.identical( arg, undefined );
    test.identical( _.strCount( err.message, 'Complex objets should have ' ), 1 );
  }
  var it = { dst : null, src : function Construction(){} };
  test.shouldThrowErrorSync( () => _._cloneMapUp( it ) );

  test.case = 'dst - null, proto have no constructor';
  var it = { dst : null, src : {}, proto : Object.create( null ) };
  test.shouldThrowErrorSync( () => _._cloneMapUp( it ) );
}

//

function checker( t )
{

  /* map */

  t.description = 'similar map type, no content';
  var ins1 = Object.create( null );
  var ins2 = {};
  t.identical( ins1, ins2 );

  t.description = 'similar map type, same content';
  var ins1 = Object.create( null );
  ins1.a = 1;
  var ins2 = {};
  ins2.a = 1;
  t.identical( ins1, ins2 );

  /* array */

  t.description = 'different buffer type, same content';
  var ins1 = new F32x([ 1, 2, 3 ]);
  var ins2 = new F64x([ 1, 2, 3 ]);
  t.notIdentical( ins1, ins2 );

  t.description = 'different buffer type, same content';
  var ins1 = new F32x([ 1, 2, 3 ]);
  var ins2 = [ 1, 2, 3 ];
  t.notIdentical( ins1, ins2 );

  t.description = 'same buffer type, different content';
  var ins1 = new F32x([ 1, 2, 3 ]);
  var ins2 = new F32x([ 3, 4, 5 ]);
  t.notIdentical( ins1, ins2 );

  t.description = 'different buffer type, same content';
  var ins1 = new F32x([ 1, 2, 3 ]);
  var ins2 = new F32x([ 1, 2, 3 ]);
  t.identical( ins1, ins2 );

  t.description = 'same array type, same content';
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 1, 2, 3 ];
  t.identical( ins1, ins2 );

  t.description = 'BufferView, same content';
  var ins1 = new BufferView( new F32x([ 1, 2, 3 ]).buffer );
  var ins2 = new BufferView( new F32x([ 1, 2, 3 ]).buffer );
  t.identical( ins1, ins2 );

  t.description = 'BufferView, different content';
  var ins1 = new BufferView( new F32x([ 1, 2, 3 ]).buffer );
  var ins2 = new BufferView( new F32x([ 3, 2, 1 ]).buffer );
  t.notIdentical( ins1, ins2 );

  t.description = 'BufferRaw, same content';
  var ins1 = new BufferView( new F32x([ 1, 2, 3 ]).buffer );
  var ins2 = new BufferView( new F32x([ 1, 2, 3 ]).buffer );
  t.identical( ins1, ins2 );

  t.description = 'BufferRaw, different content';
  var ins1 = new BufferView( new F32x([ 1, 2, 3 ]).buffer );
  var ins2 = new BufferView( new F32x([ 3, 2, 1 ]).buffer );
  t.notIdentical( ins1, ins2 );

}

//

function trivial( t )
{

  t.description = 'cloning String';
  var src = 'abc';
  var dst = _.cloneJust( src );
  t.identical( dst, src );

  t.description = 'cloning Number';
  var src = 13;
  var dst = _.cloneJust( src );
  t.identical( dst, src );

  t.description = 'cloning BufferRaw';
  var src = new BufferRaw( 10 );
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst !== src );

  t.description = 'cloning BufferRaw';
  var src = new F32x([ 1, 2, 3, 4 ]).buffer;
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst !== src );

  t.description = 'cloning TypedBuffer';
  var src = new F32x( 10 );
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst instanceof F32x );
  t.true( dst !== src );

  t.description = 'cloning regexp';
  var src = /abc/;
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst === src );

  t.description = 'cloning BufferView';
  var src = new BufferView( new BufferRaw( 10 ) );
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst !== src );

  t.description = 'cloning Array';
  var src = new Array( 10 );
  var dst = _.cloneJust( src );
  t.identical( dst, src );

  t.description = 'cloning Array';
  var src = [ 1, 2, 3 ];
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst !== src );

  t.description = 'cloning Map';
  var src = Object.create( null );
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst !== src );

  t.description = 'cloning Map';
  var src = {};
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst !== src );

  t.description = 'cloning Map';
  var src = { a : 1, c : 3 };
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst !== src );

  t.description = 'cloning Set';
  var src = new Set([ 1, 3 ]);
  var dst = _.cloneJust( src );
  t.identical( dst, src );
  t.true( dst !== src );

}

//

function cloneObjectMergingBuffersTrivial( test )
{
  test.case = 'two empty descriptors';
  var dst = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [] ) });
  var src = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [] ) });
  var got = _.cloneObjectMergingBuffers({ dst, src });
  var exp = new F32x( [] );
  test.identical( got, exp );

  /* */

  test.case = 'dst - empty, src - filled';
  var dst = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [] ) });
  var src = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [ 1, 2 ] ) });
  var got = _.cloneObjectMergingBuffers({ dst, src });
  var exp = new F32x([ 1, 2 ]);
  test.identical( got, exp );

  /* */

  test.case = 'dst - filled, src - empty';
  var dst = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [ 1, 2 ] ) });
  var src = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [] ) });
  var got = _.cloneObjectMergingBuffers({ dst, src });
  var exp = new F32x( [] );
  test.identical( got, exp );

  /* */

  test.case = 'dst - filled, src - filled';
  var dst = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [ 1, 2 ] ) });
  var src = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [ 3, 4 ] ) });
  var got = _.cloneObjectMergingBuffers({ dst, src });
  var exp = new F32x([ 3, 4 ]);
  test.identical( got, exp );

  /* */

  test.case = 'dst - filled, src - filled, different buffer types';
  var dst = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new F32x( [ 1, 2 ] ) });
  var src = _.cloneDataSeparatingBuffers({ dst : new F32x( [] ), src : new I16x( [ 3, 4 ] ) });
  var got = _.cloneObjectMergingBuffers({ dst, src });
  var exp = new I16x([ 3, 4 ]);
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.cloneObjectMergingBuffers() );

  test.case = 'extra arguments';
  var o = { src : new U8x(), dst : new U8x() };
  test.shouldThrowErrorSync( () => _.cloneObjectMergingBuffers( o, o ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.cloneObjectMergingBuffers( 'wrong' ) );
}

//

function cloneDataSeparatingBuffersTrivial( test )
{
  test.case = 'two empty buffers';
  var dst = new F32x( [] );
  var src = new F32x( [] );
  var got = _.cloneDataSeparatingBuffers({ dst, src });
  var exp =
  {
    data : '--buffer-->0<--buffer--',
    descriptorsMap :
    {
      '--buffer-->0<--buffer--' :
      {
        bufferConstructorName : 'F32x',
        sizeOfScalar : 4,
        offset : 0,
        size : 0,
        index : 0
      }
    },
    buffer : new U8x( [] ).buffer,
  };
  test.identical( got, exp );

  /* */

  test.case = 'dst - empty, src - filled';
  var dst = new F32x( [] );
  var src = new F32x([ 1, 2 ]);
  var got = _.cloneDataSeparatingBuffers({ dst, src });
  var exp =
  {
    data : '--buffer-->0<--buffer--',
    descriptorsMap :
    {
      '--buffer-->0<--buffer--' :
      {
        bufferConstructorName : 'F32x',
        sizeOfScalar : 4,
        offset : 0,
        size : 8,
        index : 0
      }
    },
    buffer : new U8x([ 0, 0, 128, 63, 0, 0, 0, 64 ]).buffer,
  };
  test.identical( got, exp );

  /* */

  test.case = 'dst - filled, src - empty';
  var dst = new F32x([ 1, 2 ]);
  var src = new F32x( [] );
  var got = _.cloneDataSeparatingBuffers({ dst, src });
  var exp =
  {
    data : '--buffer-->0<--buffer--',
    descriptorsMap :
    {
      '--buffer-->0<--buffer--' :
      {
        bufferConstructorName : 'F32x',
        sizeOfScalar : 4,
        offset : 0,
        size : 0,
        index : 0
      }
    },
    buffer : new U8x( [] ).buffer,
  };
  test.identical( got, exp );

  /* */

  test.case = 'dst - filled, src - filled';
  var dst = new F32x([ 1, 2 ]);
  var src = new F32x([ 3, 4 ]);
  var got = _.cloneDataSeparatingBuffers({ dst, src });
  var exp =
  {
    data : '--buffer-->0<--buffer--',
    descriptorsMap :
    {
      '--buffer-->0<--buffer--' :
      {
        bufferConstructorName : 'F32x',
        sizeOfScalar : 4,
        offset : 0,
        size : 8,
        index : 0
      }
    },
    buffer : new U8x([ 0, 0, 64, 64, 0, 0, 128, 64 ]).buffer,
  };
  test.identical( got, exp );

  /* */

  test.case = 'dst - filled, src - filled, different buffer types';
  var dst = new F32x([ 1, 2 ]);
  var src = new I16x([ 3, 4 ]);
  var got = _.cloneDataSeparatingBuffers({ dst, src });
  var exp =
  {
    data : '--buffer-->0<--buffer--',
    descriptorsMap :
    {
      '--buffer-->0<--buffer--' :
      {
        bufferConstructorName : 'I16x',
        sizeOfScalar : 2,
        offset : 0,
        size : 4,
        index : 0
      }
    },
    buffer : new U8x([ 3, 0, 4, 0 ]).buffer,
  };
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.cloneDataSeparatingBuffers() );

  test.case = 'extra arguments';
  var o = { src : new U8x(), dst : new U8x() };
  test.shouldThrowErrorSync( () => _.cloneDataSeparatingBuffers( o, o ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.cloneDataSeparatingBuffers( 'wrong' ) );
}

//

const Proto =
{

  name : 'Tools.l5.Cloner',
  silencing : 1,

  tests :
  {

    traverseMapWithClonerRoutines,

    //

    _cloneMapUp,

    checker,
    trivial,

    cloneObjectMergingBuffersTrivial,
    cloneDataSeparatingBuffersTrivial,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
