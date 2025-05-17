( function _aTree_s_( )
{

'use strict';

/**
  @module Tools/amid/gui/Tree - GUI element to interact with tree structures.
*/

/**
 *  */

if( typeof module !== 'undefined' )
{

  require( '../Abstract.js' );
  require( '../../../../wtools/amid/l1/graphTools/IncludeTop.s' );

}

var $ = jQuery;
const _ = _global_.wTools;

_.include( 'wInstancing' );
_.include( 'wEventHandler' );
_.include( 'wGraph' );

/**
 * @classdesc GUI element to interact with tree structures.
 * @class wHiTree
 * @memberof module:Tools/amid/gui/Tree
*/

const Parent = wGhiAbstractModule;
const Self = wHiTree;
function wHiTree( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'HiTree';

// --
//
// --

var NodeGetters =
{
  elementsGet : function elementsGet( node ){ return node.elements },
  nameGet : function nameGet( node ){ return node.text },
  downGet : function elementsGet( node ){ return node.down },
}

// --
//
// --

function init( o )
{
  var self = this;
  Parent.prototype.init.call( self, o );
  Object.preventExtensions( self );
}

//

/**
 * @descriptionNeeded
 * @function exec
 * @memberof module:module:Tools/amid/gui/Tree.wHiTree
*/

function exec()
{
  var self = new this.Self();
  _.assert( !this.instanceIs() );
  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.process.ready( () => self._exec() );
  return self;
}

//

function _exec()
{
  var self = this;

  self.targetDom = _.domTotalPanelMake().targetDom;
  self._execDefaults();
  self.form();

  return self;
}

//

function _execDefaults()
{
  var self = this;

  var elementsMap =
  {
    'first branch' : [ 'apple', 'pinnacle', 'orange' ],
    'second branch' : [ 'table', 'chair' ],
    'third branch' : { 'third branch a' : [ 'yellow', 'green' ], 'third branch b' : [ 'red', 'blue', 'orange' ] },
    'empty branch' : [],
  }

  self.treeApply({ elements : elementsMap });

  return self;
}

//

function _formAct()
{
  var self = this;

  Parent.prototype._formAct.call( self );

  self._formContentDom();

  self.contentDom[ 0 ].setAttribute( 'tabindex', '0' );

  $( self.contentDom )
  .on( 'keydown', function( e )
  {
    // console.log( 'keydown',e.keyCode );

    if( e.keyCode === 38 )
    self.activateRelativeTouching( -1, 'horizontal' );
    else if( e.keyCode === 40 )
    self.activateRelativeTouching( +1, 'horizontal' );
    else if( e.keyCode === 37 )
    self.activateRelativeTouching( -1, 'vertical' );
    else if( e.keyCode === 39 )
    self.activateRelativeTouching( +1, 'vertical' );
    else if( e.keyCode === 16 )
    self._shiftDown = 1;
    else if( e.keyCode === 32 )
    {
      self._spaceDown = 1;
      self._nodeClick( self.activeNode );
    }
    else return;

    return false;
  })
  .on( 'keyup', function( e )
  {
    // console.log( 'keyup',e.keyCode );

    if( e.keyCode === 32 )
    self._spaceDown = 0;
    else if( e.keyCode === 16 )
    self._shiftDown = 0;
    else return;

    return false;
  });

  self.hotBarDom = self._formConentElementDom( self.hotBarDomSelector );

  if( !self.iconsDom.length )
  {
    self.iconsDom = self._formConentElementDom( self.iconsDomSelector );
    var openDom = $( '<i class="large reactive angle right icon"></i>' ).appendTo( self.iconsDom );
    var closeDom = $( '<i class="large reactive angle left icon"></i>' ).appendTo( self.iconsDom );

    openDom
    .bind( _.eventName( 'click' ), _.routineSeal( self, self._buttonNodeOpenCloseClick, [ 1 ] ) );

    closeDom
    .bind( _.eventName( 'click' ), _.routineSeal( self, self._buttonNodeOpenCloseClick, [ 0 ] ) );
  }

  self._makeRoot();

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( self.targetDom.length > 0 );
  _.assert( self.contentDom.length > 0 );

  if( self.folderMap )
  {
    self.treeApply({ elements : self.folderMap });
    self.folderMap = null;
  }

}

//

function _makeRoot( o )
{
  var self = this;

  o = o || Object.create( null );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.routine.options_( _makeRoot, o );
  _.assert( _.strIs( o.text ) );
  _.assert( !self.rootNode );

  o.elements = null;

  self.rootNode = self._nodeBranchMake( o );
  self.rootNode.dom.addClass( self.rootCssClass );
  self.contentDom.append( self.rootNode.dom );

  return self.rootNode;
}

_makeRoot.defaults =
{
  text : '. . .',
}

//

function _makeAboveRoot( o )
{
  var self = this;

  o = o || Object.create( null );
  o.elements = self.onBranchElements( o.elements );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.routine.options_( _makeAboveRoot, o );
  _.assert( _.arrayIs( o.elements ) || _.object.isBasic( o.elements ) );

  o.branch = self.rootNode;
  var node = self._nodesMake( o );

  return node;
}

_makeAboveRoot.defaults =
{
  elements : null,
  data : null,
}

//

function _nodesMake( o )
{
  var self = this;
  var node;

  _.assert( arguments.length === 1 );
  _.routine.options_( _nodesMake, o );
  _.assert( _.strIs( o.text ) || _.object.isBasic( o.branch ) );
  _.assert( _.arrayIs( o.elements ) || _.object.isBasic( o.elements ) );

  o.branch = o.branch || self._nodeBranchMake({ text : o.text })
  o.branch.elements = [];

  if( _.mapIs( o.elements ) )
  {

    for( var s in o.elements )
    {
      node = self._nodeMake
      ({
        text : s,
        elements : o.elements[ s ],
        down : o.branch,
        kind : _.primitiveIs( o.elements[ s ] ) ? 'terminal' : 'branch',
      });
      o.branch.elementsDom.append( node.dom );
      o.branch.elements.push( node );
    }

  }
  else if( _.arrayIs( o.elements ) )
  {

    for( var f = 0 ; f < o.elements.length ; f++ )
    {
      node = self._nodeMake( o.elements[ f ], o.branch );
      o.branch.elementsDom.append( node.dom );
      o.branch.elements.push( node );
    }

  }
  else throw _.err( 'unexpected type of ( o.elements )', _.entity.strType( o.elements ) );

  return o.branch;
}

_nodesMake.defaults =
{
  text : null,
  elements : null,
  branch : null,
  data : null,
}

//

function _nodeMake( node, down )
{
  var self = this;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( node !== undefined, 'Expects { node }' );

  if( _.object.isBasic( node ) )
  {

    if( !node.down )
    node.down = down;

    if( !node.kind && node.elements )
    node.kind = 'branch';

    _.assert( _.object.isBasic( node.down ) );
    _.assert( _.strIs( node.kind ), 'not clear is node branch or terminal' );

    if( node.kind === 'branch' )
    return self._nodeBranchMake( node );
    else
    return self._nodeTerminalMake( node );
  }
  else if( _.strIs( node ) )
  {
    node = { text : node, down }

    _.assert( _.object.isBasic( node.down ) );

    return self._nodeTerminalMake( node );
  }
  else throw _.err( '_nodeMake :', 'unknown type', _.entity.strType( node ) );

}

//

function _nodeFrom( src )
{
  var result = src;

  _.assert( arguments.length === 1 );

  if( _.strIs( result ) )
  {
    result = Object.create( null );
    result.text = src;
    result.kind = 'terminal';
  }
  else if( _.arrayIs( src ) )
  {
    result = Object.create( null );
    result.elements = src;
    result.kind = 'branch';
  }

  _.assert( _.mapIs( result ) || _.construction.isLike( result, Self.Node.Abstract ) );

  return result;
}

//

function _nodeBranchMake( o )
{
  var self = this;

  _.routine.options_( _nodeBranchMake, o );
  _.assert( arguments.length === 1 );
  // _.assert( !o.elements || _.arrayIs( o.elements ) );
  _.assert( !o.elements || _.arrayIs( o.elements ) || _.object.isBasic( o.elements ) );
  _.assert( _.strIs( o.text ) );
  _.assert( o.kind === 'branch' );
  _.assert( _.mapIs( o ) );
  _.assert( !( o instanceof Branch.constructor ) );

  /* branch */

  o = new Branch.constructor( o );
  _.assert( o instanceof Branch.constructor );
  o.tree = self;
  o.id = self.nodes.length;
  self.nodes.push( o );

  /* */

  if( _.mapIs( o.elements ) )
  {
    var elements = [];
    for( var e in o.elements )
    {
      var element = o.elements[ e ] = self._nodeFrom( o.elements[ e ] );

      if( !element.text )
      element.text = e;
      // if( !element.id )
      // element.id = e;

      elements.push( element );
    }
    o.elements = elements;
  }

  /* branch dom */

  o.dom = $( '<div>' );
  o.dom.addClass( self.branchCssClass );
  o.dom[ 0 ]._wtreeNode = o;

  if( ( o.down && self.makingOpenedBranches ) || ( !o.down && self.makingOpenedRoot ) )
  o.dom.addClass( self.openedCssClass );

  o.dom
  .bind( _.eventName( 'mouseenter' ), function( e )
  {
    var dom = $( this );
    self._branchHot( dom[ 0 ]._wtreeNode, 1 );
    // console.log( 'mouseenter' );
    return false;
  })
  .bind( _.eventName( 'mouseleave' ), function( e )
  {
    var dom = $( this );
    self._branchHot( dom[ 0 ]._wtreeNode, 0 );
    // console.log( 'mouseleave' );
    return false;
  });

  /* head dom */

  o.headDom = $( '<div>' );
  o.headDom.appendTo( o.dom );
  o.headDom.text( o.text );
  o.headDom.addClass( self.branchHeadCssClass );
  o.headDom
  .bind( _.eventName( 'click' ), function( e )
  {
    var dom = $( this ).closest( '.' + self.branchCssClass );
    self._nodeClick( o.dom[ 0 ]._wtreeNode );
  })
  .bind( _.eventName( 'mouseenter' ), function( e )
  {
    var dom = $( this ).closest( '.' + self.branchCssClass );
    self._branchHot( dom[ 0 ]._wtreeNode, 1 );
    return false;
  });

  /* elements */

  o.elementsDom = $( '<div>' );
  o.elementsDom.appendTo( o.dom );
  o.elementsDom.addClass( self.branchElementsCssClass );

  if( o.elements )
  for( var i = 0 ; i < o.elements.length ; i++ )
  {
    o.elements[ i ] = self._nodeMake( o.elements[ i ], o );
    o.elementsDom.append( o.elements[ i ].dom );
  }

  if( self.usingAttributes && o.attributes )
  {
    _.domAttrs( o.dom, _.mapOnlyAtomics( o.attributes ) );
  }

  /* */

  self._nodeValidate( o );
  self.eventGive({ kind : 'nodeMade', node : o });

  return o;
}

_nodeBranchMake.defaults =
{
  kind : 'branch',
  down : null,
  text : null,
  elements : null,
  data : null,
  attributes : null,
}

//

function _nodeTerminalMake( o )
{
  var self = this;

  if( _.strIs( o ) )
  {
    var text = o;
    o = Object.create( null );
    o.text = text;
  }

  _.assert( arguments.length === 1 );
  _.routine.options_( _nodeTerminalMake, o );
  _.assert( o.kind === 'terminal' );
  _.assert( !( o instanceof Terminal.constructor ) );

  o = new Terminal.constructor( o );
  _.assert( ( o instanceof Terminal.constructor ) );

  o.tree = self;
  // o.kind = 'terminal';
  o.id = self.terminals.length;
  self.terminals.push( o );

  o.dom = $( '<div>' );
  o.dom.addClass( self.terminalCssClass );

  o.dom.text( o.text );
  o.dom._wtreeTerminal = o;

  o.dom
  .bind( _.eventName( 'click' ), function( e )
  {
    var dom = $( this ).closest( '.' + self.terminalCssClass );
    self._nodeClick( o.dom._wtreeTerminal );
  });

  if( self.usingAttributes && o.attributes )
  {
    _.domAttrs( o.dom, _.mapOnlyAtomics( o.attributes ) );
  }

  /* */

  self._nodeValidate( o );
  self.eventGive({ kind : 'nodeMade', node : o });

  return o;
}

_nodeTerminalMake.defaults =
{
  kind : 'terminal',
  text : null,
  hint : null,
  data : null,
  down : null,
  attributes : null,
  page : null,
}

//

function _nodeValidate( node )
{
  var self = this;
  _.assert( _.construction.isLike( node, self.Node.Abstract ) );
  _.assert( _.strDefined( node.text ), 'node should has text' );
  return self;
}

//

/**
 * @descriptionNeeded
 * @param {Object} o Options map.
 * @param {Object} o.element Element to apply to the tree.
 * @function treeApply
 * @memberof module:module:Tools/amid/gui/Tree.wHiTree#
*/

function treeApply( o )
{
  var self = this;

  _.assert( arguments.length === 1 );
  _.routine.options_( treeApply, o );

  if( self._formStage )
  self._makeAboveRoot( o );
  else
  self.folderMap = o.elements;

  return self;
}

treeApply.defaults =
{
  elements : null,
}

// --
//
// --

function _nodeClick( node )
{
  var self = this;

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( node ) || node === null );

  if( node )
  if( node.kind === 'branch' )
  self._branchOpen( node, undefined );
  // self._branchOpen( node,node === self.activeNode ? undefined : 1 );

  self.nodeActivateTouching( node, 0 );

}

//

function _buttonNodeOpenCloseClick( openning )
{
  var self = this;
  var node = self.hotNode;

  _.assert( arguments.length === 1 );

  // console.log( '_buttonNodeOpenCloseClick' );

  if( !node )
  return false;

  self.branchOpenRecursive( node, openning );

  return false;
}

//

/**
 * @descriptionNeeded
 * @param {Number} offset
 * @param {Number} axis
 * @function activateRelativeTouching
 * @memberof module:module:Tools/amid/gui/Tree.wHiTree#
*/

function activateRelativeTouching( offset, axis )
{
  var self = this;
  var node = self.activeNode;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.object.isBasic( node ) || node === null );
  _.assert( _.numberIs( offset ) );

  // console.log( 'activateRelativeTouching' );

  if( !node )
  return false;

  var relative = self._goRelative( node, offset, axis );

  if( relative )
  {
    if( relative.down )
    self._branchOpen( relative.down, 1 );
    if( relative && axis === 'vertical' && offset === -1 )
    self._branchOpen( relative, 0 );
    self.nodeActivateTouching( relative );
  }

  return relative;
}

//

/**
 * @summary Activates provided `node`.
 * @description Also scrolls page to new node and fires `nodeActivate` event.
 * @param {Object} node Node to activate
 * @param {Boolean} withKey
 * @function nodeActivateTouching
 * @memberof module:module:Tools/amid/gui/Tree.wHiTree#
*/

function nodeActivateTouching( node, withKey )
{
  var self = this;

  if( withKey === undefined )
  withKey = 1;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.object.isBasic( node ) || node === null );

  self.nodeActivateChanging( node );

  self.eventGive({ kind : 'nodeActivate', node });

  // if( _.construction.isLike( node,Node.Branch ) )

  if( withKey )
  if( _.construction.isLike( node, Node.Branch ) )
  if( self._spaceDown )
  if( self._shiftDown )
  self._branchOpen( node, 0 );
  else
  self._branchOpen( node, 1 );

}

