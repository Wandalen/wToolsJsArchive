if( typeof module !== 'undefined' )
require( 'wDeployer' );

var _ = wTools;

var deployer = new wDeployer();
deployer.read( __dirname );
