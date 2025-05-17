if( typeof module !== 'undefined' )
require( 'wDeployer' );

var _ = wTools;
var deployer = new wDeployer();

deployer.read( __dirname );

logger.log( 'tree :\n' + _.toStr( deployer._tree,{ levels : 2, escaping : 1 } ) );

deployer.writeToJson( _.join( __dirname, 'tree.json' ) );

/**/