//

/**
 * @summary Activates provided `node`.
 * @description Removes active class name from current node and appends it new one. Scrolls page to new active node.
 * @param {Object} node Node to activate.
 * @function nodeActivateChanging
 * @memberof module:module:Tools/amid/gui/Tree.wHiTree#
*/

function nodeActivateChanging( node )
{
  var self = this;

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( node ) || node === null );

  if( self.activeNode )
  self.activeNode.dom.removeClass( self.activeCssClass );

  if( node )
  node.dom.addClass( self.activeCssClass );
  self.activeNode = node;

  if( node )
  self.nodeScrollTo( node );

}

//

/**
 * @summary Scrolls page to provided `node`.
 * @param {Object} node Node to scroll to.
 * @function nodeScrollTo
 * @memberof module:module:Tools/amid/gui/Tree.wHiTree#
*/

function nodeScrollTo( node )
{
  var self = this;

  _.assert( _.construction.isLike( node, Node.Abstract ) );

  var nodeBox = _.domBoundingBoxGlobalGet( node.dom );
  var targetBox = _.domBoundingBoxGlobalGet( self.targetDom );

  nodeBox[ 3 ] = Math.min( nodeBox[ 3 ], nodeBox[ 1 ] + targetBox[ 3 ]-targetBox[ 1 ] );

  var top = nodeBox[ 1 ]-targetBox[ 1 ];
  var bottom = targetBox[ 3 ]-nodeBox[ 3 ];

  // console.log( 'top',top );
  // console.log( 'bottom',bottom );

  if( top >= 0 && bottom >= 0 )
  return;

  if( top < 0 && bottom < 0 )
  return;

  if( top < 0 )
  self.targetDom[ 0 ].scrollTop += top;
  else
  self.targetDom[ 0 ].scrollTop -= bottom;

  // node.dom[ 0 ].scrollIntoView({ block : 'begin', behavior : 'smooth' });

}

