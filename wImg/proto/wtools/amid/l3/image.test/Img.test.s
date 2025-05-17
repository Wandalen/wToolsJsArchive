( function _Img_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( 'Tools' );

  _.include( 'wTesting' );

  require( '../image/entry/Img.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// tests
// --

function routinesOfImage( test )
{
  test.case = 'routines _.image.*';
  test.true( _.routineIs( _.image.readHead ) );
  test.true( _.routineIs( _.image.read ) );
  test.true( _.routineIs( _.image.fileRead ) );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.mid.l4.img',
  silencing : 1,

  tests :
  {

    routinesOfImage,

  },

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
