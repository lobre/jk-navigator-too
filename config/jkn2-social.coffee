
configs = []
meta =
  name: "Social Networks"
  comment: "Facebook, Twitter, etc."

configs.push
  name: "Facebook Home Page"
  regexps: "^https?://www\\.facebook\\.com/?$"
  selectors: "div[data-timestamp] > div.userContentWrapper"
  activators: [ "div.fbstoryattachmentimage img", "a[rel=theater]" ]
  style:
    "border-color": "#3b5998"
    opacity: "0.2"

configs.push
  name: "Facebook"
  regexps: "^https?://www\\.facebook\\.com/."
  selectors: [
    "div#content div.userContentWrapper"
  ]
  activators: [
    "div.fbstoryattachmentimage img",
    "a[rel=theater]"
    "i > input[type='button']"
  ]
  style:
    "border-color": "#3b5998"
    opacity: "0.2"

configs.push
  name: "Reddit Comments"
  regexps: "^http://www\\.reddit\\.com/.*/comments/"
  selectors: [
    "div#siteTable div.usertext-body"
    "div.commentarea > div.sitetable > div.comment"
  ]
  activators: "a[href^='http']:not(.author)"
  offset: 20

configs.push
  name: "Reddit"
  regexps: "^http://www\\.reddit\\.com/?"
  selectors: "div.entry > p.title > a"
  offset: 20

configs.push
  name: "Twitter"
  regexps: "^https?://([a-z]+\\.)?twitter.com/?"
  selectors: [
    "div.home-stream div.content"
    "div.profile-stream div.content"
    "div.list-stream div.content"
    "div.new-tweets-bar"
  ]
  offset: 80
  style:
    "border-color": "#55B4CF"

# This uses Google Plus' native JK bindings.
configs.push
  # noclick: true
  name: "Google Plus"
  regexps: "^https?://plus\\.google\\.com"
  # NOTE: This is pretty dodgy.  Google doesn't the active element.  Instead, we detect its CSS.
  # Unfortunately, this looks like it's been through a minifier.  So it could easily change.
  activeSelector: "div.tk.va[id^=update-]"
  activators: [
    "div[role='button'][aria-label='Play'" # Launch videos.
    "a[target='_blank'][href^='http']:not([oid]):not([itemprop='map'])" # External links (but not maps).
    "a[href^='photos/']" # Photos.
  ]
  nativeJK: true

process.stdout.write require("../common.js").Common.mkConfigs configs, meta

