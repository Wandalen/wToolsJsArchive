
if( typeof module !== 'undefined' )
require( 'wnamemapper' );

let _ = wTools;

var nameMapper = new wNameMapper().set
({
  Points : 5001,
  LineStrip : 5002,
  LineLoop : 5003,
  Lines : 5004,
  TriangleStrip : 5005,
  TriangleFan : 5006,
  Triangles : 5007,
});

// console.log( 'nameMapper.valueToKeyMap',nameMapper.valueToKeyMap );
// console.log( 'nameMapper.keyToValueMap',nameMapper.keyToValueMap );

var valueForPoints = nameMapper.forKey( 'Points' )
console.log( 'valueForPoints :', valueForPoints );
// valueForPoints : 5001

var key = nameMapper.forVal( valueForPoints )
console.log( 'key :', key );
// key : Points

var values = nameMapper.forKeys([ 'Points', 'Lines' ])
console.log( 'values :', values );
// values : 5001, 5004
