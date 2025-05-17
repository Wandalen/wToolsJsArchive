
if( typeof module !== 'undefined' )
require( 'wpathbasic' );

//

let _ = wTools;

// Refine

var path = '../../foo/bar/';
var got = _.path.isRefined( path );
/* returns true when the path has slash ( / ) in the end . */

logger.log( 'isRefined', got );

var path = '../../foo/bar';
var got = _.path.isRefined( path );
/* checks that the string doesn´t contain left( \\ ) or double slashes ( // ) ). */
logger.log( 'is Refined without trail', got );
logger.log( '' );

// Normalize

var path = '../../foo/bar/';
var got = _.path.isNormalized( path );
/* checks that pass is trailed */

logger.log( 'isNormalized', got );

var path = '../../foo/bar';
var got = _.path.isNormalized( path );
/* checks that pass is normalized( collapsed redundant delimeters and resolved '..' and '.' segments ) */

logger.log( 'is Normalized without trail', got );
logger.log( '' );


logger.log( _.path.normalize( '../..//foo/../bar/' ) );
logger.log( _.path.refine( '../..//foo/../bar/' ) );
