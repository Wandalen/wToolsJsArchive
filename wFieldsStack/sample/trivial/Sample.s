
if( typeof module !== 'undefined' )
{
  require( 'wTools' );
  require( 'wfieldsstack' );
  require( 'wCopyable' );
}

let _ = wTools;

console.log( 'wFieldsStack mixin included' );

/*
!!! write sample of mixin it in
*/

function declareMixinClass()
{

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
  let Extension =
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
    extend : Extension,
  });

  /* Mixin */

  _.Copyable.mixin( SampleClass );
  _.FieldsStack.mixin( SampleClass );

  let sample = new SampleClass();
  return sample;
}

/* Instance of the class */

// var sample = _.FieldsStack.__mixin__.prototype.declareMixinClass( );
let sample = declareMixinClass();
logger.log( 'Initial class' )
logger.log( sample )

/* Add new fields */
var newFields =
{
  field1 : null,
  field2 : null,
}
sample.fieldPush( newFields );
logger.log( '' )
logger.log( 'New fields set' )
logger.log( sample )

/* Change fields value */

newFields =
{
  field1 : 'Hi',
  field2 : 'World',
}
sample.fieldPush( newFields );
logger.log( '' )
logger.log( 'New fields set' );
logger.log( sample );

//Reset fields
sample.fieldPop( newFields );
logger.log( '' );
logger.log( 'New fields reset' );
logger.log( sample );
