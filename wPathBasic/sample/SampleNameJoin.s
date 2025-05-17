
if( typeof module !== 'undefined' )
require( 'wpathbasic' );
let _ = wTools;

var name = _.path.joinNames( '/a', './b/' );
/* returns : '/a/b' */
console.log( 'name is ' + name );
