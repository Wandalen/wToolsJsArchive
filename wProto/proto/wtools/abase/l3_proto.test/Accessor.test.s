( function _Accessor_test_s_( ) {

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
// accessor
// --

function accessor( test )
{

  /* */

  test.case = 'setter';
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aSet : function( src )
      {
        this[ Symbol.for( 'a' ) ] = src * 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 10;
  test.identical( got, expected );

  /* */

  test.case = 'getter';
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] * 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 10;
  test.identical( got, expected );

  /* */

  test.case = 'getter & setter';
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aSet : function( src )
      {
        this[ Symbol.for( 'a' ) ] = src * 2;
      },
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] / 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 5;
  test.identical( got, expected );

  /* */

  test.case = 'has constructor only';
  var dst = { constructor : function(){}, };
  var exp = { 'constructor' : dst.constructor, 'a' : 'a1' };
  _.accessor.declare( dst, { a : 'a' } );
  dst[ Symbol.for( 'a' ) ] = 'a1';
  test.identical( dst, exp );

  /* */

  test.case = 'has Composes only';
  var dst = { Composes : {}, };
  var exp = { Composes : dst.Composes, 'a' : 'a1' };
  _.accessor.declare( dst, { a : 'a' } );
  dst[ Symbol.for( 'a' ) ] = 'a1';
  test.identical( dst, exp );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'empty call';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.declare( );
  });

  /* */

  test.case = 'invalid first argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.declare( 1, { a : 'a' } );
  });

  /* */

  test.case = 'invalid second argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.declare( {}, [] );
  });

}

// //
//
// function declareConstantWithDefinition( test )
// {
//
//   /* */
//
//   test.case = 'read only explicitly, get is definitition';
//
//   var dst =
//   {
//   };
//
//   var exp = { 'a' : 'a1' };
//   _.accessor.declare
//   ({
//     object : dst,
//     // names : { a : { writable : 0, get : _.define.constant( 'a1' ) } },
//     names : { a : { writable : 0, get : _.define.constant( 'a1' ) } },
//     prime : 0,
//   });
//   test.identical( dst, exp );
//   test.shouldThrowErrorSync( () => dst.a = 'a2' );
//
//   /* */
//
//   test.case = 'read only implicitly, value in descriptor';
//
//   var dst =
//   {
//   };
//
//   var exp = { 'a' : 'a1' }
//   _.accessor.declare
//   ({
//     object : dst,
//     names : { a : { set : false, get : _.define.constant( 'a1' ) } },
//     prime : 0,
//   });
//   test.identical( dst, exp );
//   test.shouldThrowErrorSync( () => dst.a = 'a2' );
//
//   /* */
//
//   test.case = 'read only implicitly, value instead of descriptor';
//
//   var dst =
//   {
//   };
//
//   var exp = { 'a' : 'a1' }
//   _.accessor.declare
//   ({
//     object : dst,
//     names : { a : _.define.constant( 'a1' ) },
//     prime : 0,
//   });
//   test.identical( dst, exp );
//   test.shouldThrowErrorSync( () => dst.a = 'a2' );
//
//   /* */
//
// }
//
// //
//
// function declareConstantSymbolWithDefinition( test )
// {
//
//   /* */
//
//   test.case = 'read only implicitly, value in descriptor';
//
//   var dst =
//   {
//   };
//
//   var exp = {}
//   _.accessor.declare
//   ({
//     object : dst,
//     names : { [ Symbol.for( 'a' ) ] : { set : false, get : _.define.constant( 'a1' ) } },
//     prime : 0,
//   });
//   test.identical( dst, exp );
//   test.identical( dst[ Symbol.for( 'a' ) ], 'a1' );
//   test.shouldThrowErrorSync( () => dst[ Symbol.for( 'a' ) ] = 'a2' );
//   var exp = { a : 'a3' };
//   dst.a = 'a3';
//   test.identical( dst, exp );
//   test.identical( dst[ Symbol.for( 'a' ) ], 'a1' );
//
//   /* */
//
//   test.case = 'read only implicitly, value instead of descriptor';
//
//   var dst =
//   {
//   };
//
//   var exp = {}
//   _.accessor.declare
//   ({
//     object : dst,
//     names : { [ Symbol.for( 'a' ) ] : _.define.constant( 'a1' ) },
//     prime : 0,
//   });
//   test.identical( dst, exp );
//   test.identical( dst[ Symbol.for( 'a' ) ], 'a1' );
//   test.shouldThrowErrorSync( () => dst[ Symbol.for( 'a' ) ] = 'a2' );
//   var exp = { a : 'a3' };
//   dst.a = 'a3';
//   test.identical( dst, exp );
//   test.identical( dst[ Symbol.for( 'a' ) ], 'a1' );
//
//   /* */
//
// }

