if( typeof module !== 'undefined' )
// require( '..' );
var wBitmask = require( 'wBitmask' );

let _ = wTools;

var defaultFieldsArray =
[

  { hidden : false },
  { system : false },
  { terminal : true },
  { directory : false },
  { link : true },

];

var bitmask = wBitmask
({
  defaultFieldsArray
});

console.log( 'bitmask' )
console.log( bitmask.toStr() );

var originalMap =
{
  hidden : 1,
  terminal : 0,
  directory : 1,
}

console.log( 'originalMap :\n' + _.entity.exportString( originalMap ) );

var word = bitmask.mapToWord( originalMap );

console.log( 'word : ' + word );

var restoredMap = bitmask.wordToMap( word );

console.log( 'restoredMap :\n' + _.entity.exportString( restoredMap ) );
