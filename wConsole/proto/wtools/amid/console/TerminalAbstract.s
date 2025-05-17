( function _TerminalAbstract_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../../BackWithConfig.ss' );
  require( 'include/wtools/abase/l7_mixin/Copyable.s' );
  require( 'include/wtools/abase/l7_mixin/Instancing.s' );
  require( 'include/wtools/abase/l7_mixin/EventHandler.s' );
  require( 'include/wtools/abase/l0/l5/fPath.s' );

  const _ = _global_.wTools;

  _.include( 'wLogger' );

}

//

const _ = _global_.wTools;
const Parent = Object;
const Self = function wTerminalAbstract( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'TerminalAbstract';

//

function init( o )
{
  var self = this;
  var o = o || {};

  _.workpiece.initFields( self );

  Object.preventExtensions( self );

  if( o )
  self.copy( o );

  /* */

  if( !self._conInited )
  self._conInited = new _.Consequence();

  if( !self._conQuestion )
  self._conQuestion = new _.Consequence();

  if( !self._conSyn )
  self._conSyn = new _.Consequence().take( null );

  /* */

  self._historyLoad();

}

//

function prompt()
{

  if( this.isPaused )
  throw _.err( 'ConsoleTerminal', 'is paused' );

}

//

function question( question )
{
  _.assert( arguments.length === 1, 'expects single argument' );

  this._writeOutput( question );
  this.prompt();

  return this._conQuestion;
}

//

function close()
{
  if( this.isClosed )
  return;

  this.pause();

  this.isClosed = true;

  this.eventGive( 'close' );
}

//

function pause()
{
  if( this.isPaused )
  return;

  this.isPaused = true;

  this.eventGive( 'pause' );

  return this;
}

//

function resume()
{
  if( this.isClosed )
  throw _.err( 'Terminal is closed' );

  if( !this.isPaused )
  return;

  this.isPaused = false;
  this.eventGive( 'resume' );

  return this;
}

//

function clear()
{

  throw _.err( 'not implemented' );

}

// --
// etc
// --

function handleStreamData( data )
{
  var self = this;
  self._writtenStream( data );
}

//

function _writtenStream( b )
{
  var self = this;

  const lineEnding = /\r?\n/;

  if( b === undefined )
  return;

  var string = self._decoder ? self._decoder.write( b ) : b;
  if( self._endsReturn )
  {
    string = string.replace( /^\r?\n/, '' );
    self._endsReturn = false;
  }

  var newPartContainsEnding = lineEnding.test( string );

  if( self._strBuffer )
  {
    string = self._strBuffer + string;
    self._strBuffer = null;
  }

  if( newPartContainsEnding )
  {
    self._endsReturn = /\r?\n$/.test( string );

    var lines = string.split( lineEnding );
    string = lines.pop();
    self._strBuffer = string;
    lines.forEach( function( line )
    {
      self._lineEnded( line );
    });
  }
  else if( string )
  {
    self._strBuffer = string;
  }

}

// --
// line
// --

function _lineBegin()
{
  var self = this;

  self.lineCursorOffset( +Infinity );
  self._writeOutput( '\r\n' );
  self.line = '';
  self.inputCursor = 0;
  self.posOfPrevious = [ 0, 0 ];

}

//

function _lineEnd()
{
  var self = this;

  var result = self._lineEnded( self.line );

  self._lineBegin();

  return result;
}

//

function _lineEnded( line )
{
  var self = this;

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.strIs( line ) );

  self.line = line;

  self._historyPrependByCurrent();

  if( self._conQuestion.competitorsEarlyGet().length )
  self._conQuestion.take( line );

  var result = self.eventHandleSingle
  ({
    kind : 'line',
    line,
  });

  return result;
}

//

function _lineRefresh()
{
  var self = this;

  var line = self.textPrompt + self.line;

  self._rewriteInput( line );

  return null;

}

//

