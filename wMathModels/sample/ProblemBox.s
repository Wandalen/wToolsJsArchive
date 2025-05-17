
if( typeof module !== 'undefined' )
require( 'wmathmodels' );
let _ = wTools;

var bbox = _.box.make();
var bboxView = _.vad.from( bbox );
var point = [ 3,3,3 ];
var pointView = _.vad.from( point );

debugger;
_.box.pointExpand( bbox, pointView );
debugger;

var dst = [ Infinity, Infinity, Infinity, -Infinity, -Infinity, -Infinity ];
var point = new Float32Array([ 454.8794860839844, 7893.02783203125, -7698.6318359375 ]);
_.box.pointExpand( dst , point );

console.log( dst );
debugger;
