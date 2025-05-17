( function _TerminalBrowser_s_()
{

'use strict';

//

var $ = jQuery;
const _ = _global_.wTools;
const Parent = wTerminalAbstract;
const Self = function wTerminalBrowser( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

//

function init( o )
{
  var self = this;

  Parent.prototype.init.call( self, o );

  self.initDom();
  self.hookConsole();

}

//

function initDom()
{
  var self = this;

  var targetDom;
  if( !self.targetDom )
  {

    if( !self.containerDom )
    self.containerDom = $( document.body );

    var code = '';
    code += '<div class="terminal-browser">'
    code += '  <textarea name="Text1" readonly></textarea>';
    code += '  <input class="" type="text" name="lname">';
    code += '</div>'

    targetDom = self.targetDom = $( code ).appendTo( self.containerDom );

    targetDom.css
    ({
      'width' : '100%',
      'height' : '100%',
      'bottom' : '0',
      'position' : 'absolute',
      'background' : 'black',
      'z-index' : 1000,
      'font-family' : 'monospace',
      'font-size' : '11px',
      'line-height' : '1.1em',
    });

    targetDom.find( 'textarea' ).css
    ({
      'width' : '100%',
      'height' : 'calc( 100% - 3em )',
      'background' : 'transparent',
      'color' : '#0f0',
      'border' : 'none',
      'resize' : 'none',
      'padding' : '0.5em',
      'margin' : 0,
      'outline' : 'none',
      'font-family' : 'monospace',
    });

    targetDom.find( 'input' ).css
    ({
      'width' : '100%',
      'height' : '2.5em',
      'bottom' : '0',
      'background' : '#333',
      'color' : 'white',
      'border' : 'none',
      // 'padding' : 0,
      'margin' : 0,
      'padding' : '0 0.5em',
      'outline' : 'none',
      'font-family' : 'monospace',
      'font-size' : '1.1em',
    });

  }

  targetDom = self.targetDom = $( self.targetDom );
  var inputDom = self.inputDom = self.targetDom.find( 'input' );

  _.assert( inputDom.length, 'no input found' );

  self.handleStreamData = _.routineJoin( self, Self.prototype.handleStreamData );

  inputDom.bind( 'keydown', function( e )
  {

    // console.log( 'keydown :',e.keyCode );

    switch( e.which )
    {
    // case 37 : /* left */
    // break;

    // case 39 : /* right */
    // break;

    case 38 : /* up */
      self._historyPrev();
      break;

    case 40 : /* down */
      self._historyNext();
      break;

    default : return;
    }

    e.preventDefault();

  });

  inputDom.bind( 'keypress', function( e )
  {

    // console.log( 'keypress :',e.keyCode );

    if( e.keyCode !== 13 )
    return;

    var s = this.value;
    var u = _.strUnjoin( s, [ self.textPrompt, _.strUnjoin.any ] );

    self.handleStreamData( ( u ? u[ 1 ] : s ) + '\n' );

    this.value = '';

  });

  return targetDom;
}

//

function hookConsole()
{
  var self = this;

  var methods = [ 'log', 'debug', 'error', 'info', 'warn' ];

  for( var m in methods ) ( function()
  {

    var original = console[ methods[ m ] ];
    _.assert( !!original );
    console[ methods[ m ] ] = function()
    {
      var src = _.entity.exportStringSimple.apply( _,arguments );
      self._writeOutput( src + '\n' );
      return original.apply( this, arguments );
    }

  })();

}

//

function _writeOutput( srcString )
{
  var self = this;

  _.assert( _.strIs( srcString ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  var textarea = self.targetDom.find( 'textarea' );
  var was = textarea[ 0 ].value;

  textarea[ 0 ].value = was + srcString;

  textarea[ 0 ].scrollTop = textarea[ 0 ].scrollHeight;

}

//

function _rewriteInput( srcString )
{
  var self = this;

  _.assert( _.strIs( srcString ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  var textarea = self.targetDom.find( 'input' );

  textarea[ 0 ].value = srcString;

  _.dom.caretSelect( textarea, [ srcString.length, srcString.length ] );

}

// --
// history
// --

function _historyEvalPath()
{
  var self = this;

  if( self._historyPath )
  return self._historyPath;

  self._historyPath = self.qualifiedName + '-history';

  return self._historyPath;
}

//

function onHistorySave()
{
  var self = this;

  if( !_global_.Storage )
  return false;

  localStorage[ self._historyPath ] = JSON.stringify( self.history );

  return true;
}

//

function onHistoryLoad()
{
  var self = this;

  if( !_global_.Storage )
  return false;

  var storage = localStorage[ self._historyPath ];
  if( storage )
  self.history = JSON.parse( storage );

  return true;
}

// --
// relations
// --

var Composes =
{

  name : 'wTerminalBrowser',

  onHistorySave,
  onHistoryLoad,

}

var Associates =
{
  containerDom : null,
  targetDom : null,
  inputDom : null,
}

var Restricts =
{
}

// --
// declare
// --

const Proto =
{

  init,
  initDom,
  hookConsole,

  _writeOutput,
  _rewriteInput,


  // history

  _historyEvalPath,
  onHistorySave,
  onHistoryLoad,


  // relations


  Composes,
  Associates,
  Restricts,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

_global_[ Self.name ] = Self;
_.TerminalBrowser = Self;

if( !_global_.wTools.Terminal )
_.Terminal = Self;
if( !_global_.wTerminal )
_global_.wTerminal = Self;

return Self;

} )();
