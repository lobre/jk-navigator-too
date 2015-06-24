
configs = []

configs.push
  name: "Facebook Home Page"
  regexps: "^https?://www\\.facebook\\.com/?$"
  selectors: [
    # CSS version.
    # "div[data-timestamp] > div.userContentWrapper"
    # xPath version (this allows us to select the parent).
    "//div[@data-timestamp]/div[contains(@class,'userContentWrapper')]/.."
  ]
  activators: [ "div.fbstoryattachmentimage img", "a[rel=theater]" ]
  offset: 65
  style:
    "border-color": "#3b5998"
    opacity: "0.2"

configs.push
  name: "Facebook"
  regexps: "^https?://www\\.facebook\\.com/."
  selectors: [
    # CSS version.
    # "div#content div.userContentWrapper"
    # xPath version (this allows us to select the parent).
    "//div[@id='content']//div[contains(@class,'userContentWrapper')]/.."
  ]
  activators: [
    "div.fbstoryattachmentimage img",
    "a[rel=theater]"
    "i > input[type='button']"
  ]
  offset: 65
  style:
    "border-color": "#3b5998"
    opacity: "0.2"

configs.push
  name: "Reddit Comments"
  regexps: "^http://[a-z]+\\.reddit\\.com/.*/comments/"
  selectors: [
    "div#siteTable div.usertext-body"
    "div.commentarea > div.sitetable > div.comment"
  ]
  activators: "a[href^='http']:not(.author):not(.bylink)"

configs.push
  name: "Reddit"
  regexps: "^http://[a-z]+\\.reddit\\.com/?"
  selectors: "div.entry > p.title > a"

configs.push
  name: "Twitter"
  regexps: "^https?://([a-z]+\\.)?twitter.com/?"
  selectors: [
    "div.home-stream div.original-tweet"
    "div.home-stream li.conversation-root"
    "div.home-stream li.js-simple-tweet"

    "div.profile-stream div.original-tweet"
    "div.profile-stream li.conversation-root"
    "div.profile-stream li.js-simple-tweet"

    "div.list-stream div.original-tweet"
    "div.profile-stream li.conversation-root"
    "div.profile-stream li.js-simple-tweet"

    "div.new-tweets-bar"

    # "div.home-stream div.content"
    # "div.profile-stream div.content"
    # "div.list-stream div.content"
    # "div.new-tweets-bar"
  ]
  activators: [
    "div.original-tweet a.twitter-timeline-link"
    # "div.multi-photos"
    # # View/Hide conversation (also view photo).
    # "div.stream-item-footer span.expand-stream-item"
    # "div.stream-item-footer span.collapse-stream-item"
  ]
  offset: 80
  # style:
  #   "border-color": "#55B4CF"

configs.push
  name: "Imgur Albums"
  regexps: "^https?://([a-z]+\\.)?imgur.com/a/."
  selectors: "div#image-container > div.image"

# This uses Google Plus' native JK bindings.
configs.push
  name: "Google Plus"
  native: true
  regexps: "^https?://plus\\.google\\.com"
  # NOTE: This is pretty dodgy.  Google doesn't set activeElement.  Instead, we detect its CSS.
  # Unfortunately, this looks like it's been through a minifier.  So it could easily change.
  activeSelector: "div.tk.va[id^=update-]"
  activators: [
    "div[role='button'][aria-label='Play'" # Launch videos.
    "a[target='_blank'][href^='http']:not([oid]):not([itemprop='map'])" # External links (but not maps).
    "a[href^='photos/']" # Photos.
  ]

require("../common.js").Common.mkConfigs configs,
  name: "Social Networks"
  comment: "Facebook, Twitter, Reddit, etc."

