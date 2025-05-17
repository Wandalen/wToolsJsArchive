( function _Path_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( 'Tools' );

  _.include( 'wTesting' );
  _.include( 'wStringer' );

  require( '../../abase/l6/Path.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// tests
// --

function routinesOfPathBasic( test )
{
  test.case = 'namespace _.path';
  test.true( _.routineIs( _.path.like ) );
  test.true( _.routineIs( _.path.isElement ) );
  test.true( _.routineIs( _.path.isSafe ) );
  test.true( _.routineIs( _.path.isGlob ) );
  test.true( _.routineIs( _.path.hasSymbolBase ) );
  test.true( _.routineIs( _.path.prefixGet ) );
  test.true( _.routineIs( _.path.name ) );
  test.true( _.routineIs( _.path.fullName ) );
  test.true( _.routineIs( _.path.ext ) );
  test.true( _.routineIs( _.path.exts ) );
  test.true( _.routineIs( _.path.withoutExt ) );
  test.true( _.routineIs( _.path.changeExt ) );
  test.true( _.routineIs( _.path.join ) );
  test.true( _.routineIs( _.path.joinRaw ) );
  test.true( _.routineIs( _.path.joinIfDefined ) );
  test.true( _.routineIs( _.path.joinCross ) );
  test.true( _.routineIs( _.path.reroot ) );
  test.true( _.routineIs( _.path.resolve ) );
  test.true( _.routineIs( _.path._split ) );
  test.true( _.routineIs( _.path.split ) );
  test.true( _.routineIs( _.path.current ) );
  test.true( _.routineIs( _.path.from ) );
  test.true( _.routineIs( _.path._relative ) );
  test.true( _.routineIs( _.path.relative ) );
  test.true( _.routineIs( _.path.relativeCommon ) );
  test.true( _.routineIs( _.path._commonPair ) );
  test.true( _.routineIs( _.path.common ) );
  test.true( _.routineIs( _.path.rebase ) );

  test.case = 'namespace _.path.s';
  test.true( _.routineIs( _.path.s.are ) );
  test.true( _.routineIs( _.path.s.areAbsolute ) );
  test.true( _.routineIs( _.path.s.areRelative ) );
  test.true( _.routineIs( _.path.s.areGlobal ) );
  test.true( _.routineIs( _.path.s.areGlob ) );
  test.true( _.routineIs( _.path.s.areRefined ) );
  test.true( _.routineIs( _.path.s.areNormalized ) );
}

//

function routinesOfPathTools( test )
{
  test.case = 'routines from PathTools.s';
  test.true( _.routineIs( _.path.mapExtend ) );
  test.true( _.routineIs( _.path.mapSupplement ) );
  test.true( _.routineIs( _.path.mapAppend ) );
  test.true( _.routineIs( _.path.mapPrepend ) );
  test.true( _.routineIs( _.path.mapsPair ) );
  test.true( _.routineIs( _.path.simplify ) );
  test.true( _.routineIs( _.path.simplifyDst ) );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l6.path',
  silencing : 1,

  tests :
  {

    routinesOfPathBasic,
    routinesOfPathTools,

  },

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
