if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var eulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var quadrant = [ 0, 1, 2, 3 ];
var quadrantLock = [ 0 ];
var accuracy = _.EPS;
var accuracy2 = _.EPS2;
var delta = [ -0.1, -Math.sqrt( accuracy ), -( accuracy2 ), 0, +( accuracy2 ), +Math.sqrt( accuracy ), +0.1 ];
var deltaLock = [ 0 ];
var T = 0;
var F = 0;

// debugger;
// function onEach( euler, eulerEmpty )
// {
//   var dstEuler = euler.slice();
//   dstEuler[ 0 ] = 0;
//   dstEuler[ 1 ] = 0;
//   dstEuler[ 2 ] = 0;
//   var expected = _.euler.toQuat2( euler );
//   euler2 = _.euler.fromQuat2( expected, dstEuler );
//   var result = _.euler.toQuat2( euler2 );
//
//   var positiveResult = result.slice();
//   var negativeResult = _.avector.mul( _.vad.toArray( result ), -1 );
//   var expected = _.vad.toArray( expected );
//   var eq1 = _.entityEquivalent( positiveResult, expected, { accuracy : accuracy } );
//   var eq2 = _.entityEquivalent( negativeResult, expected, { accuracy : accuracy } );
//
//   if( eq1 === true || eq2 === true )
//   { T = T+1; }
//   else
//   {
//     result = _.vad.toArray( result );
//     expected = _.vad.toArray( expected );
//     console.log( 'euler: ', euler[ 0 ],euler[ 1 ],euler[ 2 ], euler[ 3 ],euler[ 4 ],euler[ 5 ] );
//     console.log( 'q1: ', expected[ 0 ], expected[ 1 ], expected[ 2 ], expected[ 3 ] );
//     console.log( 'q2: ', result[ 0 ], result[ 1 ], result[ 2 ], result[ 3 ] );
//     F = F +1; }
//   }
//
//
// for( var i = 0; i < eulerSeqs.length; i++ )
// {
//   var seq = eulerSeqs[ i ];
//   console.log('SEQUENCE ******************** ',seq);
//   var euler = [ 0, 0, 0, 0, 0, 0 ];
//   euler = _.euler.make2( euler, seq );
//   for( var ang = 0; ang < angle.length; ang++ )
//   {
//     for( var quad = 0; quad < quadrant.length; quad++ )
//     {
//       for( var d = 0; d < delta.length; d++ )
//       {
//         euler[ 0 ] = angle[ ang ] + quadrant[ quad ]*Math.PI/2 + delta[ d ];
//         for( var ang2 = 0; ang2 < angle.length; ang2++ )
//         {
//           for( var quad2 = 0; quad2 < quadrant.length; quad2++ )
//           {
//             for( var d2 = 0; d2 < delta.length; d2++ )
//             {
//               euler[ 1 ] = angle[ ang2 ] + quadrant[ quad2 ]*Math.PI/2 + delta[ d2 ];
//               for( var ang3 = 0; ang3 < angle.length; ang3++ )
//               {
//                 for( var quad3 = 0; quad3 < quadrantLock.length; quad3++ )
//                 {
//                   for( var d3 = 0; d3 < deltaLock.length; d3++ )
//                   {
//                     euler[ 2 ] = angle[ ang3 ] + quadrantLock[ quad3 ]*Math.PI/2 + deltaLock[ d3 ];
//                     var eulerEmpty = _.euler.make2( null, seq );
//                     onEach( euler );
//                   }
//                 }
//               }
//             }
//           }
//         }
//       }
//     }
//   }
// }


console.log( 'T = ', T);
console.log( 'F = ', F);
