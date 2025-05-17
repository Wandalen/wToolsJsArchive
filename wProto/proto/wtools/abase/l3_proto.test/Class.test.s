( function _Class_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );
  _.include( 'wEqualer' );

  require( '../../abase/l3_proto/Include.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// test
// --

function classDeclare( test )
{
  let context = this;

  /* */

  test.case = 'first classDeclare';

  function C1()
  {
    this.Instances.push( this );
  }
  var Statics1 =
  {
    Instances : [],
    f1 : [],
    f2 : [],
    f3 : [],
  }
  var Extend1 =
  {
    Statics : Statics1,
    f1 : [],
    f2 : [],
    f4 : [],
  }
  var classMade = _.classDeclare
  ({
    cls : C1,
    parent : null,
    extend : Extend1,
  });

  test.identical( C1, classMade );
  test.true( C1.Instances === Statics1.Instances );

  test1({ Class : C1 });
  testFields( Statics1.f3 );

  /* */

  test.case = 'classDeclare with parent';

  function C2()
  {
    C1.call( this );
  }
  var classMade = _.classDeclare
  ({
    cls : C2,
    parent : C1,
  });

  test.identical( C2, classMade );

  test1({ Class : C1, Statics : Statics1 });

  test.true( C1.Instances === Statics1.Instances );
  test.true( C2.Instances === C1.Instances );

  test1({ Class : C2, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.case = 'classDeclare with supplement';

  function Csupplement()
  {
    C1.call( this );
  }
  var Statics2 =
  {
    Instances : [],
  }
  var classMade = _.classDeclare
  ({
    cls : Csupplement,
    parent : C1,
    supplement : { Statics : Statics2 },
  });

  test.identical( Csupplement,classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1({ Class : Csupplement, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.case = 'classDeclare with extend';

  function C3()
  {
    C1.call( this );
  }
  var Associates =
  {
  }
  var Statics2 =
  {
    Instances : [],
    f1 : [],
    f4 : [],
  }
  var Extend2 =
  {
    Statics : Statics2,
    Associates,
    f2 : [],
    f3 : [],
  }
  var classMade = _.classDeclare
  ({
    cls : C3,
    parent : C1,
    extend : Extend2,
    allowingExtendStatics : 1,
  });

  test.identical( C3, classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1
  ({
    Class : C3,
    Class0 : C1,
    Statics : Statics2,
    Extension : Extend2,
    keys : [ 'Instances', 'f1', 'f4', 'f2', 'f3' ],
    vals : [ C3.Instances, C3.f1, C3.f4, C1.f2, C1.f3 ],
  });

  testFields( Extend2.f3 );
  testFields2();

  if( !Config.debug )
  return;

  test.case = 'attempt to extend statics without order';

  test.shouldThrowErrorOfAnyKind( function()
  {

    function C3()
    {
      C1.call( this );
    }
    var Associates =
    {
    }
    var Statics2 =
    {
      Instances : [],
      f1 : [],
      f4 : [],
    }
    var Extend2 =
    {
      Statics : Statics2,
      Associates,
      f2 : [],
      f3 : [],
    }
    var classMade = _.classDeclare
    ({
      cls : C3,
      parent : C1,
      extend : Extend2,
    });

  });

  /* */

  function test1( o )
  {

    if( o.ownStatics === undefined )
    o.ownStatics = 1;

    if( !o.Statics )
    o.Statics = Statics1;

    if( !o.Extension )
    o.Extension = Extend1;

    if( !o.keys )
    o.keys = _.props.keys( o.Statics );

    if( !o.vals )
    o.vals = _.props.vals( o.Statics );

    var C0proto = null;
    if( !o.Class0 )
    {
      o.Class0 = Function.prototype;
    }
    else
    {
      C0proto = o.Class0.prototype;
    }

    test.case = 'presence of valid prototype and constructor fields on class and prototype';

    test.identical( o.Class, o.Class.prototype.constructor );
    test.identical( Object.getPrototypeOf( o.Class ), o.Class0 );
    test.identical( Object.getPrototypeOf( o.Class.prototype ), C0proto );

    test.case = 'presence of valid static field on class and prototype';

    test.identical( o.Class.Instances, o.Class.prototype.Instances );

    test.case = 'getting property descriptor of static field from constructor';

    var cd = Object.getOwnPropertyDescriptor( o.Class, 'Instances' );
    if( !o.ownStatics )
    {
      test.identical( cd, undefined );
    }
    else
    {
      test.identical( cd.configurable, true );
      test.identical( cd.enumerable, true );
      test.true( !!cd.get );
      test.true( !!cd.set );
    }

    var pd = Object.getOwnPropertyDescriptor( o.Class.prototype, 'Instances' );

    if( !o.ownStatics )
    {
      test.identical( pd, undefined );
    }
    else
    {
      test.identical( pd.configurable, true );
      test.identical( pd.enumerable, false );
      test.true( !!pd.get );
      test.true( !!pd.set );
    }

    test.case = 'making the first instance';

    var c1a = new o.Class();

    test.case = 'presence of valid static field on all';

    if( o.Class !== C1 && !o.ownStatics )
    test.true( o.Class.Instances === C1.Instances );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === o.Statics.Instances );
    test.identical( o.Class.Instances.length, o.Statics.Instances.length );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-1 ], c1a );

    test.case = 'presence of valid prototype and constructor fields on instance';

    test.identical( Object.getPrototypeOf( c1a ), o.Class.prototype );
    test.identical( c1a.constructor, o.Class );

    test.case = 'presence of valid Statics descriptor';

    test.true( o.Statics !== o.Class.prototype.Statics );
    test.true( o.Statics !== c1a.Statics );

    test.identical( _.props.keys( c1a.Statics ), o.keys );
    test.identical( _.props.vals( c1a.Statics ), o.vals );
    test.identical( o.Class.Statics, undefined );

    if( !C0proto )
    {
      var r = _.entityIdentical( o.Class.prototype.Statics, o.Statics );
      test.identical( o.Class.prototype.Statics, o.Statics );
      test.identical( c1a.Statics, o.Statics );
    }

    test.case = 'presence of conflicting fields';

    test.true( o.Class.prototype.f1 === c1a.f1 );
    test.true( o.Class.prototype.f2 === c1a.f2 );
    test.true( o.Class.prototype.f3 === c1a.f3 );
    test.true( o.Class.prototype.f4 === c1a.f4 );

    test.case = 'making the second instance';

    var c1b = new o.Class();
    test.identical( o.Class.Instances, o.Class.prototype.Instances );
    test.identical( o.Class.Instances, c1a.Instances );
    test.identical( o.Class.Instances.length, o.Statics.Instances.length );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-2 ], c1a );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-1 ], c1b );

    test.case = 'setting static field with constructor';

    o.Class.Instances = o.Class.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOnlyOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

    test.case = 'setting static field with prototype';

    o.Class.prototype.Instances = o.Class.prototype.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOnlyOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

    test.case = 'setting static field with instance';

    c1a.Instances = o.Class.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOnlyOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

  }

  /* */

  function testFields( f3 )
  {

    test.case = 'presence of conflicting fields in the first class';

    test.true( Statics1.f1 === C1.f1 );
    test.true( Extend1.f1 === C1.prototype.f1 );

    test.true( Statics1.f2 === C1.f2 );
    test.true( Extend1.f2 === C1.prototype.f2 );

    test.true( f3 === C1.f3 );
    test.true( f3 === C1.prototype.f3 );

    test.true( Statics1.f4 === undefined );
    test.true( Statics1.f4 === C1.f4 );
    test.true( Extend1.f4 === C1.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C1,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f3' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f3' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1,'f4' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f4' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

  }

  /* */

  function testFields2()
  {

    test.case = 'presence of conflicting fields in the second class';

    test.true( Statics2.f1 === C3.f1 );
    test.true( Statics2.f1 === C3.prototype.f1 );

    test.true( Statics1.f2 === C3.f2 );
    test.true( Extend2.f2 === C3.prototype.f2 );

    test.true( Extend2.f3 === C3.f3 );
    test.true( Extend2.f3 === C3.prototype.f3 );

    test.true( Statics2.f4 === C3.f4 );
    test.true( Statics2.f4 === C3.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C3,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f1' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3,'f2' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C3,'f3' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f3' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3,'f4' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f4' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    test.case = 'assigning static fields';

    C1.f1 = 1;
    C1.f2 = 2;
    C1.f3 = 3;
    C1.f4 = 4;

    C1.prototype.f1 = 11;
    C1.prototype.f2 = 12;
    C1.prototype.f3 = 13;
    C1.prototype.f4 = 14;

    C2.f1 = 21;
    C2.f2 = 22;
    C2.f3 = 23;
    C2.f4 = 24;

    C2.prototype.f1 = 31;
    C2.prototype.f2 = 32;
    C2.prototype.f3 = 33;
    C2.prototype.f4 = 34;

    test.identical( C1.f1,1 );
    test.identical( C1.f2,2 );
    test.identical( C1.f3,33 );
    test.identical( C1.f4,4 );

    test.identical( C1.prototype.f1,11 );
    test.identical( C1.prototype.f2,12 );
    test.identical( C1.prototype.f3,33 );
    test.identical( C1.prototype.f4,14 );

    test.identical( C2.f1,21 );
    test.identical( C2.f2,22 );
    test.identical( C2.f3,33 );
    test.identical( C2.f4,24 );

    test.identical( C2.prototype.f1,31 );
    test.identical( C2.prototype.f2,32 );
    test.identical( C2.prototype.f3,33 );
    test.identical( C2.prototype.f4,34 );

  }

}

// classDeclare.timeOut = 300000;

//

function staticsDeclare( test )
{

  /* - */

  test.open( 'basic' );
  test.case = 'setup';

  function BasicConstructor()
  {
    _.workpiece.initFields( this );
  }

  var Associates =
  {
    f2 : _.define.common( 'Associates' ),
  }

  var Statics =
  {
    f1 : [ 'Statics' ],
    f2 : [ 'Statics' ],
    f3 : [ 'Statics' ],
  }

  var Extension =
  {
    f3 : [ 'Extension' ],
    Associates,
    Statics,
  }

  // Extension.constructor = BasicConstructor;

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extension,
  });

  var instance = new BasicConstructor();

  test.case = 'f1';

  test.true( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.true( BasicConstructor.prototype.f1 === Statics.f1 );
  test.true( BasicConstructor.f1 === Statics.f1 );
  test.true( BasicConstructor.prototype.Statics.f1 === Statics.f1 );
  test.true( instance.f1 === Statics.f1 );

  test.case = 'set prototype.f1';

  var newF1 = [ 'newF1' ];
  BasicConstructor.prototype.f1 = newF1;
  var instance2 = new BasicConstructor();

  test.true( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.true( BasicConstructor.prototype.f1 === newF1 );
  test.true( BasicConstructor.f1 === newF1 );
  test.true( instance.f1 === newF1 );
  test.true( instance2.f1 === newF1 );

  test.case = 'set class.f1';

  var newF1 = [ 'newF1' ];
  BasicConstructor.f1 = newF1;
  var instance2 = new BasicConstructor();

  test.true( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.true( BasicConstructor.prototype.f1 === newF1 );
  test.true( BasicConstructor.f1 === newF1 );
  test.true( instance.f1 === newF1 );
  test.true( instance2.f1 === newF1 );

  test.case = 'f2';

  test.true( BasicConstructor.prototype.f2 === undefined );
  test.true( BasicConstructor.f2 === Statics.f2 );
  test.true( BasicConstructor.prototype.Statics.f2 === Statics.f2 );
  test.true( BasicConstructor.prototype.Associates.f2 === Associates.f2 );
  test.true( instance.f2 === Associates.f2.val );

  test.case = 'set prototype.f2';

  var newF2 = [ 'newF2' ];
  BasicConstructor.prototype.f2 = newF2;
  var instance2 = new BasicConstructor();

  test.true( BasicConstructor.f2 !== BasicConstructor.prototype.f2 );
  test.true( BasicConstructor.prototype.f2 === newF2 );
  test.true( BasicConstructor.f2 === Statics.f2 );
  test.true( instance.f2 === Associates.f2.val );
  test.true( instance2.f2 === Associates.f2.val );

  test.case = 'set constructor.f2';

  var newF2 = [ 'newF2' ];
  BasicConstructor.f2 = newF2;
  var instance2 = new BasicConstructor();

  test.true( BasicConstructor.f2 !== BasicConstructor.prototype.f2 );
  test.true( BasicConstructor.f2 === newF2 );
  test.true( instance.f2 === Associates.f2.val );
  test.true( instance2.f2 === Associates.f2.val );

  test.close( 'basic' );

  /* - */

}

// staticsDeclare.timeOut = 300000;

//

function staticsOverwrite( test )
{

  /* - */

  test.open( 'basic' );
  test.case = 'setup';

  function BasicConstructor()
  {
    _.workpiece.initFields( this );
    this.Instances.push( this );
  }

  var Statics =
  {
    Instances : [],
  }

  var Extension =
  {
    Statics,
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extension,
  });

  var instance0 = new BasicConstructor();

  /* */

  function DerivedConstructor1()
  {
    _.workpiece.initFields( this );
    this.Instances.push( this );
  }

  var Statics =
  {
    Instances : [],
  }

  var Extension =
  {
    Statics,
  }

  _.classDeclare
  ({
    parent : BasicConstructor,
    cls : DerivedConstructor1,
    extend : Extension,
  });

  var instance1 = new DerivedConstructor1();

  /* */

  function DerivedConstructor2()
  {
    _.workpiece.initFields( this );
    this.Instances.push( this );
  }

  var Statics =
  {
  }

  var Extension =
  {
    Statics,
  }

  // Extension.constructor = DerivedConstructor2;

  _.classDeclare
  ({
    parent : BasicConstructor,
    cls : DerivedConstructor2,
    extend : Extension,
  });

  var instance2 = new DerivedConstructor2();

  /* */

  test.case = 'f1';

  test.true( BasicConstructor.Instances === BasicConstructor.prototype.Instances );
  test.true( BasicConstructor.Instances === DerivedConstructor2.Instances );
  test.true( BasicConstructor.Instances === DerivedConstructor2.prototype.Instances );
  test.true( BasicConstructor.Instances === instance0.Instances );
  test.true( BasicConstructor.Instances === instance2.Instances );

  test.true( BasicConstructor.Instances !== DerivedConstructor1.Instances );
  test.true( BasicConstructor.Instances !== instance1.Instances );

  test.true( DerivedConstructor1.Instances === DerivedConstructor1.prototype.Instances );
  test.true( DerivedConstructor1.Instances === instance1.Instances );

  test.identical( instance0.Instances.length, 2 );
  test.identical( instance1.Instances.length, 1 );
  test.identical( instance2.Instances.length, 2 );

  test.close( 'basic' );

  /* - */

}

//

function mixinStaticsWithDefinition( test )
{

  /* - */

  test.will = 'setup Mixin';

  function Mixin()
  {
  }

  Mixin.shortName = 'Mix';

  var wrap = [ 0 ];
  var array = [ wrap ];
  var map = { 0 : wrap };
  var Statics =
  {
    array : _.define.contained({ val : array, writable : 0, shallowCloning : 1 }),
    map : _.define.contained({ val : map, writable : 0, shallowCloning : 1 }),
    bool : _.define.contained({ val : 0 }),
    wrap : _.define.contained({ val : wrap }),
  }

  var Extension =
  {
    Statics,
  }

  _.classDeclare
  ({
    cls : Mixin,
    extend : Extension,
    withMixin : 1,
  });

  test.true( _.routineIs( Mixin.mixin ) );
  test.identical( Mixin.__mixin__.mixin, Mixin.mixin );
  test.identical( Mixin.__mixin__.name, 'Mixin' );
  test.identical( Mixin.__mixin__.shortName, 'Mix' );
  test.identical( Mixin.__mixin__.extend.constructor, undefined );

  /* */

  test.will = 'setup Class1';

  function Class1()
  {
    _.workpiece.initFields( this );
  }

  _.classDeclare
  ({
    cls : Class1,
  });

  test.true( Class1.prototype.constructor === Class1 );

  Mixin.mixin( Class1 );

  var instance1 = new Class1();

  /* */

  test.will = 'setup Class2';

  function Class2()
  {
    _.workpiece.initFields( this );
  }

  _.classDeclare
  ({
    cls : Class2,
  });

  Mixin.mixin( Class2 );

  var instance2 = new Class2();

  /* */

  test.case = 'clean';

  test.true( Mixin.wrapGet === undefined );
  test.true( Mixin._wrapGet === undefined );
  test.true( Mixin.prototype.wrapGet === undefined );
  test.true( Mixin.prototype._wrapGet === undefined );

  test.true( Class1.wrapGet === undefined );
  test.true( Class1._wrapGet === undefined );
  test.true( Class1.prototype.wrapGet === undefined );
  test.true( Class1.prototype._wrapGet === undefined );

  test.true( Class2.wrapGet === undefined );
  test.true( Class2._wrapGet === undefined );
  test.true( Class2.prototype.wrapGet === undefined );
  test.true( Class2.prototype._wrapGet === undefined );

  /* */

  test.case = 'wrap';

  test.true( wrap === Mixin.wrap );
  test.true( wrap === Mixin.prototype.Statics.wrap.val );
  test.true( wrap === Mixin.prototype.wrap );
  test.true( wrap === Class1.prototype.Statics.wrap.val );
  test.true( wrap === Class1.prototype.wrap );
  test.true( wrap === Class1.wrap );
  test.true( wrap === instance1.wrap );

  test.true( wrap === Class2.prototype.Statics.wrap.val );
  test.true( wrap === Class2.prototype.wrap );
  test.true( wrap === Class2.wrap );
  test.true( wrap === instance2.wrap );

  test.case = 'set Mixin.wrap';

  var wrap2 = Mixin.wrap = [ 'wrap2' ];

  test.true( wrap2 === Mixin.wrap );
  test.true( wrap == Mixin.prototype.Statics.wrap.val );
  test.true( wrap2 === Mixin.prototype.wrap );
  test.true( wrap === Class1.prototype.Statics.wrap.val );
  test.true( wrap === Class1.prototype.wrap );
  test.true( wrap === Class1.wrap );
  test.true( wrap === instance1.wrap );
  test.true( wrap == Class2.prototype.Statics.wrap.val );
  test.true( wrap == Class2.prototype.wrap );
  test.true( wrap == Class2.wrap );
  test.true( wrap == instance2.wrap );

  test.case = 'set Class1.wrap';

  var wrap3 = Class1.wrap = [ 'wrap3' ];

  test.true( wrap2 === Mixin.wrap );
  test.true( wrap === Mixin.prototype.Statics.wrap.val );
  test.true( wrap2 === Mixin.prototype.wrap );
  test.true( wrap === Class1.prototype.Statics.wrap.val );
  test.true( wrap3 === Class1.prototype.wrap );
  test.true( wrap3 === Class1.wrap );
  test.true( wrap3 === instance1.wrap );
  test.true( wrap === Class2.prototype.Statics.wrap.val );
  test.true( wrap === Class2.prototype.wrap );
  test.true( wrap === Class2.wrap );
  test.true( wrap === instance2.wrap );

  /* */

  test.case = 'array';

  test.true( array !== Mixin.array );
  test.true( array === Mixin.prototype.Statics.array.val );
  test.true( Mixin.array === Mixin.prototype.array );

  test.true( array === Class1.prototype.Statics.array.val );
  test.true( Class1.array === Class1.prototype.array );
  test.true( array !== Class1.array );
  test.true( Mixin.array !== Class1.array );
  test.true( Class1.array === instance1.array );

  test.true( array === Class2.prototype.Statics.array.val );
  test.true( Class2.array === Class2.prototype.array );
  test.true( array !== Class2.array );
  test.true( Mixin.array !== Class2.array );
  test.true( Class2.array === instance2.array );

  test.case = 'wrap in array';

  test.true( array[ 0 ] === Mixin.array[ 0 ] );
  test.true( array[ 0 ] === Mixin.prototype.Statics.array.val[ 0 ] );
  test.true( array[ 0 ] === Mixin.prototype.array[ 0 ] );
  test.true( array[ 0 ] === Class1.prototype.Statics.array.val[ 0 ] );
  test.true( array[ 0 ] === Class1.prototype.array[ 0 ] );
  test.true( array[ 0 ] === Class1.array[ 0 ] );
  test.true( array[ 0 ] === instance1.array[ 0 ] );
  test.true( array[ 0 ] === Class2.prototype.Statics.array.val[ 0 ] );
  test.true( array[ 0 ] === Class2.prototype.array[ 0 ] );
  test.true( array[ 0 ] === Class2.array[ 0 ] );
  test.true( array[ 0 ] === instance2.array[ 0 ] );

  /* */

  test.case = 'map';

  test.true( map !== Mixin.map );
  test.true( map === Mixin.prototype.Statics.map.val );
  test.true( Mixin.map === Mixin.prototype.map );

  test.true( map === Class1.prototype.Statics.map.val );
  test.true( Class1.map === Class1.prototype.map );
  test.true( map !== Class1.map );
  test.true( Mixin.map !== Class1.map );
  test.true( Class1.map === instance1.map );

  test.true( map === Class2.prototype.Statics.map.val );
  test.true( Class2.map === Class2.prototype.map );
  test.true( map !== Class2.map );
  test.true( Mixin.map !== Class2.map );
  test.true( Class2.map === instance2.map );

  test.case = 'wrap in map';

  test.true( map[ 0 ] === Mixin.map[ 0 ] );
  test.true( map[ 0 ] === Mixin.prototype.Statics.map.val[ 0 ] );
  test.true( map[ 0 ] === Mixin.prototype.map[ 0 ] );
  test.true( map[ 0 ] === Class1.prototype.Statics.map.val[ 0 ] );
  test.true( map[ 0 ] === Class1.prototype.map[ 0 ] );
  test.true( map[ 0 ] === Class1.map[ 0 ] );
  test.true( map[ 0 ] === instance1.map[ 0 ] );
  test.true( map[ 0 ] === Class2.prototype.Statics.map.val[ 0 ] );
  test.true( map[ 0 ] === Class2.prototype.map[ 0 ] );
  test.true( map[ 0 ] === Class2.map[ 0 ] );
  test.true( map[ 0 ] === instance2.map[ 0 ] );

  /* - */

  if( !Config.debug )
  return;

  test.will = 'constructor in extend';

  test.shouldThrowErrorOfAnyKind( function()
  {

    function Mixin()
    {
    }

    var Extension =
    {
    }

    Extension.constructor = Mixin;

    _.classDeclare
    ({
      cls : Mixin,
      extend : Extension,
      withMixin : 1,
    });

  });

}

//

function customFieldsGroups( test )
{

  /* - */

  test.case = 'setup';

  function BasicConstructor(){}

  var Extension =
  {
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extension,
  });

  /* */

  function DerivedConstructor1(){}

  var Groups =
  {
    Names : 'Names',
  }

  var Names1 =
  {
    a : [ 1 ],
    b : [ 1 ],
  }

  var Extension =
  {
    Names : Names1,
    Groups,
  }

  _.classDeclare
  ({
    parent : BasicConstructor,
    cls : DerivedConstructor1,
    extend : Extension,
  });

  /* */

  function DerivedConstructor2(){}

  var Names2 =
  {
    b : [ 2 ],
    c : [ 2 ],
  }

  var Extension =
  {
    Names : Names2,
  }

  _.classDeclare
  ({
    parent : DerivedConstructor1,
    cls : DerivedConstructor2,
    extend : Extension,
  });

  /* */

  function DerivedConstructor3(){}

  _.classDeclare
  ({
    parent : DerivedConstructor2,
    cls : DerivedConstructor3,
  });

  /* */

  var instance0 = new BasicConstructor();
  var instance1 = new DerivedConstructor1();
  var instance2 = new DerivedConstructor2();
  var instance3 = new DerivedConstructor3();

  test.will = 'check base class';

  test.true( !!instance0.Groups );
  test.true( !!BasicConstructor.prototype.Groups );
  test.true( instance0.Groups === BasicConstructor.prototype.Groups );

  test.will = 'check dervied class1';

  test.true( !!instance1.Groups );
  test.true( !!DerivedConstructor1.prototype.Groups );
  test.true( instance1.Groups === DerivedConstructor1.prototype.Groups );
  test.true( instance1.Groups !== instance0.Groups );
  test.true( DerivedConstructor1.prototype.Groups !== instance0.Groups );
  test.true( instance1.Names.a === Names1.a );
  test.true( instance1.Names.b === Names1.b );
  test.true( instance1.Names.c === Names1.c );

  test.will = 'check dervied class2';

  test.true( !!instance2.Groups );
  test.true( !!DerivedConstructor2.prototype.Groups );
  test.true( instance2.Groups === DerivedConstructor2.prototype.Groups );
  test.true( instance2.Groups !== instance0.Groups );
  test.true( DerivedConstructor2.prototype.Groups !== instance0.Groups );
  test.true( instance2.Groups !== instance1.Groups );
  test.true( DerivedConstructor2.prototype.Groups !== instance1.Groups );
  test.true( instance2.Names.a === Names1.a );
  test.true( instance2.Names.b === Names2.b );
  test.true( instance2.Names.c === Names2.c );

  test.will = 'check dervied class3';

  test.true( !!instance3.Groups );
  test.true( !!DerivedConstructor3.prototype.Groups );
  test.true( instance3.Groups === DerivedConstructor3.prototype.Groups );
  test.true( instance3.Groups !== instance0.Groups );
  test.true( DerivedConstructor3.prototype.Groups !== instance0.Groups );
  test.true( instance3.Groups !== instance1.Groups );
  test.true( DerivedConstructor3.prototype.Groups !== instance1.Groups );
  test.true( instance3.Names.a === Names1.a );
  test.true( instance3.Names.b === Names2.b );
  test.true( instance3.Names.c === Names2.c );

}

//

function staticFieldsPreserving( test )
{

  function BasicConstructor(){}

  function init()
  {
  }

  function basicSet()
  {
    console.log( 'basicSet' )
  }

  var Extension =
  {
    init,
    Statics :
    {
      set : basicSet
    }
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    parent : null,
    extend : Extension,
  });

  /* */

  var DerivedConstructor1 = function DerivedConstructor1()
  {
    return _.workpiece.construct( DerivedConstructor1, this, arguments );
  }

  function derivedSet()
  {
    console.log( 'derivedSet' )
  }

  var Extension =
  {
    Statics :
    {
      set : derivedSet
    }
  }

  _.classDeclare
  ({
    parent : BasicConstructor,
    cls : DerivedConstructor1,
    extend : Extension,
  });

  /* problem */

  test.identical( BasicConstructor.prototype.set, basicSet );
  test.identical( DerivedConstructor1.prototype.set, derivedSet );

  var instance = DerivedConstructor1();

  test.identical( BasicConstructor.prototype.set, basicSet );
  test.identical( DerivedConstructor1.prototype.set, derivedSet );

}