//

/**
 * @descriptionNeeded
 * @param {Object} node Target node.
 * @param {} value
 * @function branchOpenRecursive
 * @memberof module:module:Tools/amid/gui/Tree.wHiTree#
*/

function branchOpenRecursive( node, value )
{
  var self = this;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.object.isBasic( node ) );

  self._nodeEach( node, function( node )
  {
    self._branchOpen( node, value );
  });

}

//

/**
 * @descriptionNeeded
 * @param {Object} node Target node.
 * @param {} value
 * @function branchOpen
 * @memberof module:module:Tools/amid/gui/Tree.wHiTree#
*/

function branchOpen( selector, value )
{
  var self = this;

  if( _.numberIs( selector ) )
  selector = { id : selector }
  else if( _.strIs( selector ) )
  selector = { text : selector }

  _.assert( arguments.length === 1 || arguments.length === 2 );

  var nodes = _.filter_( null, self.nodes, selector )

  for( var i = 0 ; i < nodes.length ; i++ )
  self._branchOpen( nodes[ i ], value );

  return self;
}

//

function _branchOpen( branch, value )
{
  var self = this;

  _.assert( _.object.isBasic( branch ) )
  _.assert( arguments.length === 1 || arguments.length === 2 );

  _.domClass( branch.dom, self.openedCssClass, value )

}

