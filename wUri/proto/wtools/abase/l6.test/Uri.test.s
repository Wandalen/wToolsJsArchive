( function _Uri_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( 'Tools' );

  _.include( 'wTesting' );

  require( '../../abase/l6/Include.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// tests
// --

function routinesOfUriBasic( test )
{
  test.case = 'namespace _.uri';
  test.true( _.routineIs( _.uri.parse ) );
  test.true( _.routineIs( _.uri.parseAtomic ) );
  test.true( _.routineIs( _.uri.parseConsecutive ) );
  test.true( _.routineIs( _.uri.str ) );
  test.true( _.routineIs( _.uri.full ) );
  test.true( _.routineIs( _.uri.normalizeTolerant ) );
  test.true( _.routineIs( _.uri.rebase ) );
  test.true( _.routineIs( _.uri.documentGet ) );
  test.true( _.routineIs( _.uri.server ) );
  test.true( _.routineIs( _.uri.query ) );
  test.true( _.routineIs( _.uri.dequery ) );

  test.case = 'namespace _.uri.s';
  test.true( _.routineIs( _.uri.s.parse ) );
  test.true( _.routineIs( _.uri.s.parseAtomic ) );
  test.true( _.routineIs( _.uri.s.parseConsecutive ) );
  test.true( _.routineIs( _.uri.s.onlyParse ) );
  test.true( _.routineIs( _.uri.s.onlyParseAtomic ) );
  test.true( _.routineIs( _.uri.s.onlyParseConsecutive ) );
  test.true( _.routineIs( _.uri.s.str ) );
  test.true( _.routineIs( _.uri.s.full ) );
  test.true( _.routineIs( _.uri.s.normalizeTolerant ) );
  test.true( _.routineIs( _.uri.s.onlyNormalizeTolerant ) );
  test.true( _.routineIs( _.uri.s.rebase ) );
  test.true( _.routineIs( _.uri.s.documentGet ) );
  test.true( _.routineIs( _.uri.s.server ) );
  test.true( _.routineIs( _.uri.s.query ) );
  test.true( _.routineIs( _.uri.s.dequery ) );
}

//

function routinesOfWebUriBasic( test )
{
  test.case = 'namespace _.weburi';
  test.true( _.routineIs( _.weburi.isAbsolute ) );
  test.true( _.routineIs( _.weburi.join ) );
  test.true( _.routineIs( _.weburi.joinRaw ) );
  test.true( _.routineIs( _.weburi.resolve ) );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l6.Uri',
  silencing : 1,

  tests :
  {

    routinesOfUriBasic,
    routinesOfWebUriBasic,

  },

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
