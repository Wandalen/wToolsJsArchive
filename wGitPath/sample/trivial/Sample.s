
if( typeof 'module' !== undefined )
require( 'wgitpath' );

let _ = wTools;

/* */

var srcPath = 'https://github.com/someorg/somerepo.git';
var normalized = _.git.path.normalize( srcPath );
console.log( normalized );
/* log : git+https:///github.com/someorg/somerepo.git */

