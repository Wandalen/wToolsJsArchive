let _ = require( 'wTools' );
require( 'wConsequence' );

var con = new _.Consequence();

con.then( ( arg ) =>
{
  console.log( arg );
  return 'from then';
} );

// the passed resource-argument will not be processed by .catch() competitor
con.catch( ( err ) =>
{
  console.log( err );
  return 'from error';
} );

con.take( [ 1, 2, 3 ] ); // logs: [ 1, 2, 3 ]