//

function _branchHot( node, value )
{
  var self = this;

  _.assert( _.object.isBasic( node ) )
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( self.hotNode )
  {
    _.domClass( self.hotNode.dom, self.hotCssClass, 0 );
  }

  _.domClass( node.dom, self.hotCssClass, value );

  self.hotNode = null;
  self.iconsDom.detach();
  self.hotBarDom.detach();

  if( value )
  {
    self.iconsDom.appendTo( node.headDom );
    self.iconsDom.css( 'display', 'block' );

    self.hotBarDom.appendTo( node.dom );
    self.hotBarDom.css( 'display', 'block' );

    self.hotNode = node;
  }

  return self;
}

// --
// traverse
// --

function _nodeEach( o )
{
  var self = this;

  if( arguments[ 1 ] )
  o = { node : arguments[ 0 ], onUp : ( arguments.length > 1 ? arguments[ 1 ] : null ) };

  _.assert( _.object.isBasic( o.node ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  o.elementsGet = function( node ){ return node.elements || []; };
  o.nameGet = function( node ){ return node.text; };

  return _.graph.nodeEach( o );
}

//

function _goRelative( o )
{
  var self = this;

  if( _.construction.isLike( arguments[ 0 ], Node.Abstract ) )
  o =
  {
    node : arguments[ 0 ],
    offset : ( arguments.length > 1 ? arguments[ 1 ] : null ),
    axis : ( arguments.length > 2 ? arguments[ 2 ] : null )
  };

  _.routine.options_( _goRelative, o );
  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );

  var relative = _.graph.goRelative( o );

  return relative;
}

_goRelative.defaults = {};
// _goRelative.defaults.__proto__ = _.graph.goRelative.defaults;
Object.setPrototypeOf( _goRelative.defaults, _.graph.goRelative.defaults )
_.props.extend( _goRelative.defaults, NodeGetters );

// --
//
// --

function onBranchElements( data )
{
  return data;
}

// --
// type
// --

var Abstract = _.like()
.also
({
  text : null,
  hint : null,
  data : null,
  tree : null,
  id : null,
  dom : null,
  down : null,
  attributes : null,
  page : null,
})
.end

var Branch = _.like( Abstract )
.also
({
  kind : 'branch',
  elements : null,
  headDom : null,
  elementsDom : null,
})
.end

var Terminal = _.like( Abstract )
.also
({
  kind : 'terminal',
  elements : null,
})
.end

//

var Node = Object.create( null );
Node.Abstract = Abstract;
Node.Branch = Branch;
Node.Terminal = Terminal;

// --
// var
// --

var symbolForValues = Symbol.for( 'values' );

// --
// relations
// --

var Composes =
{

  dynamic : 0,

  makingOpenedBranches : 0,
  makingOpenedRoot : 1,
  usingAttributes : 1,

  targetIdentity : '.wtree',

  rootCssClass : 'wtree-root',
  branchCssClass : 'wtree-branch',
  branchHeadCssClass : 'wtree-branch-head',
  branchElementsCssClass : 'wtree-branch-elements',
  terminalCssClass : 'wtree-terminal',

  openedCssClass : 'opened',
  hotCssClass : 'hot',
  activeCssClass : 'active',

  nodes : _.define.own( [] ),
  terminals : _.define.own( [] ),

  onBranchElements,

  // onFolderNameGet : onFolderNameGet,
  // onFolderItemsGet : onFolderItemsGet,
  // onItemNameGet : onItemNameGet,

}

var Aggregates =
{
  rootNode : null,
}

var Associates =
{

  targetDom : '.wtree',
  contentDomSelector : '{{targetDom}} > .content',

  rootDomSelector : '.wtree-root',

  hotBarDom : null,
  hotBarDomSelector : '.wtree-hot-bar',

  iconsDom : null,
  iconsDomSelector : '.wtree-icons',

  folderMap : null,

}

var Restricts =
{
  activeNode : null,
  hotNode : null,
  _spaceDown : 0,
  _shiftDown : 0,
}

var Statics =
{
  exec,
  Node,
}

var Events =
{
  nodeActivate : 'nodeActivate',
  nodeMade : 'nodeMade',
}

// --
// proto
// --

const Proto =
{

  init,

  exec,
  _exec,
  _execDefaults,

  _formAct,
  _makeRoot,
  _makeAboveRoot,

  _nodesMake,
  _nodeMake,
  _nodeFrom,

  _nodeBranchMake,
  _nodeTerminalMake,
  _nodeValidate,

  treeApply,

  //

  _nodeClick,
  _buttonNodeOpenCloseClick,
  activateRelativeTouching,

  nodeActivateTouching,
  nodeActivateChanging,

  nodeScrollTo,

  branchOpenRecursive,
  branchOpen,
  _branchOpen,
  _branchHot,

  // traversing

  _nodeEach,
  _goRelative,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Events,

}

//

_.classDeclare
({
  cls : Self,
  extend : Proto,
  parent : Parent,
});

_.Instancing.mixin( Self );
_.EventHandler.mixin( Self );

//

_.ghi = _.ghi || Object.create( null );
_global_[ Self.name ] = _.ghi[ Self.shortName ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

//

// if( 0 )
// Self.exec();

})( );
