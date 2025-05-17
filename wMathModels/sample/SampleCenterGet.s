if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var box = [ 0, 0, 2, 2 ];
var point = [ 0, 0 ];
var expected = [ 1, 1 ] ;

debugger;

var centerp = _.box.centerGet( box, point );
var center = _.box.centerGet( box );
//center = Array.from( center );
console.log('expected: ',expected,'result: ',center,' vs ',centerp);

debugger;
