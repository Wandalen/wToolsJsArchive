( function _l0_l1_Err_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../Include1.s' );
  require( 'wTesting' );
}

const _ = _global_.wTools;
const __ = _globals_.testing.wTools;
const fileProvider = __.fileProvider;
const path = fileProvider.path;
const logger = _global_.logger || _global_.console;

// --
// context
// --

function onSuiteBegin()
{
  let context = this;

  context.suiteTempPath = path.tempOpen( path.join( __dirname, '../..' ), 'err' );
  context.assetsOriginalPath = path.join( __dirname, '_asset' );

}

//

function onSuiteEnd()
{
  let context = this;
  _.assert( _.strHas( context.suiteTempPath, '/err-' ) )
  path.tempClose( context.suiteTempPath );
}

// --
// tests
// --

function dichotomysBasic( test )
{

  /* */

  test.case = 'unformed error';
  var err = new Error( 'Error1' );

  test.true( _.error.is( err ) );
  test.true( !_.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  console.log( err.message );

  /* */

  test.case = 'formed error';
  var err = _.err( 'Error1' );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  console.log( err.message );
  console.log( err.originalMessage );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  /* */

  test.case = 'formed error, console.log';
  var err = _.err( 'Error1' );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  console.log( err );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( _.error.isAttended( err ) );
  test.true( _.error.isLogged( err ) );

  /* */

  test.case = 'formed error, attend';
  var err = _.err( 'Error1' );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  _.error.attend( err );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( _.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  /* */

  test.case = 'formed error, logged';
  var err = _.err( 'Error1' );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  _.error.logged( err );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( _.error.isLogged( err ) );

  /* */

}

//

function dichotomyBriefUnbrief( test )
{

  /* */

  test.case = 'formed breif error';
  var err = _.error.brief( 'Error1' );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( _.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  var err2 = _.error.unbrief( err );
  test.true( err === err2 );

  test.true( _.error.is( err ) );
  test.true( _.error.isFormed( err ) );
  test.true( !_.error.isBrief( err ) );
  test.true( !_.error.isSuspended( err ) );
  test.true( !_.error.isAttended( err ) );
  test.true( !_.error.isLogged( err ) );

  /* */

}

//

function _errTrowsError( test )
{
  try
  {
    _._err();
  }
  catch( err )
  {
    test.case = 'without arguments';
    test.true( _.error.is( err ) );
    test.identical( __.strCount( String( err ), 'Expects single argument : options map' ), 1 );
  }

  /* */

  try
  {
    _._err( { args : 'wrong' } );
  }
  catch( err )
  {
    test.case = 'o.args is not a long';
    test.true( _.error.is( err ) );
    test.identical( __.strCount( String( err ), '_err : Expects Long option::args' ), 1 );
  }

  /* */

  try
  {
    _._err( { args : [ 'arg' ], wrong : 1 } );
  }
  catch( err )
  {
    test.case = 'map option has unnecessaty fields';
    test.true( _.error.is( err ) );
    test.identical( __.strCount( String( err ), 'Unknown option::wrong' ), 1 );
  }
}

//

function _errEmptyArgs( test )
{
  test.case = 'empty args';
  var err = _._err( { args : [] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'Object._errEmptyArgs' ), 2 );

  test.case = 'empty args, throwCallsStack - undefined, catchCallsStack - undefined, level - 2';
  var err = _._err( { args : [], level : 2 } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'Object._errEmptyArgs' ), 0 );

  test.case = 'empty args, throwCallsStack - string';
  var err = _._err( { args : [], throwCallsStack : 'at program\nat _errTrowsError' } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'at program' ), 1 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 1 );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );

  test.case = 'empty args, throwCallsStack - undefined, catchCallsStack - string';
  var err = _._err( { args : [], catchCallsStack : 'at program\nat _errTrowsError' } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'at program' ), 1 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 1 );

  test.case = 'empty args, throwCallsStack - empty string';
  var o = { args : [], catchCallsStack : '' };
  var err = _._err( o );
  test.true( _.error.is( err ) );
  test.identical( o.throwCallsStack, o.catchCallsStack );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( err.stack, 'Object._errEmptyArgs' ), 2 );

  /* */

  test.case = 'empty args, throwCallsStack, stackRemovingBeginIncluding';
  var err = _._err( { args : [], throwCallsStack : 'at program1\nat _errTrowsError', stackRemovingBeginIncluding : /program1/ } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'at program1' ), 0 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 1 );

  test.case = 'empty args, throwCallsStack, stackRemovingBeginExcluding';
  var err = _._err( { args : [], throwCallsStack : 'at program1\nat _errTrowsError', stackRemovingBeginExcluding : /_errTrowsError/ } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'at program1' ), 1 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 0 );

  test.case = 'empty args, throwCallsStack, stackRemovingBeginIncluding and stackRemovingBeginExcluding';
  var err = _._err
  ({
    args : [],
    throwCallsStack : 'at program1\nat _errTrowsError',
    stackRemovingBeginIncluding : /program1/,
    stackRemovingBeginExcluding : /_errTrowsError/
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Error' ), 1 );
  test.identical( __.strCount( errStr, 'at program1' ), 0 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 0 );

  /* */

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and __';
  var err = _._err( { args : [], throwCallsStack : 'at program1\nat _errTrowsError', asyncCallsStack : [ 'at asyncCallsStack', 'at @2' ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, 'at @2' ), 1 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and with __';
  var err = _._err( { args : [], throwCallsStack : 'at program1\nat _errTrowsError', asyncCallsStack : [ 'at asyncCallsStack', '__dirname' ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, '__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and with *__';
  var err = _._err( { args : [], throwCallsStack : 'at program1\nat _errTrowsError', asyncCallsStack : [ 'at asyncCallsStack', '*__dirname' ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, '*__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - with ".test"';
  var err = _._err( { args : [], throwCallsStack : 'at program1\nat _errTrowsError', asyncCallsStack : [ 'at Err.test.s', '*__dirname' ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'at Err.test.s *' ), 1 );
  test.identical( __.strCount( errStr, '*__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - with ".test", stackCondensing - 0';
  var err = _._err
  ({
    args : [],
    throwCallsStack : 'at program1\nat _errTrowsError',
    asyncCallsStack : [ 'at Err.test.s', '*__dirname' ],
    stackCondensing : 0
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  console.log( errStr );
  test.identical( __.strCount( errStr, 'UnknownError' ), 1 );
  test.identical( __.strCount( errStr, 'at Err.test.s *' ), 0 );
  test.identical( __.strCount( errStr, '*__dirname' ), 1 );
}

//

function _errArgsHasError( test )
{
  test.case = 'empty args';
  var err = _._err( { args : [ new Error() ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Object._errArgsHasError' ), 2 );

  test.case = 'empty args, throwCallsStack - undefined, catchCallsStack - undefined, level - 2';
  var err = _._err( { args : [ new Error() ], level : 2 } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Object._errArgsHasError' ), 1 );

  test.case = 'empty args, throwCallsStack - string';
  var err = _._err( { args : [ new Error() ], throwCallsStack : 'at program\nat _errTrowsError' } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'at program' ), 1 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 1 );

  test.case = 'empty args, throwCallsStack - empty string';
  var o = { args : [ new Error() ], catchCallsStack : '' };
  var err = _._err( o );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( err.stack, 'Object._errArgsHasError' ), 2 );

  /* */

  test.case = 'empty args, throwCallsStack, stackRemovingBeginIncluding';
  var err = _._err( { args : [ new Error() ], throwCallsStack : 'at program1\nat _errTrowsError', stackRemovingBeginIncluding : /program1/ } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Error' ), 4 );
  test.identical( __.strCount( errStr, 'at program1' ), 0 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 1 );

  test.case = 'empty args, throwCallsStack, stackRemovingBeginExcluding';
  var err = _._err( { args : [ new Error() ], throwCallsStack : 'at program1\nat _errTrowsError', stackRemovingBeginExcluding : /_errTrowsError/ } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Error' ), 3 );
  test.identical( __.strCount( errStr, 'at program1' ), 1 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 0 );

  test.case = 'empty args, throwCallsStack, stackRemovingBeginIncluding and stackRemovingBeginExcluding, fallBackStack';
  var err = _._err
  ({
    args : [ new Error() ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    stackRemovingBeginIncluding : /program1/,
    stackRemovingBeginExcluding : /_errTrowsError/,
    fallBackStack : ''
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Error' ), 3 );
  test.identical( __.strCount( errStr, 'at program1' ), 0 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 0 );

  /* */

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and __';
  var err = _._err( { args : [ new Error() ], throwCallsStack : 'at program1\nat _errTrowsError', asyncCallsStack : [ 'at asyncCallsStack', 'at @2' ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Error' ), 4 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, 'at @2' ), 1 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and with __';
  var err = _._err( { args : [ new Error() ], throwCallsStack : 'at program1\nat _errTrowsError', asyncCallsStack : [ 'at asyncCallsStack', '__dirname' ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Error' ), 4 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, '__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and with *__';
  var err = _._err( { args : [ new Error() ], throwCallsStack : 'at program1\nat _errTrowsError', asyncCallsStack : [ 'at asyncCallsStack', '*__dirname' ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Error' ), 4 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, '*__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - with ".test"';
  var err = _._err( { args : [ new Error() ], throwCallsStack : 'at program1\nat _errTrowsError', asyncCallsStack : [ 'at Err.test.s', '*__dirname' ] } );
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Error' ), 4 );
  test.identical( __.strCount( errStr, 'at Err.test.s *' ), 1 );
  test.identical( __.strCount( errStr, '*__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - with ".test", stackCondensing - 0';
  var err = _._err
  ({
    args : [ new Error() ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    asyncCallsStack : [ 'at Err.test.s', '*__dirname' ],
    stackCondensing : 0
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  console.log( errStr );
  test.identical( __.strCount( errStr, 'Error' ), 4 );
  test.identical( __.strCount( errStr, 'at Err.test.s *' ), 0 );
  test.identical( __.strCount( errStr, '*__dirname' ), 1 );
}

//

function _errArgsHasRoutine( test )
{

  /* */

  test.case = 'empty args, throwCallsStack, stackRemovingBeginIncluding';
  var unroll = () => _.unroll.make( [ 'error with unroll', 'routine unroll' ] );
  var err = _._err
  ({
    args : [ unroll, new Error( 'Sample' ), new Error( 'next' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    stackRemovingBeginIncluding : /program1/
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'error with unroll' ), 1 );
  test.identical( __.strCount( errStr, 'routine unroll' ), 1 );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'next' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 2 );
  test.identical( __.strCount( errStr, 'at program1' ), 0 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 1 );

  test.case = 'empty args, throwCallsStack, stackRemovingBeginExcluding';
  var unroll = () => _.unroll.make( [ 'error with unroll', 'routine unroll' ] );
  var err = _._err
  ({
    args : [ unroll, new Error( 'Sample' ), new Error( 'next' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    stackRemovingBeginExcluding : /_errTrowsError/
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'error with unroll' ), 1 );
  test.identical( __.strCount( errStr, 'routine unroll' ), 1 );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'next' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 1 );
  test.identical( __.strCount( errStr, 'at program1' ), 1 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 0 );

  test.case = 'empty args, throwCallsStack, stackRemovingBeginIncluding and stackRemovingBeginExcluding, fallBackStack';
  var unroll = () => _.unroll.make( [ 'error with unroll', 'routine unroll' ] );
  var err = _._err
  ({
    args : [ unroll, new Error( 'Sample' ), new Error( 'next' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    stackRemovingBeginIncluding : /program1/,
    stackRemovingBeginExcluding : /_errTrowsError/,
    fallBackStack : ''
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'error with unroll' ), 1 );
  test.identical( __.strCount( errStr, 'routine unroll' ), 1 );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'next' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 1 );
  test.identical( __.strCount( errStr, 'at program1' ), 0 );
  test.identical( __.strCount( errStr, 'at _errTrowsError' ), 0 );

  /* */

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and __';
  var unroll = () => _.unroll.make( [ 'error with unroll', 'routine unroll' ] );
  var err = _._err
  ({
    args : [ unroll, new Error( 'Sample' ), new Error( 'next' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    asyncCallsStack : [ 'at asyncCallsStack', 'at @2' ]
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'error with unroll' ), 1 );
  test.identical( __.strCount( errStr, 'routine unroll' ), 1 );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'next' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 2 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, 'at @2' ), 1 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and with __';
  var unroll = () => _.unroll.make( [ 'error with unroll', 'routine unroll' ] );
  var err = _._err
  ({
    args : [ unroll, new Error( 'Sample' ), new Error( 'next' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    asyncCallsStack : [ 'at asyncCallsStack', '__dirname' ]
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'error with unroll' ), 1 );
  test.identical( __.strCount( errStr, 'routine unroll' ), 1 );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'next' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 2 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, '__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - without ".test" and with *__';
  var unroll = () => _.unroll.make( [ 'error with unroll', 'routine unroll' ] );
  var err = _._err
  ({
    args : [ unroll, new Error( 'Sample' ), new Error( 'next' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    asyncCallsStack : [ 'at asyncCallsStack', '*__dirname' ]
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'error with unroll' ), 1 );
  test.identical( __.strCount( errStr, 'routine unroll' ), 1 );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'next' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 2 );
  test.identical( __.strCount( errStr, 'at asyncCallsStack' ), 1 );
  test.identical( __.strCount( errStr, '*__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - with ".test"';
  var unroll = () => _.unroll.make( [ 'error with unroll', 'routine unroll' ] );
  var err = _._err
  ({
    args : [ unroll, new Error( 'Sample' ), new Error( 'next' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    asyncCallsStack : [ 'at Err.test.s', '*__dirname' ]
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'error with unroll' ), 1 );
  test.identical( __.strCount( errStr, 'routine unroll' ), 1 );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'next' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 2 );
  test.identical( __.strCount( errStr, 'at Err.test.s *' ), 1 );
  test.identical( __.strCount( errStr, '*__dirname' ), 0 );

  test.case = 'empty args, throwCallsStack, asyncCallsStack - with ".test", stackCondensing - 0';
  var unroll = () => _.unroll.make( [ 'error with unroll', 'routine unroll' ] );
  var err = _._err
  ({
    args : [ unroll, new Error( 'Sample' ), new Error( 'next' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    asyncCallsStack : [ 'at Err.test.s', '*__dirname' ],
    stackCondensing : 0
  });
  test.true( _.error.is( err ) );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'error with unroll' ), 1 );
  test.identical( __.strCount( errStr, 'routine unroll' ), 1 );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'next' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 2 );
  test.identical( __.strCount( errStr, 'at Err.test.s *' ), 0 );
  test.identical( __.strCount( errStr, '*__dirname' ), 1 );
}

//

function _errLocation( test )
{

  test.case = 'args - Error, throwCallsStack and throwLocation';
  var err = _._err
  ({
    args : [ new Error( 'Sample' ) ],
    throwCallsStack : 'at program1\nat _errTrowsError',
    throwLocation : { 'filePath' : 'at @605' }
  });
  test.true( _.error.is( err ) );
  test.identical( err.location.filePath, 'at @605' );
  test.identical( err.location.col, null );
  test.identical( err.location.line, null );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 2 );
  test.identical( __.strCount( errStr, 'at Err.test.s *' ), 0 );

  test.case = 'args - Error, catchCallsStack, catchLocation,throwCallsStack, throwLocation';
  var err = _._err
  ({
    args : [ new Error( 'Sample' ) ],
    catchCallsStack : 'at program1\nat _errTrowsError',
    catchLocation : { 'filePath' : 'at @605' },
    throwCallsStack : 'at program1\nat _errTrowsError',
    throwLocation : { 'filePath' : 'at @605' }
  });
  test.true( _.error.is( err ) );
  test.identical( __.strCount( err.throwsStack, 'at @605' ), 1 );
  test.identical( err.location.filePath, 'at @605' );
  test.identical( err.location.col, null );
  test.identical( err.location.line, null );
  var errStr = String( err );
  test.identical( __.strCount( errStr, 'Sample' ), 1 );
  test.identical( __.strCount( errStr, 'Error' ), 2 );
  test.identical( __.strCount( errStr, 'at Err.test.s *' ), 0 );
}

//

function _errOptionBrief( test )
{
  test.case = 'args - Error, without brief option';
  var srcErr = new Error( 'Sample' );
  var err = _._err
  ({
    args : [ srcErr ],
  });
  test.true( _.error.is( err ) );
  test.identical( err.brief, srcErr.brief );
  test.identical( err.brief, false );

  test.case = 'args - Error with brief option';
  var srcErr = new Error( 'Sample' );
  srcErr.brief = true;
  var err = _._err
  ({
    args : [ srcErr ],
  });
  test.true( _.error.is( err ) );
  test.identical( err.brief, srcErr.brief );
  test.identical( err.brief, true );

  test.case = 'args - Error, with brief option';
  var srcErr = new Error( 'Sample' );
  var err = _._err
  ({
    args : [ srcErr ],
    brief : 1
  });
  test.true( _.error.is( err ) );
  test.identical( err.brief, srcErr.brief );
  test.identical( err.brief, true );
}

//

function _errOptionReason( test )
{
  test.case = 'args - Error, without reason option';
  var srcErr = new Error( 'Sample' );
  var err = _._err
  ({
    args : [ srcErr ],
  });
  test.true( _.error.is( err ) );
  test.identical( err.reason, srcErr.reason );
  test.identical( err.reason, undefined );

  test.case = 'args - Error with reason option';
  var srcErr = new Error( 'Sample' );
  srcErr.reason = true;
  var err = _._err
  ({
    args : [ srcErr ],
  });
  test.true( _.error.is( err ) );
  test.identical( err.reason, srcErr.reason );
  test.identical( err.reason, true );
}

//

function _errOptionId( test )
{
  test.case = 'args - Error, without id option';
  var srcErr = new Error( 'Sample' );
  var err = _._err
  ({
    args : [ srcErr ],
  });
  test.true( _.error.is( err ) );
  test.identical( err.id, srcErr.id );
  test.ge( err.id, 1 );

  test.case = 'args - Error with id option';
  var srcErr = new Error( 'Sample' );
  srcErr.id = 123;
  var err = _._err
  ({
    args : [ srcErr ],
  });
  test.true( _.error.is( err ) );
  test.identical( err.id, srcErr.id );
  test.identical( err.id, 123 );
}

//

function _errCatchesForm( test )
{
  test.case = 'args - Error, without throws';
  var srcErr = new Error( 'Sample' );
  var err = _._err
  ({
    args : [ srcErr ],
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.throwsStack ), 1 );
  test.identical( __.strCount( err.throwsStack, 'Err.test.s' ), 1 );

  test.case = 'args - Error, throws';
  var srcErr = new Error( 'Sample' );
  var err = _._err
  ({
    args : [ srcErr ],
    throws : [ '@123', '@124' ]
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.throwsStack ), 3 );
  test.identical( __.strCount( err.throwsStack, 'thrown at @123' ), 1 );
  test.identical( __.strCount( err.throwsStack, 'thrown at @124' ), 1 );
  test.identical( __.strCount( err.throwsStack, 'Err.test.s' ), 1 );
}

//

function _originalMessage( test )
{
  test.case = 'args - different, simple routine';
  var err = _._err
  ({
    args : [ new Error( 'Sample' ), 'str', undefined, '', null, false, () => 1 ],
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.originalMessage ), 3 );
  test.identical( __.strCount( err.originalMessage, 'Sample str' ), 1 );
  test.identical( __.strCount( err.originalMessage, 'undefined' ), 1 );
  test.identical( __.strCount( err.originalMessage, 'null false 1' ), 1 );

  test.case = 'args - different, routine returns map with toStr';
  var a = () =>
  {
    return { toStr : () => '#1' }
  }
  var err = _._err
  ({
    args : [ new Error( 'Sample' ), 'str', undefined, '', null, false, a ],
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.originalMessage ), 3 );
  test.identical( __.strCount( err.originalMessage, 'Sample str' ), 1 );
  test.identical( __.strCount( err.originalMessage, 'undefined' ), 1 );
  test.identical( __.strCount( err.originalMessage, '#1' ), 1 );

  test.case = 'args - different, Error with originalMessage';
  var srcErr = new Error( 'Sample' );
  srcErr.originalMessage = 'New error';
  var err = _._err
  ({
    args : [ srcErr, 'str', undefined, '', null, false ],
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.originalMessage ), 3 );
  test.identical( __.strCount( err.originalMessage, 'New error str' ), 1 );
  test.identical( __.strCount( err.originalMessage, 'undefined' ), 1 );

  test.case = 'args - different, Error with message';
  var srcErr = new Error( 'Sample' );
  srcErr.message = 'New error';
  var err = _._err
  ({
    args : [ srcErr, 'str', undefined, '', null, false ],
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.originalMessage ), 3 );
  test.identical( __.strCount( err.originalMessage, 'New error str' ), 1 );
  test.identical( __.strCount( err.originalMessage, 'undefined' ), 1 );

  test.case = 'args - many spaces and new lines';
  var err = _._err
  ({
    args : [ new Error( '\n\n   Sample     ' ), '\n\nstr   \n', undefined, '', null, false ],
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.originalMessage ), 5 );
  test.identical( __.strCount( err.originalMessage, '\n\n   Sample     \n\nstr   \n' ), 0 );
  test.identical( __.strCount( err.originalMessage, 'Sample\n\nstr' ), 1 );
  test.identical( __.strCount( err.originalMessage, 'str\nundefined' ), 1 );

  test.case = 'Error without description, without fallBackMessage';
  var err = _._err
  ({
    args : [ new Error() ],
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.originalMessage ), 1 );
  test.identical( __.strCount( err.originalMessage, 'Error' ), 1 );

  test.case = 'Unknown error, without fallBackMessage';
  var err = _._err
  ({
    args : [],
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.originalMessage ), 1 );
  test.identical( __.strCount( err.originalMessage, 'UnknownError' ), 1 );
}

//

function _errMessageForm( test )
{
  test.case = 'without option brief';
  var err = _._err
  ({
    args : [ new Error( 'Sample' ), 'str', undefined, '', null, false, () => 1 ],
  });
  test.true( _.error.is( err ) );
  test.gt( __.strLinesCount( err.message ), 10 );
  test.identical( __.strCount( err.message, 'Message of Error#' ), 1 );
  test.identical( __.strCount( err.message, 'Beautified calls stack' ), 1 );
  test.identical( __.strCount( err.message, 'Throws stack' ), 1 );
  test.identical( __.strCount( err.message, 'Sample str' ), 1 );
  test.identical( __.strCount( err.message, 'null false 1' ), 1 );

  test.case = 'without option brief, option stackCondensing - false';
  var err = _._err
  ({
    args : [ new Error( 'Sample' ), 'str', undefined, '', null, false, () => 1 ],
    stackCondensing : false,
  });
  test.true( _.error.is( err ) );
  test.gt( __.strLinesCount( err.message ), 10 );
  test.identical( __.strCount( err.message, 'Message of Error#' ), 1 );
  test.identical( __.strCount( err.message, 'Calls stack' ), 1 );
  test.identical( __.strCount( err.message, 'Throws stack' ), 1 );
  test.identical( __.strCount( err.message, 'Sample str' ), 1 );
  test.identical( __.strCount( err.message, 'null false 1' ), 1 );

  test.case = 'with option brief';
  var err = _._err
  ({
    args : [ new Error( 'Sample' ), 'str', undefined, '', null, false, () => 1 ],
    brief : 1
  });
  test.true( _.error.is( err ) );
  test.identical( __.strLinesCount( err.message ), 3 );
  test.identical( __.strCount( err.message, 'Message of Error#' ), 0 );
  test.identical( __.strCount( err.message, 'Beautified calls stack' ), 0 );
  test.identical( __.strCount( err.message, 'Throws stack' ), 0 );
  test.identical( __.strCount( err.message, 'Sample str' ), 1 );
  test.identical( __.strCount( err.message, 'undefined' ), 1 );
  test.identical( __.strCount( err.message, 'null false 1' ), 1 );
}

//

function _errOptionConcealedBasic( test )
{
  let context = this;

  /* */

  test.case = 'basic';
  var args = [ 'a', 'b' ];
  var err = _._err({ args : args, concealed : { 'field1' : 13 } });
  var got = _.props.descriptorOwnOf( err, 'field1' );
  var exp =
  {
    'value' : 13,
    'writable' : true,
    'enumerable' : false,
    'configurable' : true
  }
  test.identical( got, exp );

  /* */

}

//

function errCatchStackAndMessage( test )
{
  let context = this;
  let visited = [];

  function decrement( i )
  {
    try
    {
      if( i <= 0 )
      throw _.err( 'negative!' );
      return i-1;
    }
    catch( err )
    {
      throw _.err( err, '\nFailed to decrement' );
    }
  }

  function divide( i )
  {
    try
    {
      if( i % 2 === 1 )
      throw _.err( 'odd!' );
      return decrement( i / 2 );
    }
    catch( err )
    {
      throw _.err( err, '\nFailed to divide' );
    }
  }

  try
  {
    divide( 0 );
  }
  catch( err )
  {

    test.description = 'throwsStack';
    let regexp = new RegExp( _.regexpEscape( `${__.path.fullName( test.suiteFilePath )}:` ) + '.+', 'g' );
    let throwsStackLocations = __.longOnce( err.throwsStack.match( regexp ) );
    test.true( _.error.is( err ) );
    test.identical( throwsStackLocations.length, 3 );
    test.identical( __.strCount( err.throwsStack, 'thrown at' ), 3 );
    test.identical( __.strCount( err.throwsStack, 'thrown at decrement @' ), 2 );
    test.identical( __.strCount( err.throwsStack, 'thrown at divide @' ), 1 );
    test.identical( __.strCount( err.throwsStack, `${__.path.fullName( test.suiteFilePath )}:` ), 3 );

    test.description = 'combinedStack';
    test.identical( __.strCount( err.combinedStack, 'decrement' ), 1 );
    test.identical( __.strCount( err.combinedStack, 'divide' ), 1 );
    test.identical( __.strCount( err.combinedStack, `${__.path.fullName( test.suiteFilePath )}:` ), 3 );

    visited.push( 'catch1' );
  }

  test.identical( visited, [ 'catch1' ] );
}

//

function errErrorWithoutStack( test )
{
  let context = this;

  function ErrorConstructor()
  {
  }
  ErrorConstructor.prototype = Object.create( _global_.Error.prototype );
  ErrorConstructor.prototype.constructor = ErrorConstructor;
  ErrorConstructor.constructor = ErrorConstructor;

  let err1 = new ErrorConstructor();
  test.identical( err1.stack, undefined );

  let err2 = _.err( err1 );
  test.true( err1 === err2 );

  logger.log( err2.throwCallsStack );

  test.identical( __.strCount( _.str.lines.strip( err2.stack ), _.str.lines.strip( err2.combinedStack ) ), 1 );

  test.identical( __.strCount( err2.throwCallsStack, 'Err.test.s:' ), 1 );
  test.identical( __.strCount( err2.throwCallsStack.substring( 0, err2.throwCallsStack.indexOf( 'Err.test.s:' ) ), 'at ' ), 1 );

}

//

function errCustomError( test )
{
  let context = this;

  /* */

  function ErrorConstructor1()
  {
    let result = Error.call( this );
    return result;
  }
  ErrorConstructor1.prototype = Object.create( _global_.Error.prototype );
  ErrorConstructor1.prototype.constructor = ErrorConstructor1;

  let err1 = new ErrorConstructor1();
  test.true( _.strIs( err1.stack ) );
  logger.log( err1 );

  /* */

  class ErrorConstructor2 extends Error{};
  let err2 = new ErrorConstructor2();
  test.true( _.strIs( err2.stack ) );
  logger.log( err2 );

  /* */

}

//

function _inStr( test )
{
  let context = this;

  test.case = 'basic';
  var err = _.err( 'Some' );
  test.true( _.error._inStr( String( err ) ) );
  test.true( _.error._inStr( String( err.message ) ) );
  test.true( err.originalMessage === 'Some' );
  test.true( !_.error._inStr( String( err.originalMessage ) ) );

  test.case = 'wrapped';
  var src =
`
 -> Stderr
 -  err.logged : false
 -  err.attended : false
 -   = Message of Error#1
 -      Routine storageTerminalDel does not expect options: "selector", "locking"
 -      Failed to delete storage::null at null
 -
 -   = Beautified calls stack
 -      at Object.assertMapHasOnly (/pro/abase/l0/l5/fMap.s:3887:27)
 -      at Object.routineOptions (/pro/abase/l0/l3/iRoutine.s:407:5)
 -      at wFileProviderHardDrive.storageTerminalDel (/pro/amid/l4_files/l7/ConfigMixin.s:1070:11)
 -      at Object.configDel (/pro/amid/l5/censor/l1/Namespace.s:526:20)
 -< Stderr"
`
  test.true( !_.error._inStr( src ) );

  test.case = 'non-standard prolog';
  var src =
`
Uncaught Error:  = Message of Error#1
No source file found for "W1.js"
Error including source file /workerEnvironment/Worker.js

 = Beautified calls stack
at Object._broInclude (http://127.0.0.1:15000/.starter:6144:17)
at Object._sourceInclude (http://127.0.0.1:15000/.starter:6575:20)
at SourceFile.Worker_js_naked [as nakedCall] (http://127.0.0.1:15000/workerEnvironment/Worker.js:14:1)
at Object._sourceIncludeAct (http://127.0.0.1:15000/.starter:6529:19)
at Worker_js (http://127.0.0.1:15000/workerEnvironment/Worker.js:27:18)
at http://127.0.0.1:15000/workerEnvironment/Worker.js:28:38
`
  test.true( _.error._inStr( src ) );

}

//

function errWithMultilineMessage( test )
{
  test.case = 'multiline error with new line symbols at the begin';
  var got = _.err
  (
    `Error :`,
    `\n    Exec :`,
    `\n\n`,
    `program`,
    `\nend of message`
  );
  var exp =
`Error :
    Exec :

program
end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiline error with new line symbols at the end';
  var got = _.err
  (
    `Error :\n`,
    `    Exec :\n\n`,
    `end of message`
  );
  var exp =
`Error :
Exec :

end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiline error with new line symbols, mixed';
  var got = _.err
  (
    `Error :`,
    `\n    Exec :\n`,
    `\nend of message`
  );
  var exp =
`Error :
    Exec :
end of message`;
  test.identical( got.originalMessage, exp );

}

//

function errMessageWithSpacesAndNewLines( test )
{
  /*
   * err1\n + \nerr2 -> err1\nerr2 // Dmytro : exists
   * err1 + \nerr2 -> err1\nerr2 // Dmytro : exists
   * err1\n + err2 -> err1\nerr2 // Dmytro : exists
   * err1\n\n + \n\nerr2 -> err1\n\nerr2 // Dmytro : exists
   * err1\n + \n\nerr2 -> err1\n\nerr2 // Dmytro : exists
   * err1 + \n\nerr2 -> err1\n\nerr2 // Dmytro : exists
   * err1\n\n + \nerr2 -> err1\n\nerr2 // Dmytro : exists
   * err1\n\n + err2 -> err1\n\nerr2 // Dmytro : exists
   * -
   * err1\n\s\s\n\s + err2 -> err1\n\nerr2 // Dmytro : exists
   * err1\n\n + \n\serr2 -> err1\n\n\serr2 // Dmytro : exists
   */

  test.case = 'strings without spaces and new line symbols';
  var got = _.err
  (
    `Error :`,
    `Exec :`,
    `end of message`
  );
  var exp = `Error : Exec : end of message`;
  test.identical( got.originalMessage, exp );

  /* - */

  test.open( 'only spaces' );

  test.case = 'strings with spaces at the begin of lines';
  var got = _.err
  (
    `  Error :`,
    `  Exec :`,
    `  end of message`
  );
  var exp = `Error : Exec : end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'strings with spaces at the end of lines';
  var got = _.err
  (
    `Error :  `,
    `Exec :  `,
    `end of message  `
  );
  var exp = `Error : Exec : end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'strings with spaces at the begin and at the end of lines';
  var got = _.err
  (
    `  Error :  `,
    `  Exec :  `,
    `  end of message  `
  );
  var exp = `Error : Exec : end of message`;
  test.identical( got.originalMessage, exp );

  test.close( 'only spaces' );

  /* - */

  test.open( 'only new line symbols' );

  test.case = 'single end line symbol at the begin';
  var got = _.err
  (
    `\nError :`,
    `\nExec :`,
    `\nend of message`
  );
  var exp =
`Error :
Exec :
end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'single end line symbol at the end';
  var got = _.err
  (
    `Error :\n`,
    `Exec :\n`,
    `end of message\n`
  );
  var exp =
`Error :
Exec :
end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'single end line symbol at the begin and at the end';
  var got = _.err
  (
    `\nError :\n`,
    `\nExec :\n`,
    `\nend of message\n`
  );
  var exp =
`Error :
Exec :
end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the begin';
  var got = _.err
  (
    `\nError :`,
    `\n\nExec :`,
    `\n\n\nend of message`
  );
  var exp =
`Error :

Exec :


end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the end';
  var got = _.err
  (
    `Error :\n\n\n`,
    `Exec :\n\n`,
    `end of message\n`
  );
  var exp =
`Error :


Exec :

end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the begin and at the end';
  var got = _.err
  (
    `\nError :\n\n\n`,
    `\n\nExec :\n\n`,
    `\n\n\nend of message\n`
  );
  var exp =
`Error :


Exec :


end of message`;
  test.identical( got.originalMessage, exp );

  test.close( 'only new line symbols' );

  /* - */

  test.open( 'message has lines with only spaces and new line symbols' );

  test.case = 'line with single new line symbol';
  var got = _.err
  (
    `Error :`,
    `\n`,
    `\nExec :`,
  );
  var exp =
`Error :
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple new line symbols';
  var got = _.err
  (
    `Error :`,
    `\n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :


Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with single space';
  var got = _.err
  (
    `Error :`,
    ` `,
    `Exec :`,
  );
  var exp = `Error : Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces';
  var got = _.err
  (
    `Error :`,
    `      `,
    `Exec :`,
  );
  var exp = `Error : Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols';
  var got = _.err
  (
    `Error :`,
    ` \n  \n  `,
    `Exec :`,
  );
  var exp =
`Error :

Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line before has new line symbols';
  var got = _.err
  (
    `Error :\n`,
    ` \n\n  \n`,
    `Exec :`,
  );
  var exp =
`Error :


Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line after has new line symbols';
  var got = _.err
  (
    `Error :`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line after has new line symbols';
  var got = _.err
  (
    `Error :`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, lines before and after has new line symbols';
  var got = _.err
  (
    `Error :\n`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, lines before and after has new line symbols';
  var got = _.err
  (
    `Error :\n\n`,
    ` \n \n\n\n`,
    `\n\n\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  test.close( 'message has lines with only spaces and new line symbols' );

  /* - */

  test.open( 'message has spaces which should be saved' );

  test.case = 'a few spaces after new line symbol';
  var got = _.err
  (
    `Error :`,
    `\n  Exec :`,
  );
  var exp =
`Error :
  Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'a few spaces after and inside new line symbols, should be saved the last';
  var got = _.err
  (
    `Error :`,
    `\n  \n \n  Exec :`,
  );
  var exp =
`Error :


  Exec :`;
  test.identical( got.originalMessage, exp );

  test.close( 'message has spaces which should be saved' );

  /* - */

  test.case = 'complex message';
  var got = _.err
  (
    `\n\nError :\n`,
    `\n\n       \n`,
    `  Exec :  `,
    `    `,
    `program`,
    `\n \n\n`
  );
  var exp =
`Error :


Exec : program`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiline message has spaces at the end of inner lines';
  var got = _.err
  (
    `\n\nError :   \n new \n`,
    `\n\n       \n`,
    `  Exec :  `,
    `    `,
    `program`,
    `\n \n\n`
  );
  var exp =
`Error :
 new


Exec : program`;
  test.identical( got.originalMessage, exp );
}

//

function errMessageSecondLineHasNewLineSymbol( test )
{
  test.open( 'second line has only new line symbol and spaces' );

  test.case = 'first line - without spaces and new line symbols, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :`,
    `\n  `,
    `Exec :`,
  );
  var exp =
`Error :
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with new line symbol at the end, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :\n`,
    `\n  `,
    `Exec :`,
  );
  var exp =
`Error :
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with new line symbol at the end, third line - with new line symbol at the begin';
  var got = _.err
  (
    `Error :\n`,
    `\n  `,
    `\nExec :`,
  );
  var exp =
`Error :
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with several new line symbol at the end, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :\n\n`,
    `\n  `,
    `Exec :`,
  );
  var exp =
`Error :

Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with several new line symbols at the end, third line - with several new line symbols at the begin';
  var got = _.err
  (
    `Error :\n\n`,
    `\n  `,
    `\n\nExec :`,
  );
  var exp =
`Error :

Exec :`;
  test.identical( got.originalMessage, exp );

  test.close( 'second line has only new line symbol and spaces' );

  /* - */

  test.open( 'second line has new line symbol at the begin' );

  test.case = 'first line - without spaces and new line symbols, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :`,
    `\nin`,
    `Exec :`,
  );
  var exp =
`Error :
in Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with new line symbol at the end, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :\n`,
    `\nin`,
    `Exec :`,
  );
  var exp =
`Error :
in Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with new line symbol at the end, third line - with new line symbol at the begin';
  var got = _.err
  (
    `Error :\n`,
    `\nin`,
    `\nExec :`,
  );
  var exp =
`Error :
in
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with several new line symbol at the end, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :\n\n`,
    `\nin`,
    `Exec :`,
  );
  var exp =
`Error :

in Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with several new line symbols at the end, third line - with several new line symbols at the begin';
  var got = _.err
  (
    `Error :\n\n`,
    `\nin`,
    `\n\nExec :`,
  );
  var exp =
`Error :

in

Exec :`;
  test.identical( got.originalMessage, exp );

  test.close( 'second line has new line symbol at the begin' );

  /* - */

  test.open( 'second line has new line symbol and spaces at the begin' );

  test.case = 'first line - without spaces and new line symbols, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :`,
    `\n  in`,
    `Exec :`,
  );
  var exp =
`Error :
  in Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with new line symbol at the end, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :\n`,
    `\n  in`,
    `Exec :`,
  );
  var exp =
`Error :
  in Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with new line symbol at the end, third line - with new line symbol at the begin';
  var got = _.err
  (
    `Error :\n`,
    `\n  in`,
    `\nExec :`,
  );
  var exp =
`Error :
  in
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with several new line symbol at the end, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :\n\n`,
    `\n  in`,
    `Exec :`,
  );
  var exp =
`Error :

  in Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with several new line symbols at the end, third line - with several new line symbols at the begin';
  var got = _.err
  (
    `Error :\n\n`,
    `\n  in`,
    `\n\nExec :`,
  );
  var exp =
`Error :

  in

Exec :`;
  test.identical( got.originalMessage, exp );

  test.close( 'second line has new line symbol and spaces at the begin' );

  /* - */

  test.open( 'second line has new line symbol and spaces at the end' );

  test.case = 'first line - without spaces and new line symbols, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :`,
    `in  \n`,
    `Exec :`,
  );
  var exp =
`Error : in
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with new line symbol at the end, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :\n`,
    `in  \n`,
    `Exec :`,
  );
  var exp =
`Error :
in
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with new line symbol at the end, third line - with new line symbol at the begin';
  var got = _.err
  (
    `Error :\n`,
    `in  \n`,
    `\nExec :`,
  );
  var exp =
`Error :
in
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with several new line symbol at the end, third line - without spaces and new line symbols';
  var got = _.err
  (
    `Error :\n\n`,
    `in  \n`,
    `Exec :`,
  );
  var exp =
`Error :

in
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'first line - with several new line symbols at the end, third line - with several new line symbols at the begin';
  var got = _.err
  (
    `Error :\n\n`,
    `in  \n`,
    `\n\nExec :`,
  );
  var exp =
`Error :

in

Exec :`;
  test.identical( got.originalMessage, exp );

  test.close( 'second line has new line symbol and spaces at the end' );
}

//

function errBriefFromStrings( test )
{
  test.case = 'strings without spaces and new line symbols';
  var got = _.error.brief
  (
    `Error :`,
    `Exec :`,
    `end of message`
  );
  var exp = `Error : Exec : end of message`;
  test.identical( got.originalMessage, exp );

  /* - */

  test.open( 'only spaces' );

  test.case = 'strings with spaces at the begin of lines';
  var got = _.error.brief
  (
    `  Error :`,
    `  Exec :`,
    `  end of message`
  );
  var exp = `Error : Exec : end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'strings with spaces at the end of lines';
  var got = _.error.brief
  (
    `Error :  `,
    `Exec :  `,
    `end of message  `
  );
  var exp = `Error : Exec : end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'strings with spaces at the begin and at the end of lines';
  var got = _.error.brief
  (
    `  Error :  `,
    `  Exec :  `,
    `  end of message  `
  );
  var exp = `Error : Exec : end of message`;
  test.identical( got.originalMessage, exp );

  test.close( 'only spaces' );

  /* - */

  test.open( 'only new line symbols' );

  test.case = 'single end line symbol at the begin';
  var got = _.error.brief
  (
    `\nError :`,
    `\nExec :`,
    `\nend of message`
  );
  var exp =
`Error :
Exec :
end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'single end line symbol at the end';
  var got = _.error.brief
  (
    `Error :\n`,
    `Exec :\n`,
    `end of message\n`
  );
  var exp =
`Error :
Exec :
end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'single end line symbol at the begin and at the end';
  var got = _.error.brief
  (
    `\nError :\n`,
    `\nExec :\n`,
    `\nend of message\n`
  );
  var exp =
`Error :
Exec :
end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the begin';
  var got = _.error.brief
  (
    `\nError :`,
    `\n\nExec :`,
    `\n\n\nend of message`
  );
  var exp =
`Error :

Exec :


end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the end';
  var got = _.error.brief
  (
    `Error :\n\n\n`,
    `Exec :\n\n`,
    `end of message\n`
  );
  var exp =
`Error :


Exec :

end of message`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the begin and at the end';
  var got = _.error.brief
  (
    `\nError :\n\n\n`,
    `\n\nExec :\n\n`,
    `\n\n\nend of message\n`
  );
  var exp =
`Error :


Exec :


end of message`;
  test.identical( got.originalMessage, exp );

  test.close( 'only new line symbols' );

  /* - */

  test.open( 'message has lines with only spaces and new line symbols' );

  test.case = 'line with single new line symbol';
  var got = _.error.brief
  (
    `Error :`,
    `\n`,
    `\nExec :`,
  );
  var exp =
`Error :
Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple new line symbols';
  var got = _.error.brief
  (
    `Error :`,
    `\n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :


Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with single space';
  var got = _.error.brief
  (
    `Error :`,
    ` `,
    `Exec :`,
  );
  var exp = `Error : Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces';
  var got = _.error.brief
  (
    `Error :`,
    `      `,
    `Exec :`,
  );
  var exp = `Error : Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols';
  var got = _.error.brief
  (
    `Error :`,
    ` \n  \n  `,
    `Exec :`,
  );
  var exp =
`Error :

Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line before has new line symbols';
  var got = _.error.brief
  (
    `Error :\n`,
    ` \n\n\n  \n`,
    `Exec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line after has new line symbols';
  var got = _.error.brief
  (
    `Error :`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line after has new line symbols';
  var got = _.error.brief
  (
    `Error :`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, lines before and after has new line symbols';
  var got = _.error.brief
  (
    `Error :\n`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, lines before and after has new line symbols';
  var got = _.error.brief
  (
    `Error :\n\n`,
    ` \n \n\n\n`,
    `\n\n\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  test.identical( got.originalMessage, exp );

  test.close( 'message has lines with only spaces and new line symbols' );

  /* - */

  test.open( 'message has spaces which should be saved' );

  test.case = 'a few spaces after new line symbol';
  var got = _.error.brief
  (
    `Error :`,
    `\n  Exec :`,
  );
  var exp =
`Error :
  Exec :`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'a few spaces after and inside new line symbols, should be saved the last';
  var got = _.error.brief
  (
    `Error :`,
    `\n  \n \n  Exec :`,
  );
  var exp =
`Error :


  Exec :`;
  test.identical( got.originalMessage, exp );

  test.close( 'message has spaces which should be saved' );

  /* - */

  test.case = 'complex message';
  var got = _.error.brief
  (
    `\n\nError :\n`,
    `\n\n       \n`,
    `  Exec :  `,
    `    `,
    `program`,
    `\n \n\n`
  );
  var exp =
`Error :


Exec : program`;
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiline message has spaces at the end of inner lines';
  var got = _.error.brief
  (
    `\n\nError :   \n new \n`,
    `\n\n       \n`,
    `  Exec :  `,
    `    `,
    `program`,
    `\n \n\n`
  );
  var exp =
`Error :
 new


Exec : program`;
  test.identical( got.originalMessage, exp );
}

//

function errBriefFromErr( test )
{
  test.case = 'strings without spaces and new line symbols';
  var err = _.err
  (
    `Error :`,
    `Exec :`,
    `end of message`
  );
  var exp = `Error : Exec : end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* - */

  test.open( 'only spaces' );

  test.case = 'strings with spaces at the begin of lines';
  var err = _.err
  (
    `  Error :`,
    `  Exec :`,
    `  end of message`
  );
  var exp = `Error : Exec : end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'strings with spaces at the end of lines';
  var err = _.err
  (
    `Error :  `,
    `Exec :  `,
    `end of message  `
  );
  var exp = `Error : Exec : end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'strings with spaces at the begin and at the end of lines';
  var err = _.err
  (
    `  Error :  `,
    `  Exec :  `,
    `  end of message  `
  );
  var exp = `Error : Exec : end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  test.close( 'only spaces' );

  /* - */

  test.open( 'only new line symbols' );

  test.case = 'single end line symbol at the begin';
  var err = _.err
  (
    `\nError :`,
    `\nExec :`,
    `\nend of message`
  );
  var exp =
`Error :
Exec :
end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'single end line symbol at the end';
  var err = _.err
  (
    `Error :\n`,
    `Exec :\n`,
    `end of message\n`
  );
  var exp =
`Error :
Exec :
end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'single end line symbol at the begin and at the end';
  var err = _.err
  (
    `\nError :\n`,
    `\nExec :\n`,
    `\nend of message\n`
  );
  var exp =
`Error :
Exec :
end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the begin';
  var err = _.err
  (
    `\nError :`,
    `\n\nExec :`,
    `\n\n\nend of message`
  );
  var exp =
`Error :

Exec :


end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the end';
  var err = _.err
  (
    `Error :\n\n\n`,
    `Exec :\n\n`,
    `end of message\n`
  );
  var exp =
`Error :


Exec :

end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiple end line symbols at the begin and at the end';
  var err = _.err
  (
    `\nError :\n\n\n`,
    `\n\nExec :\n\n`,
    `\n\n\nend of message\n`
  );
  var exp =
`Error :


Exec :


end of message`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  test.close( 'only new line symbols' );

  /* - */

  test.open( 'message has lines with only spaces and new line symbols' );

  test.case = 'line with single new line symbol';
  var err = _.err
  (
    `Error :`,
    `\n`,
    `\nExec :`,
  );
  var exp =
`Error :
Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple new line symbols';
  var err = _.err
  (
    `Error :`,
    `\n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :


Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with single space';
  var err = _.err
  (
    `Error :`,
    ` `,
    `Exec :`,
  );
  var exp = `Error : Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces';
  var err = _.err
  (
    `Error :`,
    `      `,
    `Exec :`,
  );
  var exp = `Error : Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols';
  var err = _.err
  (
    `Error :`,
    ` \n  \n  `,
    `Exec :`,
  );
  var exp =
`Error :

Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line before has new line symbols';
  var err = _.err
  (
    `Error :\n`,
    ` \n\n\n  \n`,
    `Exec :`,
  );
  var exp =
`Error :



Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line after has new line symbols';
  var err = _.err
  (
    `Error :`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, line after has new line symbols';
  var err = _.err
  (
    `Error :`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, lines before and after has new line symbols';
  var err = _.err
  (
    `Error :\n`,
    ` \n \n\n\n`,
    `\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'line with multiple spaces and new line symbols, lines before and after has new line symbols';
  var err = _.err
  (
    `Error :\n\n`,
    ` \n \n\n\n`,
    `\n\n\nExec :`,
  );
  var exp =
`Error :



Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  test.close( 'message has lines with only spaces and new line symbols' );

  /* - */

  test.open( 'message has spaces which should be saved' );

  test.case = 'a few spaces after new line symbol';
  var err = _.err
  (
    `Error :`,
    `\n  Exec :`,
  );
  var exp =
`Error :
  Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'a few spaces after and inside new line symbols, should be saved the last';
  var err = _.err
  (
    `Error :`,
    `\n  \n \n  Exec :`,
  );
  var exp =
`Error :


  Exec :`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  test.close( 'message has spaces which should be saved' );

  /* - */

  test.case = 'complex message';
  var err = _.err
  (
    `\n\nError :\n`,
    `\n\n       \n`,
    `  Exec :  `,
    `    `,
    `program`,
    `\n \n\n`
  );
  var exp =
`Error :


Exec : program`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );

  /* */

  test.case = 'multiline message has spaces at the end of inner lines';
  var err = _.err
  (
    `\n\nError :   \n new \n`,
    `\n\n       \n`,
    `  Exec :  `,
    `    `,
    `program`,
    `\n \n\n`
  );
  var exp =
`Error :
 new


Exec : program`;
  var got = _.error.brief( err );
  test.identical( got.originalMessage, exp );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.Err.l0.l1',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suiteTempPath : null,
    assetsOriginalPath : null,
    appJsPath : null,
  },

  tests :
  {

    dichotomysBasic,
    dichotomyBriefUnbrief,

    _errTrowsError,
    _errEmptyArgs,
    _errArgsHasError,
    _errArgsHasRoutine,
    _errLocation,
    _errOptionBrief,
    _errOptionReason,
    _errOptionId,
    _errCatchesForm,
    _originalMessage,
    _errMessageForm,
    _errOptionConcealedBasic,
    errCatchStackAndMessage,
    errErrorWithoutStack,
    errCustomError,

    _inStr,
    errWithMultilineMessage,
    errMessageWithSpacesAndNewLines,
    errMessageSecondLineHasNewLineSymbol,

    errBriefFromStrings,
    errBriefFromErr,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
