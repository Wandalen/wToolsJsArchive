if( typeof module !== 'undefined' )
var LoggerFromAsciiToCss = require( 'wloggerfromansitocss' );

let _ = wTools;
var logger = new LoggerFromAsciiToCss({ output : console });

logger.log( _.ct.fg( 'text', 'red' ) );

// %ctext color:rgba(255,51,0,1);
