( function _Buffer_From_Stream_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../../node_modules/Tools' );
  require( '../image/entry/Reader.s' );
  _.include( 'wTesting' );
}

const _ = _global_.wTools;
let bufferFromStream = require( __dirname + '/../image/l5_reader/BufferFromStream.s' );

// --
// context
// --

function onSuiteBegin( test )
{
  let context = this;

  context.suiteTempPath = _.path.tempOpen( _.path.join( __dirname, '../..' ), 'ImageRead' );
  context.assetsOriginalPath = _.path.join( __dirname, '_asset' );

}

//

function onSuiteEnd( test )
{
  let context = this;

  _.assert( _.strHas( context.suiteTempPath, '/ImageRead' ) )
  _.path.tempClose( context.suiteTempPath );

}

// --
// tests
// --

function bufferFromStream_( test )
{
  test.case = 'test';
  let stream = _.fileProvider.streamRead
  ({
    filePath : __dirname + '/_asset/basic/Pixels-2x2.png',
    encoding : 'buffer.raw',
  });
  test.true( _.streamIs( stream ) );
  let ready = bufferFromStream({ src : stream });
  test.true( _.consequenceIs( ready ))

  ready.then( ( data ) =>
  {
    // test.true( _.bufferRawIs( data ) );
    test.true( _.bufferNodeIs( data ) );
    return null;
  } );

  return ready;
}

//

function bufferFromStreamThrowing( test )
{
  let ready = new _.Consequence().take( null );

  test.case = 'throwing';
  var src = { src : 'stream' };
  test.shouldThrowErrorSync( () => bufferFromStream( src ) );

  // test.case = 'throwing in stream reader'
  // var src = _.fileProvider.streamRead
  // ({
  //   filePath : '/WRONG',
  //   encoding : 'buffer.raw',
  // });
  // test.shouldThrowErrorOfAnyKind( () => bufferFromStream({ src }) );


}

// --
// declare
// --

const Proto =
{

  name : 'bufferFromStream',
  silencing : 1,
  enabled : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suiteTempPath : null,
    assetsOriginalPath : null,
    appJsPath : null,
    ext : 'png',
    inFormat : 'png',
  },

  tests :
  {
    bufferFromStream_,
    bufferFromStreamThrowing
  },

}

//

const Self = wTestSuite( Proto )
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );
})()