//

function accessorOptionAddingMethods( test )
{

  /* */

  test.case = 'deduce setter from put, object does not have methods, with _, addingMethods:1';
  var methods =
  {
    _aGet : function() { return this.b },
    _aPut : function( src ) { this.b = src },
  }
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
  }
  _.accessor.declare
  ({
    object : dst,
    methods,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 0,
  });
  test.identical( dst, exp );

  /* */

  test.case = 'deduce setter from put, object has methods, addingMethods:0';
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGet : function() { return this.b },
    aPut : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aGet : dst.aGet,
    aPut : dst.aPut,
  }
  _.accessor.declare
  ({
    object : dst,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 0,
  });
  test.identical( dst, exp );

  /* */

  test.case = 'deduce setter from put, deduce get from grab, object has methods, addingMethods:1';
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGrab : function() { return this.b },
    aPut : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aGrab : dst.aGrab,
    aGet : dst.aGrab,
    aPut : dst.aPut,
    aSet : dst.aPut,
  }

  var declared = _.accessor.declare
  ({
    object : dst,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  test.identical( _.props.onlyOwn( dst, { onlyEnumerable : 0 } ), exp );
  test.true( _.routineIs( dst.aGrab ) );
  test.true( _.routineIs( dst.aGet ) );
  test.true( _.routineIs( dst.aPut ) );
  test.true( _.routineIs( dst.aSet ) );

  var exp =
  {
    'grab' : dst.aGrab,
    'get' : dst.aGet,
    'put' : dst.aPut,
    'set' : dst.aSet,
    'move' : false,
  }
  test.identical( declared.a.normalizedAsuite, exp );

  /* */

  test.case = 'deduce setter from put and get from grab, object has methods, with _, addingMethods:1';
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
    _aGrab : function() { return this.b },
    _aPut : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    _aGrab : dst._aGrab,
    aGet : dst._aGrab,
    _aPut : dst._aPut,
    aSet : dst._aPut,
  }
  var declared = _.accessor.declare
  ({
    object : dst,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  test.identical( _.props.onlyOwn( dst, { onlyEnumerable : 0 } ), exp );

  var exp =
  {
    'grab' : dst._aGrab,
    'get' : dst.aGet,
    'put' : dst._aPut,
    'set' : dst.aSet,
    'move' : false,
  }
  test.identical( declared.a.normalizedAsuite, exp );

  /* */

  test.case = 'deduce setter from put and get from grab, object does not have methods, with _, addingMethods:1';
  var methods =
  {
    _aGrab : function() { return this.b },
    _aPut : function( src ) { this.b = src },
  }
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aGrab : methods._aGrab,
    aGet : methods._aGrab,
    aSet : methods._aPut,
    aPut : methods._aPut,
  }
  var declared = _.accessor.declare
  ({
    object : dst,
    methods,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  test.identical( _.props.onlyOwn( dst, { onlyEnumerable : 0 } ), exp );

  var exp =
  {
    'grab' : dst.aGrab,
    'get' : dst.aGet,
    'put' : dst.aPut,
    'set' : dst.aSet,
    'move' : false,
  }
  test.identical( declared.a.normalizedAsuite, exp );

  /* */

}

//

function accessorIsClean( test )
{

  /* - */

  test.open( 'with class, readOnly:1' );

  test.case = 'setup';

  function BasicConstructor()
  {
    _.workpiece.initFields( this );
  }

  var Accessors =
  {
    f1 : { writable : 0 },
  }

  var Extension =
  {
    Accessors,
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extension,
  });

  var methods = Object.create( null );
  _.accessor.declare
  ({
    object : BasicConstructor.prototype,
    names : { f2 : { writable : 0 } },
    methods,
  });

  var instance = new BasicConstructor();

  test.case = 'methods';

  var exp =
  {
    // f2Grab : methods.f2Grab,
    // f2Get : methods.f2Get,
    // f2Put : methods.f2Put,
  }
  test.identical( methods, exp );
  // test.true( _.routineIs( methods.f2Get ) );
  // test.true( _.routineIs( methods.f2Put ) );
  // test.identical( _.props.keys( methods ).length, 3 );

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( BasicConstructor._f1Get, undefined );
  test.identical( BasicConstructor._f1Set, undefined );
  test.identical( BasicConstructor.prototype._f1Get, undefined );
  test.identical( BasicConstructor.prototype._f1Set, undefined );

  test.identical( instance._f2Get, undefined );
  test.identical( instance._f2Set, undefined );
  test.identical( BasicConstructor._f2Get, undefined );
  test.identical( BasicConstructor._f2Set, undefined );
  test.identical( BasicConstructor.prototype._f2Get, undefined );
  test.identical( BasicConstructor.prototype._f2Set, undefined );

  test.close( 'with class, readOnly:1' );

}

//

function accessorDeducingPrime( test )
{

  /* */

  test.case = '_.accessor.declare';

  var proto = Object.create( null );
  proto.a = 'a1';
  proto.abcGet = function()
  {
    return 'abc1';
  }

  var object = Object.create( proto );
  object.b = 'b2';

  var exp = { 'b' : 'b2', 'abc' : 'abc1' }
  var names = { abc : 'abc' }
  var o2 =
  {
    object : object,
    names : names,
  }
  _.accessor.declare( o2 );

  test.identical( o2.prime, null );
  test.identical( o2.strict, true );
  test.contains( object, exp );

  /* */

  test.case = '_.accessor.readOnly';

  var proto = Object.create( null );
  proto.a = 'a1';
  proto.abcGet = function()
  {
    return 'abc1';
  }

  var object = Object.create( proto );
  object.b = 'b2';

  var exp = { 'b' : 'b2', 'abc' : 'abc1' }
  var names = { abc : 'abc' }
  var o2 =
  {
    object : object,
    names : names,
  }
  _.accessor.readOnly( o2 );

  test.identical( o2.prime, null );
  test.identical( o2.strict, true );
  test.contains( object, exp );

  /* */

  test.case = '_.accessor.forbid';

  var proto = Object.create( null );
  proto.a = 'a1';
  proto.abcGet = function()
  {
    return 'abc1';
  }

  var object = Object.create( proto );
  object.b = 'b2';

  var exp = { 'b' : 'b2' }
  var names = { abc : 'abc' }
  var o2 =
  {
    object : object,
    names : names,
  }
  _.accessor.forbid( o2 );

  test.identical( o2.prime, 0 );
  test.identical( o2.strict, 0 );
  test.contains( object, exp );
  test.shouldThrowErrorSync( () => dst.abc );

  /* */

}

//

function accessorReadOnly( test )
{
  test.case = 'readOnly';

  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend : { Composes : { a : null } }
  });
  _.accessor.readOnly( Alpha.prototype,{ a : 'a' });
  var x = new Alpha();
  test.shouldThrowErrorSync( () => x.a = 1 );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha.prototype, 'a' );
  var got = descriptor.set ? true : false;
  var expected = false;
  test.identical( got, expected );

  test.case = 'saves field value';
  var Alpha = function _Alpha( a )
  {
    this[ Symbol.for( 'a' ) ] = a;
  }
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend : { Composes : { a : 6 } }
  });
  _.accessor.readOnly( Alpha.prototype, { a : 'a' } );
  var x = new Alpha( 5 );
  test.shouldThrowErrorSync( () => x.a = 1 );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha.prototype, 'a' );
  var got = !descriptor.set && x.a === 5;
  var expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'readonly';
  test.shouldThrowErrorSync( function()
  {
    var Alpha = { };
    _.accessor.readOnly( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.case = 'setter defined';
  test.shouldThrowErrorSync( function()
  {
    var Alpha = { _aSet : function() { } };
    _.accessor.readOnly( Alpha, { a : 'a' } );
  });

  test.case = 'empty call';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.readOnly( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.readOnly( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.readOnly( {}, [] );
  });

}

//

function forbids( test )
{

  test.open( 'pure map' );

  test.case = 'setup';

  var Forbids =
  {
    f1 : 'f1',
  }

  var instance = Object.create( null );

  _.accessor.forbid( instance, Forbids );

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( _.props.of( instance ), Object.create( null ) );

  test.case = 'throwing';

  if( Config.debug )
  {
    test.shouldThrowErrorSync( () => instance.f1 );
  }

  test.close( 'pure map' );

  /* - */

  test.open( 'with class' );

  test.case = 'setup';

  function BasicConstructor()
  {
    _.workpiece.initFields( this );
  }

  var Forbids =
  {
    f1 : 'f1',
  }

  var Extension =
  {
    Forbids,
  }

  // Extension.constructor = BasicConstructor;

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extension,
  });

  var instance = new BasicConstructor();

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( BasicConstructor._f1Get, undefined );
  test.identical( BasicConstructor._f1Set, undefined );
  test.identical( BasicConstructor.prototype._f1Get, undefined );
  test.identical( BasicConstructor.prototype._f1Set, undefined );

  test.case = 'throwing';

  if( Config.debug )
  {
    test.shouldThrowErrorSync( () => instance.f1 );
    test.shouldThrowErrorSync( () => BasicConstructor.prototype.f1 );
  }

  test.close( 'with class' );

}

