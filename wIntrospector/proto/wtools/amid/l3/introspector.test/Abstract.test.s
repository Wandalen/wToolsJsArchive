( function _Introspector_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../../node_modules/Tools' );
  _.include( 'wTesting' );
  require( '../../l3/introspector/module/Full.s' );

}

//

const _ = _global_.wTools;
var fileProvider = _.fileProvider;
var path = fileProvider.path;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.suiteTempPath = path.tempOpen( path.join( __dirname, '../..' ), 'err' );
  self.assetsOriginalPath = path.join( __dirname, '_asset' );

}

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.suiteTempPath, '/err-' ) )
  path.tempClose( self.suiteTempPath );
}

// --
// assets
// --

// --
// tests
// --

function prefferedParsers( test )
{
  let context = this;
  let sourceCode = context.defaultProgramSourceCode;

  test.true( _.introspector.Parser.Default === undefined );
  test.true( _.constructorIs( context.defaultParser ) );
  test.true( _.arrayIs( context.exts ) );

  context.exts.forEach( ( ext ) => run( ext ) );

  function run( ext )
  {
    let prefferedParsers = [ context.defaultParser ];
    let sys = _.introspector.System({ prefferedParsers });
    let file = _.introspector.File({ data : sourceCode, filePath : `/Program.${ext}`, sys });
    let Parser = sys.parserClassFor( file );
    test.true( Parser === context.defaultParser );
  }
}

prefferedParsers.description =
`
Field prefferedParsers of system allows setting preffered parser
`

// --
// declare
// --

const Proto =
{

  name : 'Tools.mid.Introspector',
  silencing : 1,
  abstract : 1,
  routineTimeOut : 30000,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {

    suiteTempPath : null,
    assetsOriginalPath : null,
    appJsPath : null,
    defaultParser : null,
    defaultProgramSourceCode : null,

  },

  tests :
  {
    prefferedParsers,
  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
