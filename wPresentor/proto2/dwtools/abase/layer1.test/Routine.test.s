( function _Routine_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );

}
var _global = _global_;
var _ = _global_.wTools;

//

function testFunction1( x, y )
{
  return x + y
}

function testFunction2( x, y )
{
  return this;
}

function testFunction3( x, y )
{
  return x + y + this.k;
}

function testFunction4( x, y )
{
  return this;
}

function contextConstructor3()
{
  this.k = 15
}

var context3 = new contextConstructor3();

//

function _routineJoin( test )
{

  var testParam1 = 2,
    testParam2 = 4,
    options1 =
    {
      seal : false,
      routine : testFunction1,
      args : [ testParam2 ] // x
    },
    options2 =
    {
      seal : true,
      routine : testFunction2,
      args : [ testParam2 ] // x
    },

    options3 =
    {
      seal : false,
      routine : testFunction3,
      args : [ testParam2 ], // x
      context : context3
    },
    options4 =
    {
      seal : false,
      routine : testFunction4,
      args : [ testParam2 ], // x
      context : context3
    },

    options5 =
    {
      seal : true,
      routine : testFunction3,
      args : [ testParam1, testParam2 ], // x
      context : context3
    },

    wrongOpt1 = {
      seal : true,
      routine : {},
      args : [ testParam1, testParam2 ], // x
      context : context3
    },

    wrongOpt2 = {
      seal : true,
      routine : testFunction3,
      args : 'wrong', // x
      context : context3
    },

    expected1 = 6,
    expected2 = undefined,
    expected3 = 21,
    expected5 = 21;

  test.case = 'simple function without context with arguments bind without seal : result check';
  var gotfn = _._routineJoin( options1 );
  var got = gotfn( testParam1 );
  test.identical( got,expected1 );

  test.case = 'simple function without context and seal : context test';
  var gotfn = _._routineJoin(options2);
  var got = gotfn( testParam1 );
  test.identical( got, expected2 );

  test.case = 'simple function with context and arguments : result check';
  var gotfn = _._routineJoin(options3);
  var got = gotfn( testParam1 );
  test.identical( got, expected3 );

  test.case = 'simple function with context and arguments : context check';
  var gotfn = _._routineJoin(options4);
  var got = gotfn( testParam1 );
  test.identical( got instanceof contextConstructor3, true );

  test.case = 'simple function with context and arguments : result check, seal == true ';
  var gotfn = _._routineJoin(options5);
  var got = gotfn( testParam1 );
  test.identical( got, expected5 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'missed argument';
  test.shouldThrowError( function()
  {
    _._routineJoin();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _._routineJoin( options1, options2 );
  });

  test.case = 'passed non callable object';
  test.shouldThrowError( function()
  {
    _._routineJoin( wrongOpt1 );
  });

  test.case = 'passed arguments as primitive value';
  test.shouldThrowError( function()
  {
    _._routineJoin( wrongOpt2 );
  });

};

//
//
// function routineBind( test )
// {
//
//   var testParam1 = 2,
//     testParam2 = 4,
//     expected1 = 6,
//     expected2 = undefined,
//     expected3 = 21;
//
//   test.case = 'simple function without context with arguments bind : result check';
//   var gotfn = _.routineBind( testFunction1, undefined, [ testParam2 ]);
//   var got = gotfn( testParam1 );
//   test.identical( got,expected1 );
//
//   test.case = 'simple function without context : context test';
//   var gotfn = _.routineBind(testFunction2, undefined, [ testParam2 ]);
//   var got = gotfn( testParam1 );
//   test.identical( got, expected2 );
//
//   test.case = 'simple function with context and arguments : result check';
//   var gotfn = _.routineBind(testFunction3, context3, [ testParam2 ]);
//   var got = gotfn( testParam1 );
//   test.identical( got, expected3 );
//
//   test.case = 'simple function with context and arguments : context check';
//   var gotfn = _.routineBind(testFunction4, context3, [ testParam2 ]);
//   var got = gotfn( testParam1 );
//   test.identical( got instanceof contextConstructor3, true );
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'missed argument';
//   test.shouldThrowError( function()
//   {
//     _.routineBind();
//   });
//
//   test.case = 'extra argument';
//   test.shouldThrowError( function()
//   {
//     _.routineBind( testFunction4, context3, [ testParam2 ], [ testParam1 ] );
//   });
//
//   test.case = 'passed non callable object';
//   test.shouldThrowError( function()
//   {
//     _.routineBind( {}, context3, [ testParam2 ] );
//   });
//
//   test.case = 'passed arguments as primitive value';
//   test.shouldThrowError( function()
//   {
//     _.routineBind( testFunction4, context3, testParam2 );
//   });
//
// };

//

function routineJoin( test )
{

  var testParam1 = 2,
    testParam2 = 4,
    expected1 = 6,
    expected2 = undefined,
    expected3 = 21;

  test.case = 'simple function without context with arguments bind : result check';
  var gotfn = _.routineJoin( undefined, testFunction1, [ testParam2 ]);
  var got = gotfn( testParam1 );
  test.identical( got,expected1 );

  test.case = 'simple function without context : context test';
  var gotfn = _.routineJoin(undefined, testFunction2, [ testParam2 ]);
  var got = gotfn( testParam1 );
  test.identical( got, expected2 );

  test.case = 'simple function with context and arguments : result check';
  var gotfn = _.routineJoin(context3, testFunction3, [ testParam2 ]);
  var got = gotfn( testParam1 );
  test.identical( got, expected3 );

  test.case = 'simple function with context and arguments : context check';
  var gotfn = _.routineJoin(context3, testFunction4, [ testParam2 ]);
  var got = gotfn( testParam1 );
  test.identical( got instanceof contextConstructor3, true );

  if( !Config.debug )
  return;

  test.case = 'missed argument';
  test.shouldThrowError( function()
  {
    _.routineJoin();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.routineJoin( context3, testFunction4, [ testParam2 ], [ testParam1 ] );
  });

  test.case = 'passed non callable object';
  test.shouldThrowError( function()
  {
    _.routineJoin( context3, {}, [ testParam2 ] );
  });

  test.case = 'passed arguments as primitive value';
  test.shouldThrowError( function()
  {
    _.routineJoin( context3, testFunction4, testParam2 );
  });

}

//

function routineSeal(test)
{

  var testParam1 = 2,
    testParam2 = 4,
    expected1 = 6,
    expected2 = undefined,
    expected3 = 21;

  test.case = 'simple function with seal arguments : result check';
  var gotfn = _.routineSeal(undefined, testFunction1, [testParam1, testParam2]);
  var got = gotfn( testParam1 );
  test.identical( got, expected1 );

  test.case = 'simple function with seal arguments : context check';
  var gotfn = _.routineSeal(undefined, testFunction2, [testParam1, testParam2]);
  var got = gotfn( testParam1 );
  test.identical( got, expected2 );

  test.case = 'simple function with seal context and arguments : result check';
  var gotfn = _.routineSeal(context3, testFunction3, [testParam1, testParam2]);
  var got = gotfn( testParam1 );
  test.identical( got, expected3 );

  test.case = 'simple function with seal context and arguments : context check';
  var gotfn = _.routineSeal(context3, testFunction4, [testParam1, testParam2]);
  var got = gotfn( testParam1 );
  test.identical( got instanceof contextConstructor3, true );

  if( !Config.debug )
  return;

  test.case = 'missed argument';
  test.shouldThrowError( function()
  {
    _.routineSeal();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.routineSeal( context3, testFunction4, [ testParam2 ], [ testParam1 ] );
  });

  test.case = 'passed non callable object';
  test.shouldThrowError( function()
  {
    _.routineSeal( context3, {}, [ testParam1, testParam2 ] );
  });

  test.case = 'passed arguments as primitive value';
  test.shouldThrowError( function()
  {
    _.routineSeal( context3, testFunction4, testParam2 );
  });

}

//

function routinesCall( test )
{

  var value1 = 'result1';
  var value2 = 4;
  var value3 = 5;

  function function1()
  {
    return value1;
  }

  function function2()
  {
    return value2;
  }

  function function3()
  {
    return value3;
  }

  function function5(x, y)
  {
    return x + y * this.k;
  }

  var function4 = testFunction3
  var function6 = testFunction4;

  var expected1 = [ value1 ],
    expected2 = [ value2 + value3 + context3.k ],
    expected3 = [ value1, value2, value3 ],
    expected4 =
    [
      value2 + value3 + context3.k,
      value2 + value3 * context3.k,
      context3
    ];

  test.case = 'call single function without arguments and context';
  debugger;
  var got = _.routinesCall( function1 );
  debugger;
  test.identical( got, expected1 );

  test.case = 'call single function with context and arguments';
  var got = _.routinesCall( context3, testFunction3, [value2, value3] );
  test.identical( got, expected2 );

  test.case = 'call functions without context and arguments';
  var got = _.routinesCall( [ function1, function2, function3 ] );
  test.identical( got, expected3 );

  test.case = 'call functions with context and arguments';
  var got = _.routinesCall( context3, [ function4, function5, function6 ], [value2, value3] );
  test.identical( got, expected4 );

  if( !Config.debug )
  return;

  test.case = 'missed argument';
  test.shouldThrowError( function()
  {
    _.routinesCall();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.routinesCall(
      context3,
      [ function1, function2, function3 ],
      [ function4, function5, function6 ],
      [value2, value3]
    );
  });

  test.case = 'passed non callable object';
  test.shouldThrowError( function()
  {
    _.routinesCall( null );
  });

  test.case = 'passed arguments as primitive value (no wrapped into array)';
  test.shouldThrowError( function()
  {
     _.routinesCall( context3, testFunction3, value2 )
  });

}

//

function routinesCompose( test )
{

  function routineUnrolling()
  {
    counter += 10;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += arguments[ a ];
    return _.unrollAppend( null, arguments, counter );
  }

  function routineNotUnrolling()
  {
    counter += 10;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += arguments[ a ];
    return _.arrayAppend_( null, arguments, counter );
  }

  function r2()
  {
    counter += 100;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += 2*arguments[ a ];
    return counter;
  }

  function _break()
  {
    return undefined;
  }

  function chainer1( e, k, args, op )
  {
    return e;
  }

  /* - */

  test.case = 'empty';

  var counter = 0;
  var routines = [];
  var composition = _.routinesCompose( routines );
  var got = composition( 1,2,3 );
  var expected = [];
  test.identical( got, expected );
  test.identical( counter, 0 );

  /* - */

  test.open( 'unrolling:1' )

  /* */

  test.case = 'without chainer';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, r2, null ];
  var composition = _.routinesCompose( routines );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16,128 ];
  test.identical( got, expected );
  test.identical( counter, 128 );

  /* */

  test.case = 'with chainer';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, r2, null ];
  var composition = _.routinesCompose( routines, chainer1 );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16,160 ];
  test.identical( got, expected );
  test.identical( counter, 160 );

  /* */

  test.case = 'with chainer and break';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, _break, null, r2, null ];
  var composition = _.routinesCompose( routines, chainer1 );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16 ];
  test.identical( got, expected );
  test.identical( counter, 16 );

  /* */

  test.close( 'unrolling:1' )

  /* - */

  test.open( 'unrolling:0' )

  /* */

  test.case = 'without chainer';

  var counter = 0;
  var routines = [ null, routineNotUnrolling, null, r2, null ];
  var composition = _.routinesCompose( routines );
  var got = composition( 1,2,3 );
  var expected = [ [ 1,2,3,16 ], 128 ];
  test.identical( got, expected );
  test.identical( counter, 128 );

  /* */

  test.case = 'with chainer';

  var counter = 0;
  var routines = [ null, routineNotUnrolling, null, r2, null ];
  var composition = _.routinesCompose( routines, chainer1 );
  var got = composition( 1,2,3 );
  var expected = [ [ 1,2,3,16 ], 160 ];
  test.identical( got, expected );
  test.identical( counter, 160 );

  /* */

  test.case = 'with chainer and break';

  var counter = 0;
  var routines = [ null, routineNotUnrolling, null, _break, null, r2, null ];
  var composition = _.routinesCompose( routines, chainer1 );
  var got = composition( 1,2,3 );
  var expected = [ [ 1,2,3,16 ] ];
  test.identical( got, expected );
  test.identical( counter, 16 );

  /* */

  test.close( 'unrolling:0' )

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.routinesComposeEvery() );
  test.shouldThrowErrorSync( () => _.routinesComposeEvery( routines, function(){}, function(){} ) );

}

