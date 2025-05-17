if( typeof module !== 'undefined' )
{
  require( 'wTools' );
  require( 'wfieldsstack' );
  require( 'wCopyable' );
}

let _ = wTools;
// var _class = _.FieldsStack.__mixin__.prototype;
// console.log( 'wFieldsStack mixin included' );

// /*
// !!! write sample of mixin it in
// */

// var sample = _class.declareMixinClass();
// logger.log( '' )
// logger.log( 'Initial class Sample' )
// logger.log( sample )

// var expected = sample.clone();

// logger.log( '' )
// logger.log( 'Empty class to compare' )
// logger.log( expected )

// logger.log( '' )
// logger.log( 'Sample and Expected are equivalent =', sample.equivalentWith( expected ) );

// var sample = _class.declareMixinClass();
// var expected = _class.declareMixinClass();

// logger.log( '' )
// logger.log( 'Empty class to compare' )
// logger.log( expected )
// debugger;
// logger.log( '' )
// logger.log( 'Sample and Expected are equivalent =', sample.equivalentWith( expected ) ); //Shouldn´t this be true too?

/* Declare class */

let o =
{
  storageFileName : null,
  storageLoaded : null,
  storageToSave : null,
  fields : null,
  fileProvider : null,
}

let Associates =
{
  storageFileName : o.storageFileName,
  fileProvider : _.define.own( o.fileProvider ),
}

function SampleClass( o )
{
  return _.workpiece.construct( SampleClass, this, arguments );
}

function init( o )
{
  _.workpiece.initFields( this );
}
let Extend =
{
  init,
  storageLoaded : o.storageLoaded,
  storageToSave : o.storageToSave,
  Composes : o.fields,
  Associates,
}
_.classDeclare
({
  cls : SampleClass,
  extend : Extend,
});

/* Mixin */
_.Copyable.mixin( SampleClass );
_.FieldsStack.mixin( SampleClass );

var sample = new SampleClass();
var expected = new SampleClass();
logger.log( '' )
logger.log( 'Sample and Expected are equivalent =', sample.equivalentWith( expected ) ); //Shouldn´t this be true too?
// sample = _class.declareMixinClass();
// expected = _class.declareMixinClass();
// logger.log( '' )
// logger.log( 'Sample and Expected are equivalent =', sample.equivalentWith( expected ) ); //Shouldn´t this be true too?