// forbids.timeOut = 300000;

//

function getterWithSymbol( test )
{

  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : _.accessor.getter.withSymbol, set : false, put : false },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    // 'aGrab' : object.aGrab,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'aSet' : object.aSet,
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
    //   '_Grab' : undefined,
    //   '_Get' : undefined,
      '_' : undefined,
    //   'aGrab' : undefined,
    //   'aGet' : undefined,
    //   'aSet' : undefined,
    //   'aPut' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );

}

//

function getterToValueDefine( test )
{

  /* */

  test.case = 'configurable : 1, set : 0, put : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : _.accessor.getter.toValue, set : false, put : false, configurable : true },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    // 'aGrab' : object.aGrab,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'aSet' : object.aSet,
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      // '_Grab' : undefined,
      // '_Get' : undefined,
      // 'aGrab' : undefined,
      // 'aGet' : undefined,
      // 'aPut' : undefined,
      // 'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'configurable : 0, set : 0, put : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : _.accessor.getter.toValue, set : false, put : false, configurable : false },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : undefined,
    'enumerable' : true,
    'configurable' : false,
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    // 'aGrab' : object.aGrab,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'aSet' : object.aSet,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      // '_Grab' : undefined,
      // '_Get' : undefined,
      // 'aGrab' : undefined,
      // 'aGet' : undefined,
      // 'aPut' : undefined,
      // 'aSet' : undefined,
      '_' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp =
  {
    'get' : object._Get,
    'set' : undefined,
    'enumerable' : true,
    'configurable' : false,
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'configurable : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : _.accessor.getter.toValue },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true,
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    // 'aGrab' : object.aGrab,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'aSet' : object.aSet,
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    // '_Put' : object._Put,
    // '_Set' : object._Set,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      // '_Grab' : undefined,
      // '_Get' : undefined,
      // '_Put' : undefined,
      // '_Set' : undefined,
      // 'aGrab' : undefined,
      // 'aGet' : undefined,
      // 'aPut' : undefined,
      // 'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false };
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'suite';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : _.accessor.suite.toValue,
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    // 'aGrab' : object.aGrab,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'aSet' : object.aSet,
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    // '_Put' : object._Put,
    // '_Set' : object._Set,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      // '_Grab' : undefined,
      // '_Get' : undefined,
      // '_Put' : undefined,
      // '_Set' : undefined,
      // 'aGrab' : undefined,
      // 'aGet' : undefined,
      // 'aPut' : undefined,
      // 'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false };
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'suite in fields';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    // 'aGrab' : object.aGrab,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'aSet' : object.aSet,
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    // '_Put' : object._Put,
    // '_Set' : object._Set,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      // '_Grab' : undefined,
      // '_Get' : undefined,
      // '_Put' : undefined,
      // '_Set' : undefined,
      // 'aGrab' : undefined,
      // 'aGet' : undefined,
      // 'aPut' : undefined,
      // 'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false };
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'suite in fields, explicit configurable';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue, configurable : false },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : false
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    // 'aGrab' : object.aGrab,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'aSet' : object.aSet,
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    // '_Put' : object._Put,
    // '_Set' : object._Set,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      '_' : undefined,
      // '_Grab' : undefined,
      // '_Get' : undefined,
      // '_Put' : undefined,
      // '_Set' : undefined,
      // 'aGrab' : undefined,
      // 'aGet' : undefined,
      // 'aPut' : undefined,
      // 'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : false
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

}

