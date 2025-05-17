
require( 'wstatesession' );
let _ = wTools;

//

let Self = wSample;
function wSample( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

//

function init( o )
{
  let sample = this;
  _.workpiece.initFields( sample );
}

//

function storageLoaded( storage, op )
{
  let self = this;

  let result = _.StateStorage.prototype.storageLoaded.call( self, { storage, storageFilePath : storage.storageFilePath } );
  self.random = storage.random;
  return result;
}

//

function storageToSave( op )
{
  let self = this;

  let storage = { random : self.random };
  return storage;
}

//

let Associates =
{
  opened : 0,
  storageFileName : _.path.join( __dirname, '../.sample.config.json' ),
  fileProvider : _.define.common( _.fileProvider ),
};

//

let Extend =
{

  init,
  storageLoaded,
  storageToSave,

  Associates,

};

//

_.classDeclare
({
  cls : Self,
  extend : Extend,
});

_.StateStorage.mixin( Self );
_.StateSession.mixin( Self );

//

let sample = new Self();
sample.sessionOpenOrCreate()
if( !sample.random )
sample.random = Math.random();
sample.sessionSave();
console.log( 'sample.random', sample.storageFilePathToLoadGet(), sample.random );

/* comment next line if needs to check storage */
sample.fileProvider.filesDelete( sample.storageFilePathToLoadGet() );

