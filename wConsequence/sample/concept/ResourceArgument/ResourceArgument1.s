let _ = require( 'wTools' );
require( 'wConsequence' );

var con = new _.Consequence();

con.take( [ 1, 2, 3 ] );

// .resourcesGet() returns an array of resources
console.log( con.resourcesGet().length ); // logs: 1

console.log( con.resourcesGet()[ 0 ] ); // logs: [Object: null prototype] { error: undefined, argument: [ 1, 2, 3 ] }
