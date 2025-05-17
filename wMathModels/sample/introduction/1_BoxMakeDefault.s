if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var box = _.box.make();
console.log( `Type : ${ _.entity.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 0, 0, 0, 0, 0 ] */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
