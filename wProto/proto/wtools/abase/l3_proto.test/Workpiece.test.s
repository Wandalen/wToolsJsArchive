( function _Workpiece_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );
  _.include( 'wEqualer' );

  require( '../../abase/l3_proto/Include.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// test
// --

function prototypeIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.workpiece.prototypeIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.workpiece.prototypeIsStandard( {} ) );

  t.will = 'primitive';
  t.true( !_.workpiece.prototypeIsStandard( 0 ) );
  t.true( !_.workpiece.prototypeIsStandard( 1 ) );
  t.true( !_.workpiece.prototypeIsStandard( '1' ) );
  t.true( !_.workpiece.prototypeIsStandard( null ) );
  t.true( !_.workpiece.prototypeIsStandard( undefined ) );

  t.will = 'routine';
  t.true( !_.workpiece.prototypeIsStandard( Date ) );
  t.true( !_.workpiece.prototypeIsStandard( F32x ) );
  t.true( !_.workpiece.prototypeIsStandard( function(){} ) );
  t.true( !_.workpiece.prototypeIsStandard( Self.constructor ) );

  t.will = 'object-like';
  t.true( !_.workpiece.prototypeIsStandard( [] ) );
  t.true( !_.workpiece.prototypeIsStandard( /x/ ) );
  t.true( !_.workpiece.prototypeIsStandard( new Date() ) );
  t.true( !_.workpiece.prototypeIsStandard( new F32x() ) );
  t.true( !_.workpiece.prototypeIsStandard( new (function(){})() ) );
  t.true( !_.workpiece.prototypeIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( [] ) ) );
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( new F32x() ) ) );
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( _.workpiece.prototypeIsStandard( Object.getPrototypeOf( Self ) ) );

}

//

function prototypeIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.workpiece.prototypeIs( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.workpiece.prototypeIs( {} ) );

  t.will = 'primitive';
  t.true( !_.workpiece.prototypeIs( 0 ) );
  t.true( !_.workpiece.prototypeIs( 1 ) );
  t.true( !_.workpiece.prototypeIs( '1' ) );
  t.true( !_.workpiece.prototypeIs( null ) );
  t.true( !_.workpiece.prototypeIs( undefined ) );

  t.will = 'routine';
  t.true( !_.workpiece.prototypeIs( Date ) );
  t.true( !_.workpiece.prototypeIs( F32x ) );
  t.true( !_.workpiece.prototypeIs( function(){} ) );
  t.true( !_.workpiece.prototypeIs( Self.constructor ) );

  t.will = 'object-like';
  t.true( !_.workpiece.prototypeIs( [] ) );
  t.true( !_.workpiece.prototypeIs( /x/ ) );
  t.true( !_.workpiece.prototypeIs( new Date() ) );
  t.true( !_.workpiece.prototypeIs( new F32x() ) );
  t.true( !_.workpiece.prototypeIs( new (function(){})() ) );
  t.true( !_.workpiece.prototypeIs( Self ) );

  t.will = 'object-like prototype';
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( [] ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( /x/ ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( new Date() ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( new F32x() ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( Self ) ) );

}

//

function instanceLikeStandard( test )
{
  test.case = 'check null';
  var got = _.workpiece.instanceLikeStandard( null );
  test.identical( got, false );

  test.case = 'check undefined';
  var got = _.workpiece.instanceLikeStandard( undefined );
  test.identical( got, false );

  test.case = 'check _.nothing';
  var got = _.workpiece.instanceLikeStandard( _.nothing );
  test.identical( got, false );

  test.case = 'check zero';
  var got = _.workpiece.instanceLikeStandard( 0 );
  test.identical( got, false );

  test.case = 'check empty string';
  var got = _.workpiece.instanceLikeStandard( '' );
  test.identical( got, false );

  test.case = 'check false';
  var got = _.workpiece.instanceLikeStandard( false );
  test.identical( got, false );

  test.case = 'check NaN';
  var got = _.workpiece.instanceLikeStandard( NaN );
  test.identical( got, false );

  test.case = 'check Symbol';
  var got = _.workpiece.instanceLikeStandard( Symbol( 'a' ) );
  test.identical( got, false );

  test.case = 'check empty array';
  var got = _.workpiece.instanceLikeStandard( [] );
  test.identical( got, false );

  test.case = 'check empty arguments array';
  var got = _.workpiece.instanceLikeStandard( _.argumentsArray.make( [] ) );
  test.identical( got, false );

  test.case = 'check empty unroll';
  var got = _.workpiece.instanceLikeStandard( _.unroll.make( [] ) );
  test.identical( got, false );

  test.case = 'check empty map';
  var got = _.workpiece.instanceLikeStandard( {} );
  test.identical( got, false );

  test.case = 'check empty pure map';
  var got = _.workpiece.instanceLikeStandard( Object.create( null ) );
  test.identical( got, false );

  test.case = 'check empty Set';
  var got = _.workpiece.instanceLikeStandard( new Set( [] ) );
  test.identical( got, false );

  test.case = 'check empty Map';
  var got = _.workpiece.instanceLikeStandard( new HashMap( [] ) );
  test.identical( got, false );

  test.case = 'check empty BufferRaw';
  var got = _.workpiece.instanceLikeStandard( new BufferRaw() );
  test.identical( got, false );

  test.case = 'check empty BufferTyped';
  var got = _.workpiece.instanceLikeStandard( new U8x() );
  test.identical( got, false );

  test.case = 'check number';
  var got = _.workpiece.instanceLikeStandard( 3 );
  test.identical( got, false );

  test.case = 'check bigInt';
  var got = _.workpiece.instanceLikeStandard( 1n );
  test.identical( got, false );

  test.case = 'check string';
  var got = _.workpiece.instanceLikeStandard( 'str' );
  test.identical( got, false );

  test.case = 'check not empty array';
  var got = _.workpiece.instanceLikeStandard( [ null ] );
  test.identical( got, false );

  test.case = 'check map with property constructor';
  var got = _.workpiece.instanceLikeStandard( { 'constructor' : 1 } );
  test.identical( got, false );

  test.case = 'check map with properties constructor and Composes';
  var got = _.workpiece.instanceLikeStandard( { 'constructor' : 1, 'Composes' : 1 } );
  test.identical( got, true );

  test.case = 'check pure map with property constructor';
  var src = Object.create( null );
  src.constructor = false;
  var got = _.workpiece.instanceLikeStandard( src );
  test.identical( got, false );

  test.case = 'check pure map with properties constructor and Composes';
  var src = Object.create( null );
  src.constructor = false;
  src.Composes = 1;
  var got = _.workpiece.instanceLikeStandard( src );
  test.identical( got, true );

  test.case = 'check instance of constructor with own properties constructor and Composes';
  function Constr1()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr1();
  src.constructor = true;
  src.Composes = true;
  var got = _.workpiece.instanceLikeStandard( src );
  test.identical( got, true );

  test.case = 'check constructor';
  function Constr2()
  {
    this.x = 1;
    return this;
  };
  var got = _.workpiece.instanceLikeStandard( Constr2 );
  test.identical( got, false );

  test.case = 'instance of Promise';
  var src = new Promise( ( resolve, reject ) => { return resolve( 0 ) } );
  var got = _.workpiece.instanceLikeStandard( src );
  test.identical( got, false );

  test.case = 'function _Promise';
  function Promise(){}
  var src = Promise;
  var got = _.workpiece.instanceLikeStandard( src );
  test.identical( got, false );
}

//

function instanceIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.workpiece.instanceIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.workpiece.instanceIsStandard( {} ) );

  t.will = 'primitive';
  t.true( !_.workpiece.instanceIsStandard( 0 ) );
  t.true( !_.workpiece.instanceIsStandard( 1 ) );
  t.true( !_.workpiece.instanceIsStandard( '1' ) );
  t.true( !_.workpiece.instanceIsStandard( null ) );
  t.true( !_.workpiece.instanceIsStandard( undefined ) );

  t.will = 'routine';
  t.true( !_.workpiece.instanceIsStandard( Date ) );
  t.true( !_.workpiece.instanceIsStandard( F32x ) );
  t.true( !_.workpiece.instanceIsStandard( function(){} ) );
  t.true( !_.workpiece.instanceIsStandard( Self.constructor ) );

  t.will = 'long';
  t.true( !_.workpiece.instanceIsStandard( [] ) );
  t.true( !_.workpiece.instanceIsStandard( new F32x() ) );

  t.will = 'object-like';
  t.true( !_.workpiece.instanceIsStandard( /x/ ) );
  t.true( !_.workpiece.instanceIsStandard( new Date() ) );
  t.true( !_.workpiece.instanceIsStandard( new (function(){})() ) );
  t.true( _.workpiece.instanceIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( [] ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( new F32x() ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( Self ) ) );

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l3.proto/Workpiece',
  silencing : 1,

  tests :
  {

    // dichotomy

    prototypeIs,
    prototypeIsStandard,

    // instance

    instanceIsStandard,
    instanceLikeStandard,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
