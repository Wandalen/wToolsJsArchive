( function _FromAnsiToCss_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  // require( '../../l9/logger/FromAnsiToCss.s' );
  require( '../l1_logger/FromAnsiToCss.s' );

  const _ = _global_.wTools;

  _.include( 'wTesting' );

}

const _ = _global_.wTools;
const Parent = wTools.Testing;
const Proto = {};

//

function trivial( test )
{
  let self = this;

  var got;
  let logger = new _.LoggerFromAnsiToCss({ output : console, onTransformEnd });

  test.case = 'simple text without styles';
  var src = 'text'
  logger.log( src );
  test.identical( got._outputForTerminal[ 0 ], src );

  test.case = 'red text';
  // var src = _.ct.fg( 'text', 'red' );
  var src = '\u001b[91mtext\u001b[39;0m';
  logger.log( src );
  var expected = [ '%ctext', 'color:rgba(255,51,0,1);' ];
  test.identical( got._outputForTerminal, expected );

  test.case = 'red text on black background';
  // var src = _.ct.bg( _.ct.fg( 'text', 'red' ), 'black' );
  var src = '\u001b[91m\u001b[40mtext\u001b[49;0m\u001b[39;0m';
  logger.log( src );
  var expected = [ '%ctext', 'color:rgba(255,51,0,1);background:rgba(0,0,0,1);' ];
  test.identical( got._outputForTerminal, expected );

  test.case = 'red on black inside yellow text';
  // var src = _.ct.fg( 'yellow text' + _.ct.bg( _.ct.fg( 'red text', 'red' ), 'black' ), 'yellow')
  var src = '\u001b[93myellow text\u001b[39;0m\u001b[91m\u001b[40mred text\u001b[49;0m\u001b[39;0m';
  logger.log( src );
  var expected =
  [
    '%cyellow text%cred text',
    'color:rgba(255,255,0,1);',
    'color:rgba(255,51,0,1);background:rgba(0,0,0,1);'
  ]
  test.identical( got._outputForTerminal, expected );

  /* - */

  function onTransformEnd( o ){ got = o };

}

//
``
const Proto =
{

  name : 'Tools.logger.ForBrowser',
  silencing : 1,

  tests :
  {
    trivial
  },


}

//

_.mapExtend( Self, Proto );
const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