//

function workpieceConstruct( test )
{

  function BasicConstructor()
  {
    return _.workpiece.construct( BasicConstructor, this, arguments );
  }

  function init()
  {
    counter += 1;
  }

  var counter = 0;
  var Extension =
  {
    init,
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    parent : null,
    extend : Extension,
  });

  /* */

  test.case = 'no new';

  counter = 0;
  var instance = BasicConstructor();
  test.true( instance instanceof BasicConstructor );
  test.true( instance.constructor === BasicConstructor );
  test.true( instance.init === init );
  test.identical( counter, 1 );

  var instance2 = BasicConstructor( instance );
  test.true( instance2 instanceof BasicConstructor );
  test.true( instance2.constructor === BasicConstructor );
  test.true( instance2.init === init );
  test.true( instance === instance2 );
  test.identical( counter, 1 );

  /* */

  test.case = 'with new';

  counter = 0;
  var instance = new BasicConstructor();
  test.true( instance instanceof BasicConstructor );
  test.true( instance.constructor === BasicConstructor );
  test.true( instance.init === init );
  test.identical( counter, 1 );

  var instance2 = new BasicConstructor( instance );
  test.true( instance2 instanceof BasicConstructor );
  test.true( instance2.constructor === BasicConstructor );
  test.true( instance2.init === init );
  test.true( instance !== instance2 );
  test.identical( counter, 2 );

  /* */

  test.case = 'array';

  counter = 0;
  var Instances = BasicConstructor([ 1,null,3 ]);
  test.identical( Instances.length, 2 );
  test.true( Instances[ 0 ] instanceof BasicConstructor );
  test.true( Instances[ 0 ].constructor === BasicConstructor );
  test.true( Instances[ 0 ].init === init );
  test.true( Instances[ 1 ] instanceof BasicConstructor );
  test.true( Instances[ 1 ].constructor === BasicConstructor );
  test.true( Instances[ 1 ].init === init );
  test.identical( counter, 2 );

  var instances2 = BasicConstructor( Instances );
  test.identical( instances2.length, 2 );
  test.true( instances2[ 0 ] instanceof BasicConstructor );
  test.true( instances2[ 0 ].constructor === BasicConstructor );
  test.true( instances2[ 0 ].init === init );
  test.true( instances2[ 1 ] instanceof BasicConstructor );
  test.true( instances2[ 1 ].constructor === BasicConstructor );
  test.true( instances2[ 1 ].init === init );
  test.true( instances2[ 0 ] === Instances[ 0 ] );
  test.true( instances2[ 1 ] === Instances[ 1 ] );
  test.identical( counter, 2 );

}

// //
//
// function defineShallow( test )
// {
//
//   var Settings = _.blueprint
//   .define
//   ({
//     size : _.define.shallow([ 2,2,2 ]),
//     usingExploding : 0,
//   })
//
//   var Composes =
//   {
//   }
//
//   _.construction.extend( Composes, Settings );
//
//   function Cls()
//   {
//     _.workpiece.initFields( this );
//   }
//
//   _.classDeclare
//   ({
//     cls : Cls,
//     parent : null,
//     extend :
//     {
//       Composes,
//     }
//   });
//
//   var instance = new Cls();
//   test.identical( instance.size, [ 2, 2, 2 ] );
//   test.identical( instance.usingExploding, 0 );
//   test.true( instance.size !== Settings.size );
//
// }

// --
// declare
// --

const Proto =
{

  name : 'Tools.l3.class',
  silencing : 1,

  tests :
  {

    classDeclare,
    staticsDeclare,
    staticsOverwrite,
    mixinStaticsWithDefinition,

    customFieldsGroups,

    staticFieldsPreserving,
    workpieceConstruct,

    // defineShallow,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