//

function routinesComposeEvery( test )
{

  function routineUnrolling()
  {
    counter += 10;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += arguments[ a ];
    return _.unrollAppend( null, arguments, counter );
  }

  function routineNotUnrolling()
  {
    counter += 10;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += arguments[ a ];
    return _.arrayAppend_( null, arguments, counter );
  }

  function r2()
  {
    counter += 100;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += 2*arguments[ a ];
    return counter;
  }

  function _nothing()
  {
    return undefined;
  }

  function _dont()
  {
    return dont;
  }

  test.case = 'with nothing';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, _nothing, null, r2, null ];
  var composition = _.routinesComposeEvery( routines );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16,128 ];
  test.identical( got, expected );
  test.identical( counter, 128 );

  test.case = 'last nothing';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, _nothing ];
  var composition = _.routinesComposeEvery( routines );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16 ];
  test.identical( got, expected );
  test.identical( counter, 16 );

  test.case = 'not unrolling and last nothing';

  var counter = 0;
  var routines = [ null, routineNotUnrolling, null, _nothing ];
  var composition = _.routinesComposeEvery( routines );
  var got = composition( 1,2,3 );
  var expected = [ [ 1,2,3,16 ] ];
  test.identical( got, expected );
  test.identical( counter, 16 );

  test.case = 'with nothing and dont';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, _nothing, null, _dont, null, r2, null ];
  var composition = _.routinesComposeEvery( routines );
  debugger;
  var got = composition( 1,2,3 );
  debugger;
  var expected = undefined;
  test.identical( got, expected );
  test.identical( counter, 16 );

  if( !Config.debug )
  return;

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.routinesComposeEvery() );
  test.shouldThrowErrorSync( () => _.routinesComposeEvery( routines, function(){} ) );
  test.shouldThrowErrorSync( () => _.routinesComposeEvery( routines, function(){}, function(){} ) );

}

