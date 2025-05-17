( function _l0_l1_Set_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../Include1.s' );
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

// --
// tests
// --

function dichotomy( test )
{

  test.case = 'empty set';
  var src = new Set();
  test.true( _.set.is( src ) );
  test.true( _.set.like( src ) );

  test.case = 'populated set';
  var src = new Set([ 1, 2 ]);
  test.true( _.set.is( src ) );
  test.true( _.set.like( src ) );

  test.case = 'array';
  var src = [ 1, 2 ];
  test.true( !_.set.is( src ) );
  test.true( !_.set.like( src ) );

  test.case = 'arguments array';
  var src = _.argumentsArray.from([ 1, 2 ]);
  test.true( !_.set.is( src ) );
  test.true( !_.set.like( src ) );

}

//

function as( test )
{

  act({ method : 'as' });
  // act({ method : 'asTest' });

  function act( env )
  {

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, null`;
    var got = _.set[ env.method ]( null );
    var expected = new Set;
    test.identical( got, expected );

    /* */ /* qqq : for Rahul : improve style of test */

    test.case = `${__.entity.exportStringSolo( env )}, two arguments`;
    var got = _.set[ env.method ]( null, [ 1, 2, 3] );
    var expected = new Set;
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, boolean false`;
    var got = _.set[ env.method ]( false );
    var expected = new Set( [ false ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, boolean true`;
    var got = _.set[ env.method ]( true );
    var expected = new Set( [ true ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, NaN`;
    var got = _.set[ env.method ]( NaN );
    var expected = new Set( [ NaN ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a Number`;
    var src = 123;
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a string primitive`;
    var src = 'string';
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a string object`;
    var src = new String( 'string' );
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a Date`;
    var src = new Date();
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a Symbol`;
    var src = Symbol( 'a' );
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a Function`;
    var src = new function(){};
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a pure map`;
    var src = Object.create( null );
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a map`;
    var src = { a : 1, b : 2 };
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, Object Prototype`;
    var src = Object.prototype;
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a weak map`;
    var obj1 = {};
    var obj2 = {};
    var obj3 = {};
    var src = new WeakMap( [ [ obj1, 'one' ], [ obj2, 'two' ], [ obj3, 'three' ] ] );
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a Set`;
    var src = new Set( [ 1, 1, 2, 2 ] );
    var got = _.set[ env.method ]( src );
    var expected = src;
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a WeakSet`;
    var obj1 = { a : 1, b : 2 };
    var obj2 = { a : 3, b : 4 }
    var src = new WeakSet( [ obj1, obj2 ] );
    var got = _.set[ env.method ]( src );
    var expected = src;
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a WeakSet with user defined iterable at initialization`;
    var obj1 = { a : 1, b : 2 };
    var obj2 = { a : 3, b : 4 }
    var src = new WeakSet( function* () { yield obj1, yield obj2 }() );
    var got = _.set[ env.method ]( src );
    var expected = src;
    test.identical( got, expected );

    /* */
    test.case = `${__.entity.exportStringSolo( env )}, argument object`;
    var src = arguments;
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ ... src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, an Array Prototype`;
    var src = Array.prototype;
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ ... src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, an Array`;
    var src = [ 1, 2, 3 ];
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ ... src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, two array arguments`;
    var src = [ 1, 2, 3 ];
    var got = _.set[ env.method ]( src, src );
    var expected = new Set( [ ... src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a typed Array`;
    var src = new Uint8Array( 32 );
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ ... src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a hash map`;
    var src = new Map( [ [ 1, 'one' ], [ 2, 'two' ], [ 3, 'three' ] ] );
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ ... src ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a generator function`;
    var src = function* ( i )
    {
      yield i;
      yield i + 10;
    }
    var got = _.set[ env.method ]( src( 10 ) );
    var expected = new Set( [ ... src( 10 ) ] );
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, an array having generator function as it's Symbol.iterator`;
    var src = [];
    src[ Symbol.iterator ] = function* ()
    {
      yield 1;
      yield 2;
      yield 3;
    };
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ ... src ]);
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, a set having generator function as it's Symbol.iterator`;
    var src = new Set();
    src[ Symbol.iterator ] = function* ()
    {
      yield 1;
      yield 2;
      yield 3;
    };
    var got = _.set[ env.method ]( src );
    var expected = new Set([ ... src ]);
    test.notIdentical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, an Object having a generator function as it's Symbol.iterator`;
    var src = {};
    src[ Symbol.iterator ] = function* ()
    {
      yield 1;
      yield 2;
      yield 3;
    };
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ ... src ]);
    test.identical( got, expected );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, an iterable defined inside a class`;
    class srcTemplate
    {
      *[ Symbol.iterator ] ()
      {
        yield 'a';
        yield 'b';
      }
    }
    var src = new srcTemplate;
    var got = _.set[ env.method ]( src );
    var expected = new Set( [ ... src ]);
    test.identical( got, expected );

    /* */

    if( Config.debug )
    return;

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, undefined`;

    /* */

    test.shouldThrowSync( () => _.set[ env.method ]( undefined ) );

    /* */

    test.shouldThrowSync( () => _.set[ env.method ]() );
  }
}

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Set.l0.l1',
  silencing : 1,

  tests :
  {

    dichotomy,
    as,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
