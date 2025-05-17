( function _l0_l1_Container_test_s()
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

//--
// dichotomy
//--

/* qqq : extend with other checks */
function dichotomy( test )
{

  test.case = 'not';
  test.identical( _.container.is( null ), false );
  test.identical( _.container.is( undefined ), false );
  test.identical( _.container.is( 'str' ), false );
  test.identical( _.container.is( 0 ), false );
  test.identical( _.container.is( 1 ), false );
  test.identical( _.container.is( false ), false );
  test.identical( _.container.is( true ), false );
  test.identical( _.container.is( new Date() ), false );

  test.case = 'map';
  test.identical( _.container.is( {} ), true );
  test.identical( _.container.is( { a : 1 } ), true );
  test.identical( _.container.is( Object.create( null ) ), true );

  test.case = 'instance';
  let src = new function Con() { this.a = 1 };
  test.identical( _.container.is( src ), false );

  test.case = 'hashMap';
  test.identical( _.container.is( new HashMap ), true );
  test.identical( _.container.is( new HashMap([ [ 'a', 'b' ] ]) ), true );

  test.case = 'array';
  test.identical( _.container.is( [] ), true );
  test.identical( _.container.is( [ false ] ), true );

  test.case = 'typed buffer';
  test.identical( _.container.is( new F32x() ), true );
  test.identical( _.container.is( new F32x([ 1, 2, 3 ]) ), true );

  test.case = 'set';
  test.identical( _.container.is( new Set ), true );
  test.identical( _.container.is( new Set([ 'a', 'b' ]) ), true );

}

//

function instanceOfContainer( test )
{

  test.case = 'not';
  test.identical( null instanceof _.container, false );
  test.identical( undefined instanceof _.container, false );
  test.identical( 'str' instanceof _.container, false );
  test.identical( 0 instanceof _.container, false );
  test.identical( 1 instanceof _.container, false );
  test.identical( false instanceof _.container, false );
  test.identical( true instanceof _.container, false );
  test.identical( new Date() instanceof _.container, false );

  test.case = 'map';
  test.identical( {} instanceof _.container, true );
  var map = { a : 1 };
  test.identical( map instanceof _.container, true );
  var map = Object.create( null );
  test.identical( map instanceof _.container, true );

  test.case = 'hashMap';
  test.identical( new HashMap instanceof _.container, true );
  test.identical( new HashMap([ [ 'a', 'b' ] ]) instanceof _.container, true );

  test.case = 'array';
  test.identical( [] instanceof _.container, true );
  test.identical( [ false ] instanceof _.container, true );

  test.case = 'typed buffer';
  test.identical( new F32x() instanceof _.container, true );
  test.identical( new F32x([ 1, 2, 3 ]) instanceof _.container, true );

  test.case = 'set';
  test.identical( new Set instanceof _.container, true );
  test.identical( new Set([ 'a', 'b' ]) instanceof _.container, true );

}

//

function namespaceOf( test )
{

  test.case = 'undefined';
  var src = undefined;
  test.true( _.container.namespaceOf( src ) === _.blank );
  test.true( _.container.namespaceForIterating( src ) === _.blank );
  test.true( _.container.namespaceForExporting( src ) === _.primitive );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.blank );
  test.true( _.entity.namespaceOf( src ) === _.blank );
  test.true( _.entity.namespaceForIterating( src ) === _.blank );
  test.true( _.entity.namespaceForExporting( src ) === _.primitive );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.blank );

  test.case = 'primitive';
  var src = 13;
  test.true( _.container.namespaceOf( src ) === _.blank );
  test.true( _.container.namespaceForIterating( src ) === _.blank );
  test.true( _.container.namespaceForExporting( src ) === _.primitive );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.blank );
  test.true( _.entity.namespaceOf( src ) === _.itself );
  test.true( _.entity.namespaceForIterating( src ) === _.itself );
  test.true( _.entity.namespaceForExporting( src ) === _.primitive );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.itself );

  test.case = 'non-primitive';
  var src = /abc/;
  test.true( _.container.namespaceOf( src ) === _.blank );
  test.true( _.container.namespaceForIterating( src ) === _.blank );
  test.true( _.container.namespaceForExporting( src ) === _.regexp );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.blank );
  test.true( _.entity.namespaceOf( src ) === _.object );
  test.true( _.entity.namespaceForIterating( src ) === _.object );
  test.true( _.entity.namespaceForExporting( src ) === _.regexp );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.object );

  test.case = 'routine';
  var src = function f1(){};
  test.true( _.container.namespaceOf( src ) === _.blank );
  test.true( _.container.namespaceForIterating( src ) === _.blank );
  test.true( _.container.namespaceForExporting( src ) === _.routine );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.blank );
  test.true( _.entity.namespaceOf( src ) === _.props );
  test.true( _.entity.namespaceForIterating( src ) === _.props );
  test.true( _.entity.namespaceForExporting( src ) === _.routine );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.props );

  test.case = 'countable map';
  var src = __.diagnostic.objectMake({ new : 0, elements : [ '1', '2', '3' ], countable : 1 });
  test.true( _.container.namespaceOf( src ) === _.countable );
  test.true( _.container.namespaceForIterating( src ) === _.countable );
  test.true( _.container.namespaceForExporting( src ) === _.countable );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.countable );
  test.true( _.entity.namespaceOf( src ) === _.object );
  test.true( _.entity.namespaceForIterating( src ) === _.object );
  test.true( _.entity.namespaceForExporting( src ) === _.countable );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.object );

  test.case = 'countable object';
  var src = __.diagnostic.objectMake({ new : 1, elements : [ '1', '2', '3' ], countable : 1 });
  test.true( _.container.namespaceOf( src ) === _.countable );
  test.true( _.container.namespaceForIterating( src ) === _.countable );
  test.true( _.container.namespaceForExporting( src ) === _.countable );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.countable );
  test.true( _.entity.namespaceOf( src ) === _.object );
  test.true( _.entity.namespaceForIterating( src ) === _.object );
  test.true( _.entity.namespaceForExporting( src ) === _.countable );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.object );

  test.case = 'object';
  var src = __.diagnostic.objectMake({ new : 1, elements : [ '1', '2', '3' ], countable : 0 });
  test.true( _.container.namespaceOf( src ) === _.blank );
  test.true( _.container.namespaceForIterating( src ) === _.blank );
  test.true( _.container.namespaceForExporting( src ) === _.object );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.blank );
  test.true( _.entity.namespaceOf( src ) === _.object );
  test.true( _.entity.namespaceForIterating( src ) === _.object );
  test.true( _.entity.namespaceForExporting( src ) === _.object );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.object );

  test.case = 'map';
  var src = {};
  test.true( _.container.namespaceOf( src ) === _.aux );
  test.true( _.container.namespaceForIterating( src ) === _.aux );
  test.true( _.container.namespaceForExporting( src ) === _.aux );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.aux );
  test.true( _.entity.namespaceOf( src ) === _.aux );
  test.true( _.entity.namespaceForIterating( src ) === _.aux );
  test.true( _.entity.namespaceForExporting( src ) === _.aux );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.aux );

  test.case = 'aux';
  var src = Object.create( {} );
  test.true( _.container.namespaceOf( src ) === _.aux );
  test.true( _.container.namespaceForIterating( src ) === _.aux );
  test.true( _.container.namespaceForExporting( src ) === _.aux );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.aux );
  test.true( _.entity.namespaceOf( src ) === _.aux );
  test.true( _.entity.namespaceForIterating( src ) === _.aux );
  test.true( _.entity.namespaceForExporting( src ) === _.aux );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.aux );

  test.case = 'set';
  var src = new Set();
  test.true( _.container.namespaceOf( src ) === _.set );
  test.true( _.container.namespaceForIterating( src ) === _.set );
  test.true( _.container.namespaceForExporting( src ) === _.set );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.set );
  test.true( _.entity.namespaceOf( src ) === _.set );
  test.true( _.entity.namespaceForIterating( src ) === _.set );
  test.true( _.entity.namespaceForExporting( src ) === _.set );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.set );

  test.case = 'hashmap';
  var src = new HashMap();
  test.true( _.container.namespaceOf( src ) === _.hashMap );
  test.true( _.container.namespaceForIterating( src ) === _.hashMap );
  test.true( _.container.namespaceForExporting( src ) === _.hashMap );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.hashMap );
  test.true( _.entity.namespaceOf( src ) === _.hashMap );
  test.true( _.entity.namespaceForIterating( src ) === _.hashMap );
  test.true( _.entity.namespaceForExporting( src ) === _.hashMap );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.hashMap );

  test.case = 'array';
  var src = [];
  test.true( _.container.namespaceOf( src ) === _.long );
  test.true( _.container.namespaceForIterating( src ) === _.long );
  test.true( _.container.namespaceForExporting( src ) === _.long );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.long );
  test.true( _.entity.namespaceOf( src ) === _.long );
  test.true( _.entity.namespaceForIterating( src ) === _.long );
  test.true( _.entity.namespaceForExporting( src ) === _.long );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.long );

  test.case = 'typed buffer';
  var src = new F32x();
  test.true( _.container.namespaceOf( src ) === _.long );
  test.true( _.container.namespaceForIterating( src ) === _.long );
  test.true( _.container.namespaceForExporting( src ) === _.buffer );
  test.true( _.container.namespaceWithDefaultOf( src ) === _.long );
  test.true( _.entity.namespaceOf( src ) === _.long );
  test.true( _.entity.namespaceForIterating( src ) === _.long );
  test.true( _.entity.namespaceForExporting( src ) === _.buffer );
  test.true( _.entity.namespaceWithDefaultOf( src ) === _.long );

}

// --
// define test suite
// --

const Proto =
{

  name : 'Tools.Container.l0.l1',
  silencing : 1,

  tests :
  {

    // dichotomy

    dichotomy,
    instanceOfContainer,

    namespaceOf,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
