( function _l0_l3_Long_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../Include3.s' );
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

//--
// long
//--

function identical( test )
{
  test.case = 'empty arrays';
  var got = _.long.identical( [], [] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'arrays are equal';
  var got = _.long.identical( [ 1, 2, 3 ], [ 1, 2, 3 ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  function src1()
  {
    return arguments;
  };
  function src2()
  {
    return arguments;
  };
  var got = _.long.identical( src1( 3, 7, 33 ), src2( 3, 7, 13 ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arrays are not equal';
  var got = _.long.identical( [ 1, 2, 3, 'Hi!' ], [ 1, 2, 3, 'Hello there!' ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arrays length are not equal';
  var got = _.long.identical( [ 1, 2, 3 ], [ 1, 2 ] );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.long.identical() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.long.identical( [ 1, 2, 3 ] ) );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.long.identical( [ 1, 2, 3 ], [ 1, 2 ], {}, 'extra' ) );
};

//

function filterMapCommonPass( test )
{
  let ops = [];
  let env;

  namespaceEach({ method : 'filterWithoutEscapeLeft', left : 1 });
  namespaceEach({ method : 'filterWithoutEscapeRight', left : 0 });
  namespaceEach({ method : 'filterWithoutEscape', left : 1 });
  namespaceEach({ method : 'filterWithEscapeLeft', left : 1 });
  namespaceEach({ method : 'filterWithEscapeRight', left : 0 });
  namespaceEach({ method : 'filterWithEscape', left : 1 });
  namespaceEach({ method : 'filter', left : 1 });

  namespaceEach({ method : 'mapWithoutEscapeLeft', left : 1 });
  namespaceEach({ method : 'mapWithoutEscapeRight', left : 0 });
  namespaceEach({ method : 'mapWithoutEscape', left : 1 });
  namespaceEach({ method : 'mapWithEscapeLeft', left : 1 });
  namespaceEach({ method : 'mapWithEscapeRight', left : 0 });
  namespaceEach({ method : 'mapWithEscape', left : 1 });
  namespaceEach({ method : 'map', left : 1 });

  /* - */

  function namespaceEach( env )
  {

    /* variable */

    env.namespace = 'long';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'array';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'unroll';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'countable';
    env.isResizable = true;
    env.makable = false;
    caseEach( env );
    env.namespace = 'vector';
    env.isResizable = true;
    env.makable = false;
    caseEach( env );

    /* fixed */

    env.namespace = 'argumentsArray';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'bufferTyped';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'bufferBytes';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'f32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'f64x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'fx';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i16x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i8x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'ix';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u16x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u8x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u8xClamped';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'ux';
    env.isResizable = false;
    caseEach( env );

  }

  /* - */

  function caseEach( _env )
  {
    test.case = `${__.entity.exportStringSolo( env )}`;
    env = _env;
    if( env.makable !== false )
    test.identical( _.countable.isResizable( _[ env.namespace ].make( 0 ) ), env.isResizable );

    /* */

    if( env.isResizable )
    {
      test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, shorter`;
      clean();
      var src = [ 1, 2, 3 ];
      var dst = _[ env.namespace ].make([ 4 ]);
      var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
      test.true( got === dst );
      var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
      test.identical( got, exp );
      var exp = [ 1, 2, 3 ];
      test.identical( src, exp );
      var exp = order([ 1, 2, 3 ]);
      test.identical( __.select( ops, '*/#0' ), exp );
      var exp = order([ 0, 1, 2 ]);
      test.identical( __.select( ops, '*/#1' ), exp );
      var exp = order([ 0, 1, 2 ]);
      test.identical( __.select( ops, '*/#2' ), exp );
      var exp = order([ src, src, src ]);
      test.identical( __.select( ops, '*/#3' ), exp );
      var exp = order([ got, got, got ]);
      test.identical( __.select( ops, '*/#4' ), exp );
    }
    else if( Config.debug )
    {
      test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, shorter`;
      clean();
      var src = [ 1, 2, 3 ];
      var dst = _[ env.namespace ].make([ 4 ]);
      test.shouldThrowErrorSync( () => _[ env.namespace ][ env.method ]( dst, src, f1 ) );
    }

    /* */

    if( env.isResizable )
    {
      test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, longer`;
      clean();
      var src = [ 1, 2, 3 ];
      var dst = _[ env.namespace ].make([ 4, 5, 6, 7 ]);
      var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
      test.true( got === dst );
      var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
      test.identical( got, exp );
      var exp = [ 1, 2, 3 ];
      test.identical( src, exp );
      var exp = order([ 1, 2, 3 ]);
      test.identical( __.select( ops, '*/#0' ), exp );
      var exp = order([ 0, 1, 2 ]);
      test.identical( __.select( ops, '*/#1' ), exp );
      var exp = order([ 0, 1, 2 ]);
      test.identical( __.select( ops, '*/#2' ), exp );
      var exp = order([ src, src, src ]);
      test.identical( __.select( ops, '*/#3' ), exp );
      var exp = order([ got, got, got ]);
      test.identical( __.select( ops, '*/#4' ), exp );
    }
    else if( Config.debug )
    {
      test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, longer`;
      clean();
      var src = [ 1, 2, 3 ];
      var dst = _[ env.namespace ].make([ 4, 5, 6, 7 ]);
      test.shouldThrowErrorSync( () => _[ env.namespace ][ env.method ]( dst, src, f1 ) );
    }

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, same length`;
    clean();
    var src = [ 1, 2, 3 ];
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
    test.identical( got, exp );
    var exp = [ 1, 2, 3 ];
    test.identical( src, exp );
    var exp = order([ 1, 2, 3 ]);
    test.identical( __.select( ops, '*/#0' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#1' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#2' ), exp );
    var exp = order([ src, src, src ]);
    test.identical( __.select( ops, '*/#3' ), exp );
    var exp = order([ got, got, got ]);
    test.identical( __.select( ops, '*/#4' ), exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, same length, countable`;
    clean();
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    test.identical( src, exp );
    var exp = order([ 1, 2, 3 ]);
    test.identical( __.select( ops, '*/#0' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#1' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#2' ), exp );
    var exp = order([ src, src, src ]);
    test.identical( __.select( ops, '*/#3' ), exp );
    var exp = order([ got, got, got ]);
    test.identical( __.select( ops, '*/#4' ), exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, same length, vector`;
    clean();
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    test.identical( src, exp );
    var exp = order([ 1, 2, 3 ]);
    test.identical( __.select( ops, '*/#0' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#1' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#2' ), exp );
    var exp = order([ src, src, src ]);
    test.identical( __.select( ops, '*/#3' ), exp );
    var exp = order([ got, got, got ]);
    test.identical( __.select( ops, '*/#4' ), exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null`;
    clean();
    var src = [ 1, 2, 3 ];
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( _[ env.namespace ].is( got ) );
    test.true( got !== src );
    var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
    test.identical( got, exp );
    var exp = [ 1, 2, 3 ]
    test.identical( src, exp );
    var exp = order([ 1, 2, 3 ]);
    test.identical( __.select( ops, '*/#0' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#1' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#2' ), exp );
    var exp = order([ src, src, src ]);
    test.identical( __.select( ops, '*/#3' ), exp );
    var exp = order([ got, got, got ]);
    if( !env.isResizable && _.strBegins( env.method, 'filter' ) )
    {
      var dst2 = [ 11, 12, 13 ];
      exp = order([ dst2, dst2, dst2 ]);
    }
    test.identical( __.select( ops, '*/#4' ), exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null, countable`;
    clean();
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( _[ env.namespace ].is( got ) );
    test.true( got !== src );
    var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
    if( env.namespace === 'countable' )
    exp = __.diagnostic.objectMake({ elements : [ 11, 12, 13 ] });
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    test.identical( src, exp );
    var exp = order([ 1, 2, 3 ]);
    test.identical( __.select( ops, '*/#0' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#1' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#2' ), exp );
    var exp = order([ src, src, src ]);
    test.identical( __.select( ops, '*/#3' ), exp );
    var exp = order([ got, got, got ]);
    if( !_.countable.isResizable( got ) && _.strBegins( env.method, 'filter' ) )
    {
      var dst2 = [ 11, 12, 13 ];
      exp = order([ dst2, dst2, dst2 ]);
    }
    test.identical( __.select( ops, '*/#4' ), exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null, vector`;
    clean();
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( _[ env.namespace ].is( got ) );
    test.true( got !== src );
    var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
    if( env.namespace === 'countable' || env.namespace === 'vector' )
    exp = __.diagnostic.objectMake({ elements : [ 11, 12, 13 ], vector : 1 });
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    test.identical( src, exp );
    var exp = order([ 1, 2, 3 ]);
    test.identical( __.select( ops, '*/#0' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#1' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#2' ), exp );
    var exp = order([ src, src, src ]);
    test.identical( __.select( ops, '*/#3' ), exp );
    var exp = order([ got, got, got ]);
    if( !_.countable.isResizable( got ) && _.strBegins( env.method, 'filter' ) )
    {
      var dst2 = [ 11, 12, 13 ];
      exp = order([ dst2, dst2, dst2 ]);
    }
    test.identical( __.select( ops, '*/#4' ), exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === src`;
    clean();
    var src = _[ env.namespace ].make([ 1, 2, 3 ]);
    var got = _[ env.namespace ][ env.method ]( src, src, f1 );
    test.true( got === src );
    var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
    test.identical( got, exp );
    var exp = order([ 1, 2, 3 ]);
    test.identical( __.select( ops, '*/#0' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#1' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#2' ), exp );
    var exp = order([ src, src, src ]);
    test.identical( __.select( ops, '*/#3' ), exp );
    var exp = order([ got, got, got ]);
    test.identical( __.select( ops, '*/#4' ), exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === self`;
    clean();
    var src = _[ env.namespace ].make([ 1, 2, 3 ]);
    var got = _[ env.namespace ][ env.method ]( _.self, src, f1 );
    test.true( got === src );
    var exp = _[ env.namespace ].make([ 11, 12, 13 ]);
    test.identical( got, exp );
    var exp = order([ 1, 2, 3 ]);
    test.identical( __.select( ops, '*/#0' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#1' ), exp );
    var exp = order([ 0, 1, 2 ]);
    test.identical( __.select( ops, '*/#2' ), exp );
    var exp = order([ src, src, src ]);
    test.identical( __.select( ops, '*/#3' ), exp );
    var exp = order([ got, got, got ]);
    test.identical( __.select( ops, '*/#4' ), exp );

    /* */

  }

  /* - */

  function order( dst )
  {
    if( !env.left )
    dst.reverse();
    return dst;
  }

  /* - */

  function clean()
  {
    ops = [];
  }

  /* - */

  function f1( e, k, c, src )
  {
    ops.push([ ... arguments ]);
    return e + 10;
  }

  /* - */

}

filterMapCommonPass.timeOut = 300000;
filterMapCommonPass.rapidity = -1;

//

function filterCommonDropping( test )
{
  let env;

  namespaceEach({ method : 'filterWithoutEscapeLeft', left : 1 });
  namespaceEach({ method : 'filterWithoutEscapeRight', left : 0 });
  namespaceEach({ method : 'filterWithoutEscape', left : 1 });
  namespaceEach({ method : 'filterWithEscapeLeft', left : 1 });
  namespaceEach({ method : 'filterWithEscapeRight', left : 0 });
  namespaceEach({ method : 'filterWithEscape', left : 1 });
  namespaceEach({ method : 'filter', left : 1 });

  /* - */

  function namespaceEach( env )
  {

    /* variable */

    env.namespace = 'long';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'array';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'unroll';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'countable';
    env.isResizable = true;
    env.makable = false;
    caseEach( env );
    env.namespace = 'vector';
    env.isResizable = true;
    env.makable = false;
    caseEach( env );

    /* fixed */

    env.namespace = 'argumentsArray';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'bufferTyped';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'bufferBytes';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'f32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'f64x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'fx';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i16x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i8x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'ix';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u16x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u8x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u8xClamped';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'ux';
    env.isResizable = false;
    caseEach( env );

  }

  /* - */

  function caseEach( _env )
  {
    env = _env;

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, same length`;
    var src = [ 1, 2, 3 ];
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 5, 13 ]);
    if( env.isResizable )
    exp = _[ env.namespace ].make([ 11, 13 ]);
    test.identical( got, exp );
    var exp = [ 1, 2, 3 ];
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, same length, countable`;
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 5, 13 ]);
    if( env.isResizable )
    exp = _[ env.namespace ].make([ 11, 13 ]);
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, same length, vector`;
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 5, 13 ]);
    if( env.isResizable )
    exp = _[ env.namespace ].make([ 11, 13 ]);
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    test.identical( src, exp );

    /* */

    if( env.isResizable )
    {
      test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, shorter`;
      var src = [ 1, 2, 3 ];
      var dst = _[ env.namespace ].make([ 4 ]);
      var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
      test.true( got === dst );
      var exp = _[ env.namespace ].make([ 11, 13 ]);
      test.identical( got, exp );
      var exp = [ 1, 2, 3 ];
      test.identical( src, exp );
    }
    else if( Config.debug )
    {
      test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, shorter`;
      var src = [ 1, 2, 3 ];
      var dst = _[ env.namespace ].make([ 4 ]);
      test.shouldThrowErrorSync( () => _[ env.namespace ][ env.method ]( dst, src, f1 ) );
      var exp = _[ env.namespace ].make([ 4 ]);
      test.identical( dst, exp );
      var exp = [ 1, 2, 3 ];
      test.identical( src, exp );
    }

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null`;
    var src = [ 1, 2, 3 ];
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( got !== src );
    test.true( _[ env.namespace ].is( got ) );
    var exp = _[ env.namespace ].make([ 11, 13 ]);
    test.identical( got, exp );
    var exp = [ 1, 2, 3 ]
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null, countable`;
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( got !== src );
    test.true( _[ env.namespace ].is( got ) );
    var exp = _[ env.namespace ].make([ 11, 13 ]);
    if( env.namespace === 'countable' )
    exp = __.diagnostic.objectMake({ elements : [ 11, 13 ], countable : 1 });
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null, vector`;
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( got !== src );
    test.true( _[ env.namespace ].is( got ) );
    var exp = _[ env.namespace ].make([ 11, 13 ]);
    if( env.namespace === 'countable' || env.namespace === 'vector' )
    exp = __.diagnostic.objectMake({ elements : [ 11, 13 ], vector : 1 });
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === src`;
    var src = _[ env.namespace ].make([ 1, 2, 3 ]);
    var got = _[ env.namespace ][ env.method ]( src, src, f1 );
    test.true( got === src );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    if( env.isResizable )
    exp = _[ env.namespace ].make([ 11, 13 ]);
    test.identical( got, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === self`;
    var src = _[ env.namespace ].make([ 1, 2, 3 ]);
    var got = _[ env.namespace ][ env.method ]( _.self, src, f1 );
    test.true( got === src );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    if( env.isResizable )
    exp = _[ env.namespace ].make([ 11, 13 ]);
    test.identical( got, exp );

    /* */

  }

  /* - */

  function f1( e, k, c, src )
  {
    if( e === 2 )
    return undefined;
    return e + 10;
  }

  /* - */

}

filterCommonDropping.timeOut = 60000;
filterCommonDropping.rapidity = -1;

//

function mapCommonReturningUndefined( test )
{
  let env;

  namespaceEach({ method : 'mapWithoutEscapeLeft', left : 1 });
  namespaceEach({ method : 'mapWithoutEscapeRight', left : 0 });
  namespaceEach({ method : 'mapWithoutEscape', left : 1 });
  namespaceEach({ method : 'mapWithEscapeLeft', left : 1 });
  namespaceEach({ method : 'mapWithEscapeRight', left : 0 });
  namespaceEach({ method : 'mapWithEscape', left : 1 });
  namespaceEach({ method : 'map', left : 1 });

  /* - */

  function namespaceEach( env )
  {

    /* variable */

    env.namespace = 'long';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'array';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'unroll';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'countable';
    env.isResizable = true;
    env.makable = false;
    caseEach( env );
    env.namespace = 'vector';
    env.isResizable = true;
    env.makable = false;
    caseEach( env );

    /* fixed */

    env.namespace = 'argumentsArray';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'bufferTyped';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'bufferBytes';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'f32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'f64x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'fx';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i16x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'i8x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'ix';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u32x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u16x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u8x';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'u8xClamped';
    env.isResizable = false;
    caseEach( env );
    env.namespace = 'ux';
    env.isResizable = false;
    caseEach( env );

  }

  /* - */

  function caseEach( _env )
  {
    env = _env;

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src`;
    var src = [ 1, 2, 3 ];
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    test.identical( got, exp );
    var exp = [ 1, 2, 3 ];
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, countable`;
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src, vector`;
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null`;
    var src = [ 1, 2, 3 ];
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( got !== src );
    test.true( _[ env.namespace ].is( got ) );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    test.identical( got, exp );
    var exp = [ 1, 2, 3 ]
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null, countable`;
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( got !== src );
    test.true( _[ env.namespace ].is( got ) );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    if( env.namespace === 'countable' )
    exp = __.diagnostic.objectMake({ elements : [ 11, 2, 13 ], countable : 1 });
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], countable : 1 });
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null, vector`;
    var src = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( got !== src );
    test.true( _[ env.namespace ].is( got ) );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    if( env.namespace === 'vector' || env.namespace === 'countable' )
    exp = __.diagnostic.objectMake({ elements : [ 11, 2, 13 ], vector : 1 });
    test.identical( got, exp );
    var exp = __.diagnostic.objectMake({ elements : [ 1, 2, 3 ], vector : 1 });
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === src`;
    var src = _[ env.namespace ].make([ 1, 2, 3 ]);
    var got = _[ env.namespace ][ env.method ]( src, src, f1 );
    test.true( got === src );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    test.identical( got, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === self`;
    var src = _[ env.namespace ].make([ 1, 2, 3 ]);
    var got = _[ env.namespace ][ env.method ]( _.self, src, f1 );
    test.true( got === src );
    var exp = _[ env.namespace ].make([ 11, 2, 13 ]);
    test.identical( got, exp );

    /* */

  }

  /* - */

  function f1( e, k, c, src )
  {
    if( e === 2 )
    return undefined;
    return e + 10;
  }

  /* - */

}

mapCommonReturningUndefined.timeOut = 60000;
mapCommonReturningUndefined.rapidity = -1;

//

function filterMapCommonEscaping( test )
{
  let env;

  namespaceEach({ method : 'filterWithoutEscapeLeft', left : 1, escaping : 0 });
  namespaceEach({ method : 'filterWithoutEscapeRight', left : 0, escaping : 0 });
  namespaceEach({ method : 'filterWithoutEscape', left : 1, escaping : 0 });
  namespaceEach({ method : 'filterWithEscapeLeft', left : 1, escaping : 1 });
  namespaceEach({ method : 'filterWithEscapeRight', left : 0, escaping : 1 });
  namespaceEach({ method : 'filterWithEscape', left : 1, escaping : 1 });
  namespaceEach({ method : 'filter', left : 1, escaping : 0 });

  namespaceEach({ method : 'mapWithoutEscapeLeft', left : 1, escaping : 0 });
  namespaceEach({ method : 'mapWithoutEscapeRight', left : 0, escaping : 0 });
  namespaceEach({ method : 'mapWithoutEscape', left : 1, escaping : 0 });
  namespaceEach({ method : 'mapWithEscapeLeft', left : 1, escaping : 1 });
  namespaceEach({ method : 'mapWithEscapeRight', left : 0, escaping : 1 });
  namespaceEach({ method : 'mapWithEscape', left : 1, escaping : 1 });
  namespaceEach({ method : 'map', left : 1, escaping : 0 });

  /* - */

  function namespaceEach( env )
  {

    /* variable */

    env.namespace = 'long';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'array';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'unroll';
    env.isResizable = true;
    caseEach( env );
    env.namespace = 'countable';
    env.isResizable = true;
    env.makable = false;
    caseEach( env );
    env.namespace = 'vector';
    env.isResizable = true;
    env.makable = false;
    caseEach( env );

    /* fixed */

    env.namespace = 'argumentsArray';
    env.isResizable = false;
    caseEach( env );

  }

  /* - */

  function caseEach( _env )
  {
    env = _env;

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst <> src`;
    var src = [ 1, 2, 3 ];
    var dst = _[ env.namespace ].make([ 4, 5, 6 ]);
    var got = _[ env.namespace ][ env.method ]( dst, src, f1 );
    test.true( got === dst );
    var exp = _[ env.namespace ].make([ 11, _.undefined, 13 ]);
    if( env.escaping )
    exp = _[ env.namespace ].make([ 11, undefined, 13 ]);
    test.identical( got, exp );
    var exp = [ 1, 2, 3 ];
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === null`;
    var src = [ 1, 2, 3 ];
    var got = _[ env.namespace ][ env.method ]( null, src, f1 );
    test.true( got !== src );
    test.true( _[ env.namespace ].is( got ) );
    var exp = _[ env.namespace ].make([ 11, _.undefined, 13 ]);
    if( env.escaping )
    exp = _[ env.namespace ].make([ 11, undefined, 13 ]);
    test.identical( got, exp );
    var exp = [ 1, 2, 3 ]
    test.identical( src, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === src`;
    var src = _[ env.namespace ].make([ 1, 2, 3 ]);
    var got = _[ env.namespace ][ env.method ]( src, src, f1 );
    test.true( got === src );
    var exp = _[ env.namespace ].make([ 11, _.undefined, 13 ]);
    if( env.escaping )
    exp = _[ env.namespace ].make([ 11, undefined, 13 ]);
    test.identical( got, exp );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, pass, dst === self`;
    var src = _[ env.namespace ].make([ 1, 2, 3 ]);
    var got = _[ env.namespace ][ env.method ]( _.self, src, f1 );
    test.true( got === src );
    var exp = _[ env.namespace ].make([ 11, _.undefined, 13 ]);
    if( env.escaping )
    exp = _[ env.namespace ].make([ 11, undefined, 13 ]);
    test.identical( got, exp );

    /* */

  }

  /* - */

  function escape( src )
  {
    if( env.escaping )
    return src;
    return _.escape.left( src );
  }

  /* - */

  function f1( e, k, c, src )
  {
    if( e === 2 )
    return _.escape.left( undefined );
    return e + 10;
  }

  /* - */

}

filterMapCommonEscaping.timeOut = 60000;
filterMapCommonEscaping.rapidity = -1;

// --
//
// --

const Proto =
{

  name : 'Tools.Long.l0.l3',
  silencing : 1,
  enabled : 1,

  tests :
  {

    // long l0/l3

    identical,

    filterMapCommonPass,
    filterCommonDropping,
    mapCommonReturningUndefined,
    filterMapCommonEscaping,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
