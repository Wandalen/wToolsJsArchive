( function _PageFunctionality_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  require( './Abstract.test.s' );
}

const _ = _global_.wTools;
const Parent = wTests[ 'Tools.TestVisual.Abstract' ];
_.assert( !!Parent );

//

async function evaluate( test )
{
  let context = this;
  let a = context.assetFor( test );
  a.entryPath = 'trivial/Setup.html';

  return a.inBrowser( async ( page ) =>
  {
    test.case = 'callback returns value, no args';
    var got = await page.evaluate( () => true );
    test.identical( got, true );

    test.case = 'callback returns value, with args';
    var got = await page.evaluate( () => true, 1, 'str' );
    test.identical( got, true );

    /* */

    test.case = 'callback with args returns args, no args passed';
    var got = await page.evaluate( ( arg1, arg2 ) => [ arg1, arg2 ] );
    test.identical( got, [ null, null ] );

    test.case = 'callback with args returns args, args passed';
    var got = await page.evaluate( ( arg1, arg2 ) => [ arg1, arg2 ], 1, 'str' );
    test.identical( got, [ 1, 'str' ] );

    /* */

    test.case = 'callback returns promise';
    var got = await page.evaluate( () => Promise.resolve( 1 ) );
    test.identical( got, 1 );

    test.case = 'async callback returns value === promise';
    var got = await page.evaluate( async () => 1 );
    test.identical( got, 1 );

    test.case = 'async callback returns another not awaited promise';
    var got = await page.evaluate( async () => new Promise( (resolve, reject ) =>
    {
      setTimeout( () => resolve( 1 ), 500 );
    }));
    test.identical( got, 1 );

    /* eslint-disable no-return-await */
    test.case = 'async callback returns another awaited promise';
    var got = await page.evaluate( async () => await new Promise( (resolve, reject ) =>
    {
      setTimeout( () => resolve( 1 ), 500 );
    }));
    test.identical( got, 1 );

    test.case = 'async callback with args returns another awaited promise, args passed';
    var got = await page.evaluate( async ( arg ) => await new Promise( (resolve, reject ) =>
    {
      setTimeout( () => resolve( arg ), 500 );
    }), 1);
    test.identical( got, 1 );
    /* eslint-enable no-return-await */

    /* - */

    if( !Config.debug )
    return;

    test.case = 'callback returns another awaited promise';
    return test.shouldThrowErrorAsync( () => page.evaluate( () => { throw Error } ));
  });
}

evaluate.timeOut = 180000;

//

function waitForFunction( test )
{
  let context = this;
  let a = context.assetFor( test );
  a.entryPath = 'trivial/Setup.html';

  return a.inBrowser( async ( page ) =>
  {
    test.case = 'callback returns true, no delay';
    var now = _.time.now();
    await page.waitForFunction( () => true, { timeout : 10000 } );
    test.ge( _.time.now() - now, 1 );

    test.case = 'callback returns promise, that resolves before time out';
    var now = _.time.now();
    await page.waitForFunction( () => new Promise( ( resolve, reject ) =>
    {
      setTimeout( () => resolve( true ), 3000 );
    }), { timeout : 10000 } );
    test.ge( _.time.now() - now, 3000 );

    test.case = 'callback returns promise, that resolves before time out';
    test.shouldThrowErrorAsync( () =>
    {
      return page.waitForFunction( () => new Promise( ( resolve, reject ) =>
      {
        setTimeout( () => resolve( true ), 3000 );
      }), { timeout : 1000 } );
    });

    test.case = 'callback returns false';
    test.shouldThrowErrorAsync( () =>
    {
      return page.waitForFunction( () => false, { timeout : 1000 } );
    });
  });
}

waitForFunction.timeOut = 180000;

//

let Suite =
{
  name : 'Tools.TestVisual.PageFunctionality',

  silencing : 1,

  tests :
  {
    evaluate,
    waitForFunction,
  }
};

//

let Self = wTestSuite( Suite ).inherit( Parent );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