//

function routinesComposeEveryReturningLast( test )
{

  function routineUnrolling()
  {
    counter += 10;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += arguments[ a ];
    debugger;
    return _.unrollAppend( null, arguments, counter );
  }

  function routineNotUnrolling()
  {
    counter += 10;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += arguments[ a ];
    debugger;
    return _.arrayAppend_( null, arguments, counter );
  }

  function r2()
  {
    counter += 100;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += 2*arguments[ a ];
    return counter;
  }

  function _nothing()
  {
    return undefined;
  }

  function _dont()
  {
    return dont;
  }

  test.case = 'with nothing';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, _nothing, null, r2, null ];
  var composition = _.routinesComposeEveryReturningLast( routines );
  var got = composition( 1,2,3 );
  var expected = 128;
  test.identical( got, expected );
  test.identical( counter, 128 );

  test.case = 'last nothing';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, _nothing ];
  var composition = _.routinesComposeEveryReturningLast( routines );
  var got = composition( 1,2,3 );
  var expected = 16;
  test.identical( got, expected );
  test.identical( counter, 16 );

  test.case = 'not unrolling and last nothing';

  var counter = 0;
  var routines = [ null, routineNotUnrolling, null, _nothing ];
  var composition = _.routinesComposeEveryReturningLast( routines );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16 ];
  test.identical( got, expected );
  test.identical( counter, 16 );

  test.case = 'with nothing and dont';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, _nothing, null, _dont, null, r2, null ];
  var composition = _.routinesComposeEveryReturningLast( routines );
  var got = composition( 1,2,3 );
  var expected = dont;
  test.identical( got, expected );
  test.identical( counter, 16 );

  if( !Config.debug )
  return;

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.routinesComposeEveryReturningLast() );
  test.shouldThrowErrorSync( () => _.routinesComposeEveryReturningLast( routines, function(){} ) );
  test.shouldThrowErrorSync( () => _.routinesComposeEveryReturningLast( routines, function(){}, function(){} ) );

}

