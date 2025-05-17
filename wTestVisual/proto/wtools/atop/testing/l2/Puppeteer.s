( function _Puppeteer_s_()
{

'use strict';

const _global = _global_;
const _ = _global_.wTools;
_.test = _.test || Object.create( null );
_.test.visual = _.test.visual || Object.create( null );
_.test.visual.puppeteer = _.test.visual.puppeteer || Object.create( null );

let Puppeteer, PuppeteerRevisions;

//

function browserDownload( browser )
{
  browser = browser ? browser : 'chromium';
  _.assert( [ 'chromium', 'firefox' ].includes( browser ), 'Unknown browser : ', browser );
  let product = browser === 'chromium' ? 'chrome' : browser;
  if( !Puppeteer )
  {
    Puppeteer = require( 'puppeteer' );
    PuppeteerRevisions = require( 'puppeteer/lib/cjs/puppeteer/revisions.js' );
  }

  let browserFetcher = Puppeteer.createBrowserFetcher({ product });
  let targetRevision = PuppeteerRevisions.PUPPETEER_REVISIONS[ browser ];

  let ready = _.take( null );
  if( browser === 'firefox' )
  ready = firefoxTargetRevisionSet();
  ready.then( () => browserFetcher.localRevisions() );
  ready.then( ( localRevisions ) =>
  {
    if( _.longHas( localRevisions, targetRevision ) )
    return null;
    return _.Consequence.From( browserFetcher.download( targetRevision ) ).then( () => targetRevision );
  });

  return ready;

  function firefoxTargetRevisionSet()
  {
    return _.http.retrieve( 'https://product-details.mozilla.org/1.0/firefox_versions.json' )
    .then( ( res ) =>
    {
      const versionsInfo = res.response.body;
      targetRevision = versionsInfo.FIREFOX_NIGHTLY;
      return null;
    });
  }
}

//

let Extension =
{
  browserDownload,
}


Object.assign( _.test.visual.puppeteer, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
