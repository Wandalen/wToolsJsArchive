if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var sphere = [ 0, 0, 3 ];
var Oldsphere = [ 0, 0, 3 ];
var dst = [ 1, 2 ];
var vdst = _.vad.from( dst );
var vsphere = _.vad.from( sphere );

// console.log('Array: ',sphere,' - Vector: ', vsphere );
debugger;

console.log('NO POINT');
console.log('Array');
var asphere = _.sphere.centerGet( sphere );
console.log('center: ', asphere );
console.log('Vector');
var vsphere = _.sphere.centerGet( vsphere );
console.log('center: ', vsphere );

var sphere = [ 0, 0, 3 ];
var Oldsphere = [ 0, 0, 3 ];
var dst = [ 1, 2 ];
var vdst = _.vad.from( dst );
var vsphere = _.vad.from( sphere );

console.log('POINT');
console.log('Array');
var asphered = _.sphere.centerGet( sphere );
console.log('center', asphered,' - dst: ', dst);
console.log('Vector');
var vsphered = _.sphere.centerGet( vsphere );
console.log('center ', vsphered,' - vdst: ', vdst);

debugger;
