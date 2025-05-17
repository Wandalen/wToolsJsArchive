( function _Deployer_test_s_( ) {

'use strict';

/*

to run this test
from the project directory run

npm install
node ./amid/z.test/Deployer.test.s

*/

if( typeof module !== 'undefined' )
{

  require( 'wTools' );

  try
  {
    require( '../../amid/diagnostic/Testing.debug.s' );
  }
  catch( err )
  {
    require( 'wTesting' );
  }

}

var deployer = require( '../deployer/Deployer.s' )(  );
var fs = require('fs');

var _ = wTools;
var Self = {};

var path = _.dirTempMake( _.dir( __dirname ) );
var fileTestDir = _.resolve( _.realMainDir(), '../file.test' );

//

function cleanTestDir()
{
  _.fileProvider.fileDelete( path );
}

//

var DeployerTest = function( test )
{
  var src = _.join( fileTestDir, 'file.s' );
  var dst = _.join( path, 'file.json' )

  test.description = 'single file path as string ';
  debugger
  deployer.read( src );
  deployer.writeToJson(  dst );
  var got = deployer._tree;
  deployer.readFromJson( dst );
  var expected = deployer._tree;
  test.identical( got,expected );

  test.description = 'single file, path like map property ';
  deployer.read( { file : src } );
  deployer.writeToJson(  { file : dst} );
  var got = deployer._tree;
  deployer.readFromJson( { file : dst} );
  var expected = deployer._tree;
  test.identical( got,expected );


  /**/

  if( Config.debug )
  {

    test.description = 'read : incorrect argument type';
    test.shouldThrowError( function()
    {
      deployer.read( 1 )
    });

    test.description = 'writeToJson : incorrect argument type';
    test.shouldThrowError( function()
    {
      deployer.writeToJson( 0 )
    });



  }
}

//

var Proto =
{

  name : 'Deployer test',
  silencing : 1,

  onSuitEnd : cleanTestDir,

  tests :
  {
    DeployerTest : DeployerTest,
  }

}

_.mapExtend( Self,Proto );
Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