//

function getterToValueAccess( test )
{

  /* */

  test.case = 'had value, addingMethods : 1';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    'c' : 'c1',
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
    b : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );

  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'c' : 'c1',
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    // '_Put' : object._Put,
    // '_Set' : object._Set,
    // 'aGrab' : object.aGrab,
    // 'aSet' : object.aSet,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'bGrab' : object.bGrab,
    // 'bSet' : object.bSet,
    // 'bGet' : object.bGet,
    // 'bPut' : object.bPut,
    '_' :
    {
      'a' : 'a1',
      'b' : 'b1',
      'c' : undefined,
      // '_Grab' : undefined,
      // '_Get' : undefined,
      // '_Put' : undefined,
      // '_Set' : undefined,
      // 'aGrab' : undefined,
      // 'aSet' : undefined,
      // 'aGet' : undefined,
      // 'aPut' : undefined,
      // 'bGrab' : undefined,
      // 'bSet' : undefined,
      // 'bGet' : undefined,
      // 'bPut' : undefined,
    }
  }
  test.identical( object, exp );

  var exp =
  {
    'enumerable' : false,
    'configurable' : false,
    'writable' : false,
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  test.identical( object.a, 'a1' );
  test.identical( object._.a, 'a1' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object._.a = 'a2';
  test.identical( object.a, 'a2' );
  test.identical( object._.a, 'a2' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.a = 'a3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.b = 'b2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b2' );
  test.identical( object._.b, 'b2' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object._.b = 'b3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.c = 'c2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, undefined );

  object._.c = 'c3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, 'c3' );

  /* */

  test.case = 'had value, addingMethods : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    'c' : 'c1',
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
    b : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 0,
  });
  var exp =
  {
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value', 'set', 'get' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'c' : 'c1',
    '_' :
    {
      'a' : 'a1',
      'b' : 'b1',
      'c' : undefined,
    }
  }

  test.identical( object, exp );
  var exp =
  {
    'enumerable' : false,
    'configurable' : false,
    'writable' : false,
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  test.identical( object.a, 'a1' );
  test.identical( object._.a, 'a1' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object._.a = 'a2';
  test.identical( object.a, 'a2' );
  test.identical( object._.a, 'a2' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.a = 'a3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.b = 'b2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b2' );
  test.identical( object._.b, 'b2' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object._.b = 'b3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.c = 'c2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, undefined );

  object._.c = 'c3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, 'c3' );

  /* */

  test.case = 'had no value, addingMethods : 1';
  var object =
  {
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
    b : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );

  var exp =
  {
    'a' : undefined,
    'b' : undefined,
    // '_Grab' : object._Grab,
    // '_Get' : object._Get,
    // '_Put' : object._Put,
    // '_Set' : object._Set,
    // 'aGrab' : object.aGrab,
    // 'aSet' : object.aSet,
    // 'aGet' : object.aGet,
    // 'aPut' : object.aPut,
    // 'bGrab' : object.bGrab,
    // 'bSet' : object.bSet,
    // 'bGet' : object.bGet,
    // 'bPut' : object.bPut,
    '_' :
    {
      'a' : undefined,
      'b' : undefined,
      // '_Grab' : undefined,
      // '_Get' : undefined,
      // '_Put' : undefined,
      // '_Set' : undefined,
      // 'aGrab' : undefined,
      // 'aSet' : undefined,
      // 'aGet' : undefined,
      // 'aPut' : undefined,
      // 'bGrab' : undefined,
      // 'bSet' : undefined,
      // 'bGet' : undefined,
      // 'bPut' : undefined,
    }
  }
  test.identical( object, exp );
  var exp =
  {
    'enumerable' : false,
    'configurable' : false,
    'writable' : false,
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  test.identical( object.a, undefined );
  test.identical( object._.a, undefined );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object._.a = 'a2';
  test.identical( object.a, 'a2' );
  test.identical( object._.a, 'a2' );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.a = 'a3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.b = 'b2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b2' );
  test.identical( object._.b, 'b2' );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object._.b = 'b3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.c = 'c2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, undefined );

  object._.c = 'c3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, 'c3' );

  /**/

  test.case = 'had no value, addingMethods : 0';
  var object =
  {
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
    b : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 0,
  });
  var exp =
  {
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value', 'get', 'set' ] ), exp );
  var exp =
  {
    'a' : undefined,
    'b' : undefined,
    '_' :
    {
      'a' : undefined,
      'b' : undefined,
    }
  }
  test.identical( object, exp );
  var exp =
  {
    'enumerable' : false,
    'configurable' : false,
    'writable' : false,
  }
  test.identical( _.mapBut_( null, _.props.descriptorOf( object, '_' ).descriptor, [ 'value' ] ), exp );
  test.identical( object.a, undefined );
  test.identical( object._.a, undefined );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object._.a = 'a2';
  test.identical( object.a, 'a2' );
  test.identical( object._.a, 'a2' );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.a = 'a3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.b = 'b2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b2' );
  test.identical( object._.b, 'b2' );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object._.b = 'b3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.c = 'c2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, undefined );

  object._.c = 'c3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, 'c3' );

  /* */

}

//

function putterSymbol( test )
{

  /* */

  test.case = 'addingMethods : 1';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aPut : _.accessor.putter.symbol,
    aSet : function( src ) { this[ Symbol.for( 'a' ) ] = src; this.b = src },
    aGet : function() { return this[ Symbol.for( 'a' ) ] },
  };
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    // aGrab : object.aGrab,
    // aGet : object.aGet,
    // aPut : object.aPut,
    // aSet : object.aSet,
  }
  test.identical( object, exp );
  test.true( object.aPut !== _.accessor.putter.symbol );

  object.aPut( 'c' );
  var exp =
  {
    'a' : 'c',
    'b' : 'b1',
    // aGrab : object.aGrab,
    // aGet : object.aGet,
    // aPut : object.aPut,
    // aSet : object.aSet,
  }
  test.identical( object, exp );

  object.aSet( 'd' );
  var exp =
  {
    'a' : 'd',
    'b' : 'd',
    // aGrab : object.aGrab,
    // aGet : object.aGet,
    // aPut : object.aPut,
    // aSet : object.aSet,
  }
  test.identical( object, exp );

  object.a = 'e';
  var exp =
  {
    'a' : 'e',
    'b' : 'e',
    // aGrab : object.aGrab,
    // aGet : object.aGet,
    // aPut : object.aPut,
    // aSet : object.aSet,
  }
  test.identical( object, exp );

  /* */

}

