( function _l0_l9_App_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  _.include( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

//--
//
//--

function bulky( test )
{
  test.true( true );
}

//

function includePerformance( test )
{
  let context = this;
  let a = test.assetFor( false );
  let singlePath = a.program( single ).filePath/*programPath*/;
  let multiplePath = a.program( multiple ).filePath/*programPath*/;
  let t1;

  /* */

  a.ready.then( ( op ) =>
  {
    test.case = 'single';
    t1 = _.time.now();
    return null;
  })
  a.appStartNonThrowing({ execPath : singlePath })
  .then( ( op ) =>
  {
    console.log( _.time.spent( t1 ), 'to run program' );
    test.identical( op.exitCode, 0 );
    return null;
  });

  /* */

  a.ready.then( ( op ) =>
  {
    test.case = 'multiple';
    t1 = _.time.now();
    return null;
  })
  a.appStartNonThrowing({ execPath : multiplePath })
  .then( ( op ) =>
  {
    console.log( _.time.spent( t1 ), 'to run program' );
    test.identical( op.exitCode, 0 );
    return null;
  });

  /* */

  return a.ready;

/*

= Kos single pass, debug:1
0.205s to include wTools
0.299s to run program

= Kos single pass, debug:0
0.174s to include wTools
0.269s to run program

= Kos 100 passes, debug:1
23.013s to include wTools
23.276s to run program

= Kos 100 passes, debug:0
22.896s to include wTools
23.127s to run program

*/

  /* - */

  function single()
  {
    /* global.Config = { debug : false } */
    let t1 = Date.now();
    debugger; /* eslint-disable-line no-debugger */
    const _ = require( toolsPath );
    debugger; /* eslint-disable-line no-debugger */
    console.log( `${( Date.now()-t1 ) / 1000}s to include wTools` );
  }

  /* - */

  function multiple()
  {
    /* global.Config = { debug : false } */
    let t1 = Date.now();
    let i = 0;
    debugger; /* eslint-disable-line no-debugger */
    while( i < 100 )
    {
      let environmentName = 'environment' + i;
      if( i > 0 )
      {
        _globals_.real.wTools.global.new( environmentName, _global_ );
        _globals_.real.wTools.global.open( environmentName );
        _globals_.real.wTools.module.fileSetEnvironment( module, null );
        _globals_.real.wTools.module.fileSetEnvironment( module, environmentName );
      }
      const _ = require( toolsPath );
      if( i > 0 )
      {
        _globals_.real.wTools.global.close( environmentName );
      }
      i += 1;
    }
    console.log( `${( Date.now()-t1 ) / 1000}s to include wTools` );
    debugger; /* eslint-disable-line no-debugger */
  }

  /* - */

}

includePerformance.experimental = 1;
includePerformance.timeOut = 300000;

// --
//
// --

const Proto =
{

  name : 'Tools.App.l0.l9',
  silencing : 1,
  enabled : 1,

  tests :
  {

    bulky,
    includePerformance,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