//

function routinesChain( test )
{

  function routineUnrolling()
  {
    counter += 10;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += arguments[ a ];
    return _.unrollAppend( null, arguments, counter );
  }

  function r2()
  {
    counter += 100;
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += 2*arguments[ a ];
    return counter;
  }

  function _break()
  {
    return _.dont;
  }

  function dontInclude()
  {
    return undefined;
  }

  /* */

  test.case = 'without break';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, r2, null ];
  var composition = _.routinesChain( routines );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16,160 ];
  test.identical( got, expected );
  test.identical( counter, 160 );

  /* */

  test.case = 'with break';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, _break, null, r2, null ];
  var composition = _.routinesChain( routines );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16 ];
  test.identical( got, expected );
  test.identical( counter, 16 );

  /* */

  test.case = 'with dont include';

  var counter = 0;
  var routines = [ null, routineUnrolling, null, dontInclude, null, r2, null ];
  var composition = _.routinesChain( routines );
  var got = composition( 1,2,3 );
  var expected = [ 1,2,3,16, 160 ];
  test.identical( got, expected );
  test.identical( counter, 160 );

  if( !Config.debug )
  return;

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.routinesComposeEvery() );
  test.shouldThrowErrorSync( () => _.routinesComposeEvery( routines, function(){} ) );
  test.shouldThrowErrorSync( () => _.routinesComposeEvery( routines, function(){}, function(){} ) );

}

//