//

function classDeclare( test )
{
  let context = this;

  /* */

  test.case = 'first classDeclare';

  function C1()
  {
    this.Instances.push( this );
  }
  var Statics1 =
  {
    Instances : [],
    f1 : [],
    f2 : [],
    f3 : [],
  }
  var Extend1 =
  {
    Statics : Statics1,
    f1 : [],
    f2 : [],
    f4 : [],
  }
  var classMade = _.classDeclare
  ({
    cls : C1,
    parent : null,
    extend : Extend1,
  });

  test.identical( C1, classMade );
  test.true( C1.Instances === Statics1.Instances );

  test1({ Class : C1 });
  testFields( Statics1.f3 );

  /* */

  test.case = 'classDeclare with parent';

  function C2()
  {
    C1.call( this );
  }
  var classMade = _.classDeclare
  ({
    cls : C2,
    parent : C1,
  });

  test.identical( C2, classMade );

  test1({ Class : C1, Statics : Statics1 });

  test.true( C1.Instances === Statics1.Instances );
  test.true( C2.Instances === C1.Instances );

  test1({ Class : C2, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.case = 'classDeclare with supplement';

  function Csupplement()
  {
    C1.call( this );
  }
  var Statics2 =
  {
    Instances : [],
  }
  var classMade = _.classDeclare
  ({
    cls : Csupplement,
    parent : C1,
    supplement : { Statics : Statics2 },
  });

  test.identical( Csupplement,classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1({ Class : Csupplement, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.case = 'classDeclare with extend';

  function C3()
  {
    C1.call( this );
  }
  var Associates =
  {
  }
  var Statics2 =
  {
    Instances : [],
    f1 : [],
    f4 : [],
  }
  var Extend2 =
  {
    Statics : Statics2,
    Associates,
    f2 : [],
    f3 : [],
  }
  var classMade = _.classDeclare
  ({
    cls : C3,
    parent : C1,
    extend : Extend2,
    allowingExtendStatics : 1,
  });

  test.identical( C3, classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1
  ({
    Class : C3,
    Class0 : C1,
    Statics : Statics2,
    Extension : Extend2,
    keys : [ 'Instances', 'f1', 'f4', 'f2', 'f3' ],
    vals : [ C3.Instances, C3.f1, C3.f4, C1.f2, C1.f3 ],
  });

  testFields( Extend2.f3 );
  testFields2();

  if( !Config.debug )
  return;

  test.case = 'attempt to extend statics without order';

  test.shouldThrowErrorSync( function()
  {

    function C3()
    {
      C1.call( this );
    }
    var Associates =
    {
    }
    var Statics2 =
    {
      Instances : [],
      f1 : [],
      f4 : [],
    }
    var Extend2 =
    {
      Statics : Statics2,
      Associates,
      f2 : [],
      f3 : [],
    }
    var classMade = _.classDeclare
    ({
      cls : C3,
      parent : C1,
      extend : Extend2,
    });

  });

  /* */

  function test1( o )
  {

    if( o.ownStatics === undefined )
    o.ownStatics = 1;

    if( !o.Statics )
    o.Statics = Statics1;

    if( !o.Extension )
    o.Extension = Extend1;

    if( !o.keys )
    o.keys = _.props.keys( o.Statics );

    if( !o.vals )
    o.vals = _.props.vals( o.Statics );

    var C0proto = null;
    if( !o.Class0 )
    {
      o.Class0 = Function.prototype;
    }
    else
    {
      C0proto = o.Class0.prototype;
    }

    test.case = 'presence of valid prototype and constructor fields on class and prototype';

    test.identical( o.Class, o.Class.prototype.constructor );
    test.identical( Object.getPrototypeOf( o.Class ), o.Class0 );
    test.identical( Object.getPrototypeOf( o.Class.prototype ), C0proto );

    test.case = 'presence of valid static field on class and prototype';

    test.identical( o.Class.Instances, o.Class.prototype.Instances );

    test.case = 'getting property descriptor of static field from constructor';

    var cd = Object.getOwnPropertyDescriptor( o.Class, 'Instances' );
    if( !o.ownStatics )
    {
      test.identical( cd, undefined );
    }
    else
    {
      test.identical( cd.configurable, true );
      test.identical( cd.enumerable, true );
      test.true( !!cd.get );
      test.true( !!cd.set );
    }

    var pd = Object.getOwnPropertyDescriptor( o.Class.prototype, 'Instances' );

    if( !o.ownStatics )
    {
      test.identical( pd, undefined );
    }
    else
    {
      test.identical( pd.configurable, true );
      test.identical( pd.enumerable, false );
      test.true( !!pd.get );
      test.true( !!pd.set );
    }

    test.case = 'making the first instance';

    var c1a = new o.Class();

    test.case = 'presence of valid static field on all';

    if( o.Class !== C1 && !o.ownStatics )
    test.true( o.Class.Instances === C1.Instances );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === o.Statics.Instances );
    test.identical( o.Class.Instances.length, o.Statics.Instances.length );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-1 ], c1a );

    test.case = 'presence of valid prototype and constructor fields on instance';

    test.identical( Object.getPrototypeOf( c1a ), o.Class.prototype );
    test.identical( c1a.constructor, o.Class );

    test.case = 'presence of valid Statics descriptor';

    test.true( o.Statics !== o.Class.prototype.Statics );
    test.true( o.Statics !== c1a.Statics );

    test.identical( _.props.keys( c1a.Statics ), o.keys );
    test.identical( _.props.vals( c1a.Statics ), o.vals );
    test.identical( o.Class.Statics, undefined );

    if( !C0proto )
    {
      var r = _.entityIdentical( o.Class.prototype.Statics, o.Statics );
      test.identical( o.Class.prototype.Statics, o.Statics );
      test.identical( c1a.Statics, o.Statics );
    }

    test.case = 'presence of conflicting fields';

    test.true( o.Class.prototype.f1 === c1a.f1 );
    test.true( o.Class.prototype.f2 === c1a.f2 );
    test.true( o.Class.prototype.f3 === c1a.f3 );
    test.true( o.Class.prototype.f4 === c1a.f4 );

    test.case = 'making the second instance';

    var c1b = new o.Class();
    test.identical( o.Class.Instances, o.Class.prototype.Instances );
    test.identical( o.Class.Instances, c1a.Instances );
    test.identical( o.Class.Instances.length, o.Statics.Instances.length );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-2 ], c1a );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-1 ], c1b );

    test.case = 'setting static field with constructor';

    o.Class.Instances = o.Class.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOnlyOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

    test.case = 'setting static field with prototype';

    o.Class.prototype.Instances = o.Class.prototype.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOnlyOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

    test.case = 'setting static field with instance';

    c1a.Instances = o.Class.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOnlyOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

  }

  /* */

  function testFields( f3 )
  {

    test.case = 'presence of conflicting fields in the first class';

    test.true( Statics1.f1 === C1.f1 );
    test.true( Extend1.f1 === C1.prototype.f1 );

    test.true( Statics1.f2 === C1.f2 );
    test.true( Extend1.f2 === C1.prototype.f2 );

    test.true( f3 === C1.f3 );
    test.true( f3 === C1.prototype.f3 );

    test.true( Statics1.f4 === undefined );
    test.true( Statics1.f4 === C1.f4 );
    test.true( Extend1.f4 === C1.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C1,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f3' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f3' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1,'f4' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f4' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

  }

  /* */

  function testFields2()
  {

    test.case = 'presence of conflicting fields in the second class';

    test.true( Statics2.f1 === C3.f1 );
    test.true( Statics2.f1 === C3.prototype.f1 );

    test.true( Statics1.f2 === C3.f2 );
    test.true( Extend2.f2 === C3.prototype.f2 );

    test.true( Extend2.f3 === C3.f3 );
    test.true( Extend2.f3 === C3.prototype.f3 );

    test.true( Statics2.f4 === C3.f4 );
    test.true( Statics2.f4 === C3.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C3,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f1' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3,'f2' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C3,'f3' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f3' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3,'f4' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f4' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    test.case = 'assigning static fields';

    C1.f1 = 1;
    C1.f2 = 2;
    C1.f3 = 3;
    C1.f4 = 4;

    C1.prototype.f1 = 11;
    C1.prototype.f2 = 12;
    C1.prototype.f3 = 13;
    C1.prototype.f4 = 14;

    C2.f1 = 21;
    C2.f2 = 22;
    C2.f3 = 23;
    C2.f4 = 24;

    C2.prototype.f1 = 31;
    C2.prototype.f2 = 32;
    C2.prototype.f3 = 33;
    C2.prototype.f4 = 34;

    test.identical( C1.f1,1 );
    test.identical( C1.f2,2 );
    test.identical( C1.f3,33 );
    test.identical( C1.f4,4 );

    test.identical( C1.prototype.f1,11 );
    test.identical( C1.prototype.f2,12 );
    test.identical( C1.prototype.f3,33 );
    test.identical( C1.prototype.f4,14 );

    test.identical( C2.f1,21 );
    test.identical( C2.f2,22 );
    test.identical( C2.f3,33 );
    test.identical( C2.f4,24 );

    test.identical( C2.prototype.f1,31 );
    test.identical( C2.prototype.f2,32 );
    test.identical( C2.prototype.f3,33 );
    test.identical( C2.prototype.f4,34 );

  }

}

//

function accessorSupplement( test )
{
  test.case = 'supplement Beta with accessor "a" declared on Alpha'
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      Composes : {},
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );

  var Beta = function _Beta(){}
  _.classDeclare
  ({
    cls : Beta,
    parent : null,
    extend :
    {
      Accessors : {}
    }
  });
  _.accessor.supplement( Beta.prototype,Alpha.prototype );

  var x = new Beta();
  x.a = 2;
  test.identical( x.a, 2 );

  test.case = 'supplement Beta with accessor "a" declared on Alpha, Beta has accessor "b"'
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      Composes : {},
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );

  var Beta = function _Beta(){}
  _.classDeclare
  ({
    cls : Beta,
    parent : null,
    extend :
    {
      Accessors : {}
    }
  });
  _.accessor.declare( Beta.prototype, { b : 'b' } );

  _.accessor.supplement( Beta.prototype,Alpha.prototype );

  var x = new Beta();
  x.a = 2;
  x.b = 4;
  test.identical( x.a, 2 );
  test.identical( x.b, 4 );

  /* */

  test.case = 'supplement Beta with accessors of Alpha, both have same accessor'
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      Composes : {},
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );

  var Beta = function _Beta(){}
  _.classDeclare
  ({
    cls : Beta,
    parent : null,
    extend :
    {
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] * 2;
      },
      Accessors : {}
    }
  });
  _.accessor.declare( Beta.prototype, { a : 'a' } );

  _.accessor.supplement( Beta.prototype,Alpha.prototype );

  var x = new Beta();
  x.a = 2;
  test.identical( x.a, 4 );

  /* */

  test.case = 'Alpha: a, b - getter, c - setter, Beta: a - getter'
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _bGet : function()
      {
        return this[ Symbol.for( 'b' ) ] * 2;
      },
      _cSet : function( src )
      {
        this[ Symbol.for( 'c' ) ] = src * 2;
      },
      Composes : {},
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  _.accessor.declare( Alpha.prototype, { b : 'b' } );
  _.accessor.declare( Alpha.prototype, { c : 'c' } );

  var Beta = function _Beta(){}
  _.classDeclare
  ({
    cls : Beta,
    parent : null,
    extend :
    {
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] * 2;
      },
      Accessors : {}
    }
  });

  _.accessor.declare( Beta.prototype, { a : 'a' } );
  _.accessor.supplement( Beta.prototype,Alpha.prototype );

  var x = new Beta();
  x.a = 2;
  x.b = 3;
  x.c = 4;
  test.identical( x[ Symbol.for( 'a' ) ], 2 );
  test.identical( x[ Symbol.for( 'b' ) ], 3 );
  test.identical( x[ Symbol.for( 'c' ) ], 8 );
  test.identical( x.a, 4 );
  test.identical( x.b, 6 );
  test.identical( x.c, 8 );

}

// --
//
// --

function callable( test )
{

  class Cls extends _.CallableObject
  {
    constructor()
    {
      let self = super();
      self.x = 1;
      return self;
    }
    __call__( y )
    {
      return this.x+y;
    }
  }

  var ins = new Cls;
  var got = ins( 5 );
  test.identical( got, 6 );
  var got = ins.x;
  test.identical( got, 1 );

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l3.proto.Accessor',
  silencing : 1,

  tests :
  {

    //

    accessor,
    // declareConstantWithDefinition,
    // declareConstantSymbolWithDefinition,
    accessorIsClean,
    accessorDeducingPrime,
    accessorReadOnly,
    forbids,

    getterWithSymbol,
    getterToValueDefine,
    getterToValueAccess,
    putterSymbol,

    accessorSupplement,

    // etc

    callable,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
