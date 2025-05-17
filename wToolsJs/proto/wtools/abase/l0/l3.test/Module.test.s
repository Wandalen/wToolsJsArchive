( function _l0_l3_Module_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../Include3.s' );
  require( 'wTesting' );
}

const _ = _global_.wTools;
const __ = _globals_.testing.wTools;
const fileProvider = __.fileProvider;
const path = fileProvider.path;

// --
// test routines implementation
// --

function bulky( test )
{
  test.true( true );
}

//

function toolsPathGetBasic( test )
{
  let context = this;

  /* */

  test.case = 'toolsPathGet';
  var got = _.module.toolsPathGet();
  var exp = __.path.join( __dirname, '../../../../node_modules/Tools' );
  test.identical( got, exp );
  console.log( `toolsPathGet : ${got}` );

  /* */

  test.case = 'toolsDirGet';
  var got = _.module.toolsDirGet();
  var exp = __.path.join( __dirname, '../../..' );
  test.identical( got, exp );
  console.log( `toolsDirGet : ${got}` );

  /* */

}

//

function toolsPathGetProgram( test )
{
  let context = this;
  let a = test.assetFor( false );
  let program = a.program( programRoutine );

  console.log( 'filePath/*programPath*/', program.filePath/*programPath*/ );
  test.identical( program.group.locals.toolsPath, __.path.nativize( _.module.toolsPathGet() ) );
  test.true( __.strBegins( __.path.normalize( program.group.locals.toolsPath ), __.path.normalize( __dirname + '/../../../..' ) ) );

  return a.forkNonThrowing({ execPath : program.filePath/*programPath*/ })
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var exp =
`
toolsPath : ${__.path.nativize( __.path.join( __dirname, '../../../../node_modules/Tools' ) )}
module.resolve( wTools ) : ${__.path.join( __dirname, '../../../../node_modules/Tools' )}
module.toolsPathGet : ${__.path.join( __dirname, '../../../../node_modules/Tools' )}
module.toolsirGet : ${__.path.join( __dirname, '../../..' )}
`
    test.equivalent( op.output, exp );
    return op;
  });

  function programRoutine()
  {
    console.log( `toolsPath : ${toolsPath}` );
    const _ = require( toolsPath );
    console.log( `module.resolve( wTools ) : ${_.module.resolve( 'wTools' )}` );
    console.log( `module.toolsPathGet : ${_.module.toolsPathGet()}` );
    console.log( `module.toolsirGet : ${_.module.toolsDirGet()}` );
  }

}

toolsPathGetProgram.description =
`
tools path of a program should point tools of real namespace not for testing
`

// --
// test suite declaration
// --

const Proto =
{

  name : 'Tools.Module.l0.l3',
  silencing : 1,
  routineTimeOut : 30000,

  context :
  {
  },

  tests :
  {

    bulky,
    toolsPathGetBasic,
    toolsPathGetProgram,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
