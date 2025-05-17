(function(){

var _ = _global_.wTools;
var $ = jQuery;

//

//function loadDialog( name,onReady,context )
function loadDialog( options )
{
  var optionsDefault =
  {
    name : '',
    title : 'Please, select files',
    multiple : 1,
  }

  var options = options || {};

  if( _.strIs( options ) )
  options = { title : options };

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.objectIs( options ) );
  _.assertMapHasOnly( options,optionsDefault );
  _.mapSupplement( options,optionsDefault );

  var con = new _.Consequence();

  var a = $( '<input>' )
  .css( 'display','none' ).appendTo( $('body') )
  .attr( 'type','file' )
  .attr( 'name',options.title )
  .attr( 'title',options.title )
  .attr( 'value',options.title )
  .change( function( event )
  {

    var t = this;
    var files = a[ 0 ].files;
    a.remove();

    var e =
    {
      title : options.title,
      name : options.name,
      files : files,
    }

    con.give( e );

  })
  ;

  if( options.multiple )
  a.attr( 'multiple','' )
  ;

  var event = document.createEvent( 'MouseEvents' );
  event.initMouseEvent( 'click', true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null );
  a[ 0 ].dispatchEvent( event );

  return con;
}

//

function uploadFiles( files,options )
{

  if( _.objectIs( arguments[ 0 ] ) )
  {
    options = arguments[ 0 ];
    files = options.files;
  }

  _.assertMapHasOnly( options,uploadFiles.defaults );
  _.mapComplement( options,uploadFiles.defaults );

  var options = options || {};
  var files = options.files = files || options.files;
  if( !( files instanceof FileList ) )
  files = _.arrayAs( files );

  _.assert( _.strIs( options.url ) );

  var formData = new FormData();

  options.names = [];

  for( var f = 0; f < files.length; f++ )
  {

    var file = files[ f ];
    var name = file.name || file.filename || '_nameless_';
    formData.append( name, file, name );
    options.names.push( name );

  }

  if( options.fields )
  {
    for( var f in options.fields )
    {
      formData.append( f, JSON.stringify( options.fields[ f ] ) );
    }
  }

  if( options.onBegin )
  {
    options.onBegin.call( this, null, null, options );
  }

  $.ajax
  ({

    url           : options.url,
    async         : true,
    data          : formData,
    crossDomain   : !!options.crossDomain,
    processData   : false,
    cache         : false,
    contentType   : false,
    type          : 'POST',

    success       : function ( data )
    {

      /*debugger;*/
      if( options.onEnd )
      options.onEnd.call( this, null, data, options );

    },

    error         : function ( request )
    {

      /*debugger;*/
      var err = _.err( 'upload : cant upload','( ',options.names.join( ' , ' ),' )',request.responseText );
      _.errLog( err );
      if( options.onEnd )
      options.onEnd.call( this, err, null, options );

    },

  });

  return options;
}

uploadFiles.defaults =
{

  url : '/upload',

  crossDomain : 1,

  files : null,
  fields : null,

  onBegin : null,
  onEnd : null,

}

//

function urlSave( url,name )
{

  //$( '<iframe ></iframe>' )
  var a = $( '<a></a>' )
    .css( 'display','none' ).appendTo( $('body') )
    .attr( 'download',name )
    .attr( 'title',name )
    .attr( 'value',name )
    .attr( 'src',url )
    .attr( 'href',url )
//    .click()
//    .remove();
  ;
  //window.location = url

  var event = document.createEvent( 'MouseEvents' );
  event.initMouseEvent( 'click', true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null );
  a[ 0 ].dispatchEvent( event );
  //window.open( url, '_blank', '' );

}

//

function blobSave( blob,name )
{

  //saveAs = undefined; // xxx

  if( typeof saveAs !== 'undefined' )
  {

    //if( typeof saveAs === 'undefined' ) throw 'blobSave : saveAs is not implemented';
    //var blob = new Blob(["Hello, world!"], {type: "text/plain;charset=utf-8"});
    return saveAs( blob, name );

  }
  else
  {

    throw 'blobSave : saveAs is not implemented';

  }

}

//

function textSave( text,name )
{

  var blob = new Blob( [text], {type: "text/plain;charset=utf-8"} );
  return blobSave( blob, name );

}

// --
// proto
// --

var Proto =
{

  // load
  loadDialog: loadDialog,
  uploadFiles: uploadFiles,

  // save
  urlSave: urlSave,
  blobSave: blobSave,
  textSave: textSave,


}

_.mapExtend( _,Proto );

})();