function _lineEntered()
{
  var self = this;

  var result = self._lineEnd();

  if( _.consequenceIs( result ) )
  result.finally( _.routineSeal( self, self._lineRefresh, [] ) );
  else
  self._lineRefresh();

}

//

function lineCursorOffset( dx )
{
  var self = this;

  throw _.err( 'not implemented' );

}

//

function _lineInsertString( str )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  throw _.err( 'not implemented' );

}

// --
// history
// --

function _historyPrependByCurrent()
{
  var self = this;
  var line = self.line;

  if( line.length === 0 )
  return '';

  if( self.history.length === 0 || self.history[ 0 ] !== line )
  {

    self.history.unshift( line );
    if( self.history.length > self.historyLimit )
    self.history.pop();

  }

  self.historyIndex = -1;

  self._historyCanged();

  return self.history[ 0 ];
}

//

function _historyNext()
{

  if( this.historyIndex > 0 )
  {
    this.historyIndex--;
    this.line = this.history[ this.historyIndex ];
    this.inputCursor = this.line.length;
    this._lineRefresh();
  }
  else if( this.historyIndex === 0 )
  {
    this.historyIndex = -1;
    this.inputCursor = 0;
    this.line = '';
    this._lineRefresh();
  }

}

//

function _historyPrev()
{
  if( this.historyIndex + 1 < this.history.length )
  {
    this.historyIndex++;
    this.line = this.history[ this.historyIndex ];
    this.inputCursor = this.line.length;
    this._lineRefresh();
  }
}

//

function _historyCanged()
{
  var self = this;

  self.eventGive({ kind : 'historyCange' });

  self._historySave();

}

//

function _historySave()
{
  var self = this;

  if( !self.usingHistoryFile )
  return;

  try
  {

    self._historyEvalPath();
    _.assert( _.strIs( self._historyPath ) );
    self.onHistorySave();

  }
  catch( err )
  {
    _.errLog( err );
    self.usingHistoryFile = 0;
  }

  return self.usingHistoryFile;
}

//

function _historyLoad()
{
  var self = this;

  if( !self.usingHistoryFile )
  return;

  try
  {

    self._historyEvalPath();
    _.assert( _.strIs( self._historyPath ) );
    self.onHistoryLoad();

    if( !_.arrayIs( self.history ) )
    throw _.err( 'wrong history data' );

  }
  catch( err )
  {
    _.errLog( err );
    self.history = [];
    self.usingHistoryFile = 0;
  }

  return self.usingHistoryFile;
}

//

var _historyEvalPath = {};

// --
// relations
// --

var Composes =
{

  name : 'wTerminal',

  textPrompt : '> ',
  line : '',
  inputCursor : 0,

}

var Associates =
{

  history : _.define.own( [ 'aaa', 'bbb', 'ccc', 'dd\neeee', 'd\nee\nfff' ] ),
  historyIndex : -1,
  historyLimit : 128,
  usingHistoryFile : 1,
  _historyPath : null,

}

var Restricts =
{

  isClosed : false,
  isPaused : false,

  _conInited : null,
  _conSyn : null,
  _conQuestion : null,

  _strBuffer : null,
  _endsReturn : null,

  handleStreamData : null,

}

var Events =
{

  close : 'close',
  pause : 'pause',
  resume : 'resume',

  historyCange : 'historyCange',
  line : 'line',

}

// --
// declare
// --

const Proto =
{

  init,


  // inter

  prompt,
  question,

  close,
  pause,
  resume,
  clear,


  // etc

  handleStreamData,
  _writtenStream,


  // line

  _lineBegin,
  _lineEnd,
  _lineEnded,
  _lineEntered,
  _lineRefresh,

  lineCursorOffset,
  _lineInsertString,


  // history

  _historyPrependByCurrent,
  _historyNext,
  _historyPrev,

  _historyCanged,
  _historyEvalPath,
  _historySave,
  _historyLoad,


  // relations


  Composes,
  Associates,
  Restricts,
  Events,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );
_.Instancing.mixin( Self );
_.EventHandler.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.shortName ] = Self;

} )();
