if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var sphere = [ 0, 2, 2, 2, 2, 2, 4 ];
var Oldsphere = [ 0, 2, 2, 2, 2, 2, 4 ];
var vsphere = _.vad.from(sphere);
var radius = 3;

debugger;

var sphereR = _.sphere.radiusSet( sphere, radius );
var vsphereR = _.sphere.radiusSet( vsphere, radius );

console.log('Array - Sphere:',Oldsphere,' - Radius: ', radius,' - New Sphere: ', sphereR);
console.log('Vector - Sphere:',Oldsphere,' - Radius: ', radius,' - New Sphere: ', vsphereR);

debugger;