function routineVectorize_functor( test )
{
  function srcRoutine( a,b )
  {
    return _.longSlice( arguments );
  }

  test.open( 'defaults' );

  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 0,
    select : 1
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.case = 'single argument';

  test.identical( routine( 1 ), [ 1 ] );
  test.identical( routine( [ 1 ] ), [ [ 1 ] ] );
  test.identical( routine( [ 1,2,3 ] ), [ [ 1 ], [ 2 ], [ 3 ] ] );

  test.case = 'multiple argument';

  test.identical( routine( 1, 0 ), [ 1, 0 ] );
  test.identical( routine( [ 1,2,3 ], 2 ), [ [ 1,2 ], [ 2,2 ], [ 3,2 ] ] );
  test.identical( routine( 2, [ 1,2,3 ] ), [ 2, [ 1,2,3 ] ] );
  test.identical( routine( [ 1,2 ], [ 1,2 ] ), [ [ 1, [ 1,2 ] ], [ 2, [ 1,2 ] ] ] );

  test.close( 'defaults' );

  //

  test.open( 'vectorizingArray 0' );

  var o =
  {
    vectorizingArray : 0,
    vectorizingMap : 0,
    select : 1
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.identical( routine, srcRoutine )

  test.close( 'vectorizingArray 0' );

  //

  test.open( 'vectorizingMap : 1' );

  var o =
  {
    vectorizingArray : 0,
    vectorizingMap : 1,
    select : 1
  }
  o.routine = srcRoutine;
  debugger
  var routine = _.routineVectorize_functor( o );

  test.case = 'single argument';

  test.identical( routine( 1 ), [ 1 ] );
  test.identical( routine( [ 1 ] ), [ [ 1 ] ] );
  test.identical( routine( [ 1,2,3 ] ), [ [ 1,2,3 ] ] );
  test.identical( routine( { 1 : 1, 2 : 2, 3 : 3 } ), { 1 : [ 1 ] , 2 : [ 2 ], 3 : [ 3 ] } );

  test.case = 'multiple argument';

  test.identical( routine( 1, 0 ), [ 1,0 ] );
  test.identical( routine( [ 1,2,3 ], 2 ), [ [ 1,2,3 ], 2 ] );
  test.identical( routine( 2, [ 1,2,3 ] ), [ 2, [ 1,2,3 ] ] );
  test.identical( routine( [ 1,2 ], [ 1,2 ] ), [ [ 1,2 ], [ 1,2 ] ] );

  test.identical( routine( { a : 1 } , 0 ), { a : [ 1,0 ] } );
  test.identical( routine( 0, { a : 1 } ), [ 0, { a : 1 } ] );
  test.identical( routine( { a : 1 }, { b : 2 } ), { a : [ 1, { b : 2 } ] } );

  test.identical( routine( { a : 1 }, 2, 3 ), { a : [ 1, 2, 3 ] } );
  test.identical( routine( { a : 1 }, { b : 2 }, { c : 3 } ), { a : [ 1, { b : 2 }, { c : 3 } ] } );

  test.close( 'vectorizingMap : 1' );

  //

  test.open( 'vectorizingArray : 1, vectorizingMap : 1' );

  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 1,
    select : 1
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.case = 'single argument';

  test.identical( routine( 1 ), [ 1 ] );
  test.identical( routine( [ 1 ] ), [ [ 1 ] ] );
  test.identical( routine( [ 1,2,3 ] ), [ [ 1 ], [ 2 ], [ 3 ] ] );
  test.identical( routine( { 1 : 1, 2 : 2, 3 : 3 } ), { 1 : [ 1 ] , 2 : [ 2 ], 3 : [ 3 ] } );

  test.case = 'multiple argument';

  test.identical( routine( 1, 0 ), [ 1, 0 ] );
  test.identical( routine( [ 1,2,3 ], 2 ), [ [ 1,2 ], [ 2,2 ], [ 3,2 ] ] );
  test.identical( routine( 2, [ 1,2,3 ] ), [ 2, [ 1,2,3 ] ] );
  test.identical( routine( [ 1,2 ], [ 1,2 ] ), [ [ 1, [ 1,2 ] ], [ 2, [ 1,2 ] ] ] );

  test.identical( routine( { a : 1 } , 0 ), { a : [ 1,0 ] } );
  test.identical( routine( 0, { a : 1 } ), [ 0, { a : 1 } ] );
  test.identical( routine( { a : 1 }, { b : 2 } ), { a : [ 1, { b : 2 } ] } );

  test.identical( routine( { a : 1 }, 2, 3 ), { a : [ 1, 2, 3 ] } );
  test.identical( routine( { a : 1 }, { b : 2 }, { c : 3 } ), { a : [ 1, { b : 2 }, { c : 3 } ] } );

  test.identical( routine( [ 1 ] , { a : 2 } ), [ [ 1, { a : 2 } ] ] );
  test.identical( routine( { a : 1 }, [ 2 ] ), { a : [ 1, [ 2 ] ] } );

  test.identical( routine( [ 1 ] , { a : 2 }, 3 ), [ [ 1, { a : 2 }, 3 ] ] );
  test.identical( routine( { a : 1 }, [ 2 ], 3 ), { a : [ 1, [ 2 ], 3 ] } );

  test.close( 'vectorizingArray : 1, vectorizingMap : 1' );

  //

  test.open( 'vectorizingArray : 1, select : key ' );

  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 0,
    select : 'b'
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.case = 'single argument';

  test.identical( routine( '1' ), [ '1' ] );
  test.identical( routine([ 1 ]), [ [ 1 ] ] );
  test.identical( routine({ a : 0 }), [ { a : 0 } ] );
  test.identical( routine({ a : 0, b : '1' }), [ { a : 0, b : '1' } ] );
  test.identical( routine({ a : 0, b : [ 1 ] }), [ [ { a : 0, b : 1 } ] ] );
  test.identical( routine({ a : 0, b : [ 1,2 ] }), [ [ { a : 0, b : 1 } ], [ { a : 0, b : 2 } ] ] );

  test.case = 'multiple argument';

  if( Config.debug )
  test.shouldThrowError( () => routine({ a : 0, b : [ 1 ] }, 2 ) );

  test.close( 'vectorizingArray : 1, select : key ' );

  //

  test.open( 'vectorizingArray : 1, select : multiple keys ' );

  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 0,
    select : [ 'a', 'b' ]
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.case = 'single argument';

  var src = 'a'
  var got = routine( src );
  var expected = [ [ src ], [ src ] ];
  test.identical( got, expected );

  var src = [ 1 ]
  var got = routine( src );
  var expected = [ [ src ], [ src ] ];
  test.identical( got, expected );

  var src = { c : 1 }
  var got = routine( src );
  var expected = [ [ src ], [ src ] ];
  test.identical( got, expected );

  var got = routine({ a : 0, b : [ 1 ] });
  var expected =
  [
    [
      {
        a : 0,
        b : [ 1 ]
      }
    ],
    [
      [
        { a : 0, b : 1 }
      ]
    ]
  ]
  test.identical( got, expected );

  /**/

  var got = routine({ a : 0, b : [ 1,2 ] });
  var expected =
  [
    [
      {
        a : 0,
        b : [ 1,2 ]
      }
    ],
    [
      [
        { a : 0, b : 1 }
      ],
      [
        { a : 0, b : 2 }
      ]
    ],

  ]
  test.identical( got, expected );

  test.case = 'multiple argument';

  if( Config.debug )
  test.shouldThrowError( () => routine({ a : 0, b : [ 1 ] }, 2 ) );

  test.close( 'vectorizingArray : 1, select : multiple keys ' );

  //

  test.open( 'vectorizingArray : 1,select : 2' );

  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 0,
    select : 2
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.identical( routine( [ 1,2 ], 1 ), [ [ 1,1 ], [ 2,1 ] ] );
  test.identical( routine( 1, [ 1,2 ] ), [ [ 1,1 ], [ 1,2 ] ] );
  test.identical( routine( [ 1,2 ], [ 1,2 ] ), [ [ 1,1 ], [ 2,2 ] ] );
  test.identical( routine( 1,2 ), [ 1,2 ] );

  test.identical( routine( { a : 1 }, 1 ), [ { a : 1 }, 1 ] );
  test.identical( routine( 1, { a : 1 } ), [ 1, { a : 1 }] );
  test.identical( routine( { a : 1 }, { b : 2 } ), [ { a : 1 }, { b : 2 } ] );

  test.identical( routine( [ 1 ], { a : 2 } ), [ [ 1, { a : 2 } ] ] );
  test.identical( routine( [ 1,2 ], { a : 3 } ), [ [ 1, { a : 3 } ], [ 2, { a : 3 } ] ] );
  test.identical( routine( { a : 3 }, [ 1,2 ] ), [ [ { a : 3 }, 1  ], [ { a : 3 }, 2 ] ] );

  if( Config.debug )
  {
    test.shouldThrowError( () => routine( 1 ) );
    test.shouldThrowError( () => routine( 1,2,3 ) );
    test.shouldThrowError( () => routine( [ 1,2 ], [ 1,2,3 ] ) );
    test.shouldThrowError( () => routine( [ 1 ], [ 2 ], [ 3 ] ) );
  }

  test.close( 'vectorizingArray : 1,select : 2' );

  //

  test.open( 'vectorizingMap : 1,select : 2' );

  var o =
  {
    vectorizingArray : 0,
    vectorizingMap : 1,
    select : 2
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.identical( routine( [ 1,2 ], 3 ), [ [ 1,2 ], 3 ] );
  test.identical( routine( 1, [ 1,2 ] ), [ 1, [ 1,2 ] ] );
  test.identical( routine( [ 1,2 ], [ 1,2 ] ), [ [ 1,2 ], [ 1,2 ] ] );
  test.identical( routine( 1,2 ), [ 1,2 ] );

  test.identical( routine( { a : 1 }, 1 ), { a : [ 1, 1 ] } );
  test.identical( routine( 1, { a : 1 } ), { a : [ 1, 1 ] } );
  test.identical( routine( { a : 1 }, { a : 2 } ), { a : [ 1,2 ] } );
  test.identical( routine( { a : 1, b : 1 }, { b : 2, a : 2 } ), { a : [ 1,2 ], b : [ 1,2 ] } );

  if( Config.debug )
  {
    test.shouldThrowError( () => routine( 1 ) );
    test.shouldThrowError( () => routine( { a : 1 }, { b : 1 } ) );
  }

  test.close( 'vectorizingMap : 1,select : 2' );

  //

  test.open( 'vectorizingArray : 1, vectorizingMap : 1,select : 2' );

  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 1,
    select : 2
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.identical( routine( [ 1,2 ], 3 ), [ [ 1,3 ], [ 2,3 ] ] );
  test.identical( routine( 1, [ 1,2 ] ), [ [ 1,1 ], [ 1,2 ] ] );
  test.identical( routine( [ 1,2 ], [ 1,2 ] ), [ [ 1,1 ], [ 2,2 ] ] );
  test.identical( routine( 1,2 ), [ 1,2 ] );

  test.identical( routine( { a : 1 }, 1 ), { a : [ 1, 1 ] } );
  test.identical( routine( 1, { a : 1 } ), { a : [ 1, 1 ] } );
  test.identical( routine( { a : 1 }, { a : 2 } ), { a : [ 1,2 ] } );
  test.identical( routine( { a : 1, b : 1 }, { b : 2, a : 2 } ), { a : [ 1,2 ], b : [ 1,2 ] } );

  if( Config.debug )
  {
    test.shouldThrowError( () => routine( [ 1,2 ], [ 1,2,3 ] ) )
    test.shouldThrowError( () => routine( 1,2,3 ) );
    test.shouldThrowError( () => routine( { a : 1 }, { b : 1 } ) );
    test.shouldThrowError( () => routine( [ 1 ], { b : 1 } ) );
    test.shouldThrowError( () => routine( { b : 1 }, [ 1 ] ) );
    test.shouldThrowError( () => routine( 1, [ 1 ], { b : 1 } ) );
    test.shouldThrowError( () => routine( [ 1 ], 1, { b : 1 } ) );
    test.shouldThrowError( () => routine( { b : 1 }, 1, [ 1 ] ) );
    test.shouldThrowError( () => routine( { b : 1 }, [ 1 ], 1 ) );
  }

  test.close( 'vectorizingArray : 1, vectorizingMap : 1,select : 2' );

  test.open( ' vectorizingKeys : 1' );

  var o =
  {
    vectorizingArray : 0,
    vectorizingMap : 0,
    vectorizingKeys : 1,
    select : 1
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.identical( routine( 1  ), [ 1 ] );
  test.identical( routine( [ 1 ] ), [ [ 1 ] ] );
  test.identical( routine( { a : 1 } ), { a : 1 } );

  if( Config.debug )
  test.shouldThrowError( () => routine( 1, 2 ) )

  test.close( ' vectorizingKeys : 1' );

  test.open( 'vectorizingKeys : 1, select : 2' );

  var o =
  {
    vectorizingArray : 0,
    vectorizingMap : 0,
    vectorizingKeys : 1,
    select : 2
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.identical( routine(  1, 1  ), [ 1, 1 ] );
  test.identical( routine( [ 1 ], 1 ), [ [ 1 ], 1 ] );
  test.identical( routine( { a : 1 }, 'b' ), { 'a,b' : 1 } );
  test.identical( routine( 'a', { b : 1, c : 2 } ), { 'a,b' : 1, 'a,c' : 2 } );
  test.identical( routine( [ 'a' ], { b : 1, c : 2 } ), { 'a,b' : 1, 'a,c' : 2 } );
  test.identical( routine( { b : 1, c : 2 }, [ 'a' ] ), { 'b,a' : 1, 'c,a' : 2 } );

  if( Config.debug )
  test.shouldThrowError( () => routine( 1,2,3 ) );

  test.close( 'vectorizingKeys : 1, select : 2' );

  test.open( 'vectorizingKeys : 1, vectorizingArray : 1, select : 2' );

  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 0,
    vectorizingKeys : 1,
    select : 2
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.identical( routine( [ 1,2 ], 3 ), [ [ 1,3 ], [ 2,3 ] ] );
  test.identical( routine( 1, [ 1,2 ] ), [ [ 1,1 ], [ 1,2 ] ] );
  test.identical( routine( [ 1,2 ], [ 1,2 ] ), [ [ 1,1 ], [ 2,2 ] ] );
  test.identical( routine( 1,2 ), [ 1,2 ] );

  test.identical( routine( { a : 1 }, 'b' ), { 'a,b' : 1 } );
  test.identical( routine( 'a', { b : 1, c : 2 } ), { 'a,b' : 1, 'a,c' : 2 } );

  test.identical( routine( { a : 1 }, 1 ), { 'a,1' : 1 } );
  test.identical( routine( 1, { b : 1, c : 2 } ), { '1,b' : 1, '1,c' : 2 } );

  test.identical( routine( [ 1 ], { b : true } ), { '1,b' : true } );
  test.identical( routine( [ 1,2 ], { b : true } ), { '1,b' : true, '2,b' : true } );

  if( Config.debug )
  {
    test.shouldThrowError( () => routine( 1,2,3 ) );
    test.shouldThrowError( () => routine( { a : 1 }, { b : 1 } ) );
    // test.shouldThrowError( () => routine( [ 1 ], { b : 1 } ) );
    // test.shouldThrowError( () => routine( { b : 1 }, [ 1 ] ) );
    // test.shouldThrowError( () => routine( 1, [ 1 ], { b : 1 } ) );
    test.shouldThrowError( () => routine( [ 1 ], 1, { b : 1 } ) );
    test.shouldThrowError( () => routine( { b : 1 }, 1, [ 1 ] ) );
    test.shouldThrowError( () => routine( { b : 1 }, [ 1 ], 1 ) );
  }

  test.close( 'vectorizingKeys : 1, vectorizingArray : 1, select : 2' );

  test.open( 'vectorizingKeys : 1, vectorizingArray : 1, select : 3' );

  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 0,
    vectorizingKeys : 1,
    select : 3
  }
  o.routine = srcRoutine;
  var routine = _.routineVectorize_functor( o );

  test.identical( routine( [ 1 ], { b : true }, 'c' ), { '1,b,c' : true } );
  test.identical( routine( [ 1 ], { b : true }, [ 'c' ] ), { '1,b,c' : true } );
  test.identical( routine( [ 1 ], { b : true, c : false }, 'd' ), { '1,b,d' : true, '1,c,d' : false } );
  test.identical( routine( [ 1,2 ], { b : true }, 'c' ), { '1,b,c' : true, '2,b,c' : true } );

  //

  var got =  routine( [ 1,2 ], { b : true, c : false }, [ 'd', 'e' ] );
  var expected =
  {
    '1,b,d' : true,
    '1,c,d' : false,
    '2,b,e' : true,
    '2,c,e' : false
  }
  test.identical( got, expected );

  //

  var got =  routine( [ 1,2 ], [ 'd', 'e' ], { b : true, c : false } );
  var expected =
  {
    '1,d,b' : true,
    '1,d,c' : false,
    '2,e,b' : true,
    '2,e,c' : false
  }
  test.identical( got, expected );

  //

  var got =  routine( { b : true, c : false }, [ 1,2 ], [ 'd', 'e' ]  );
  var expected =
  {
    'b,1,d' : true,
    'c,1,d' : false,
    'b,2,e' : true,
    'c,2,e' : false
  }
  test.identical( got, expected );

  //

  var got =  routine( [ 1,2 ], { b : true, c : false, d : true }, [ 'e', 'f' ] );
  var expected =
  {
    '1,b,e' : true,
    '1,c,e' : false,
    '1,d,e' : true,
    '2,b,f' : true,
    '2,c,f' : false,
    '2,d,f' : true
  }
  test.identical( got, expected );

  //

  var got =  routine( [ 1,2 ], [ 'e', 'f' ], { b : true, c : false, d : true } );
  var expected =
  {
    '1,e,b' : true,
    '1,e,c' : false,
    '1,e,d' : true,
    '2,f,b' : true,
    '2,f,c' : false,
    '2,f,d' : true
  }
  test.identical( got, expected );

  //

  var got =  routine( { b : true, c : false, d : true }, [ 1,2 ], [ 'e', 'f' ] );
  var expected =
  {
    'b,1,e' : true,
    'c,1,e' : false,
    'd,1,e' : true,
    'b,2,f' : true,
    'c,2,f' : false,
    'd,2,f' : true
  }
  test.identical( got, expected );

  //

  var got =  routine( 1, { b : true, c : false, d : true }, 2 );
  var expected =
  {
    '1,b,2' : true,
    '1,c,2' : false,
    '1,d,2' : true
  }
  test.identical( got, expected );

  //

  var got =  routine( { b : true, c : false, d : true }, 1, 2 );
  var expected =
  {
    'b,1,2' : true,
    'c,1,2' : false,
    'd,1,2' : true
  }
  test.identical( got, expected );

  //

  var got =  routine( 1, 2, { b : true, c : false, d : true } );
  var expected =
  {
    '1,2,b' : true,
    '1,2,c' : false,
    '1,2,d' : true
  }
  test.identical( got, expected );

  //

  var got =  routine( [ 1,2 ], { b : true }, 'c' );
  var expected =
  {
    '1,b,c' : true,
    '2,b,c' : true,
  }
  test.identical( got, expected );

  //

  var got =  routine( { b : true }, [ 1,2 ], 'c' );
  var expected =
  {
    'b,1,c' : true,
    'b,2,c' : true,
  }
  test.identical( got, expected );

  //

  var got =  routine( [ 1,2 ], 'c', { b : true } );
  var expected =
  {
    '1,c,b' : true,
    '2,c,b' : true,
  }
  test.identical( got, expected );

  //

  var got =  routine( [ 1,2 ], { b : true, c : false }, 'd' );
  var expected =
  {
    '1,b,d' : true,
    '1,c,d' : false,
    '2,b,d' : true,
    '2,c,d' : false
  }
  test.identical( got, expected );

  //

  var got =  routine( { b : true, c : false }, [ 1,2 ], 'd' );
  var expected =
  {
    'b,1,d' : true,
    'b,2,d' : true,
    'c,1,d' : false,
    'c,2,d' : false
  }
  test.identical( got, expected );

  //

  var got =  routine( [ 1,2 ], 'd', { b : true, c : false } );
  var expected =
  {
    '1,d,b' : true,
    '1,d,c' : false,
    '2,d,b' : true,
    '2,d,c' : false
  }
  test.identical( got, expected );

  //

  if( Config.debug )
  {
    test.shouldThrowError( () => routine( { a : 1 }, 'c', { b : 1 } ) );
    test.shouldThrowError( () => routine( [ 1 ], { b : true }, [ 'c', 'd' ] ) );
  }

  test.close( 'vectorizingKeys : 1, vectorizingArray : 1, select : 3' );

  test.open( 'vectorizingKeys : 1, vectorizingArray : 1, vectorizingMap : 1, select : 1' );
  var o =
  {
    vectorizingArray : 1,
    vectorizingMap : 1,
    vectorizingKeys : 1,
    select : 1
  }
  o.routine = srcRoutine;
  test.shouldThrowError( () => _.routineVectorize_functor( o ) );

  test.close( 'vectorizingKeys : 1, vectorizingArray : 1, vectorizingMap : 1, select : 1' );
}

//

var Self =
{

  name : 'Tools/base/layer1/Routine',
  silencing : 1,

  tests :
  {

    _routineJoin : _routineJoin,
    // routineBind  : routineBind,
    routineJoin  : routineJoin,
    routineSeal  : routineSeal,
    routinesCall : routinesCall,

    routinesCompose : routinesCompose,
    routinesComposeEvery : routinesComposeEvery,
    routinesComposeEveryReturningLast : routinesComposeEveryReturningLast,
    routinesChain : routinesChain,

    routineVectorize_functor : routineVectorize_functor,

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
