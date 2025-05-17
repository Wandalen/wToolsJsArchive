if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var segment = [ 3, 4, 3, 5 ];
var oldsegment = [ 3, 4, 3, 5 ];
var project = [ [ -1, 3 ], 4 ];

var projsegment =  _.segment.project( segment, project )
logger.log( 'Projected to', projsegment );
logger.log('*******************')
var factors = _.segment.getProjectionFactors( oldsegment, projsegment );
logger.log( factors );