
configs = []

configs.push
  name: "BBC News"
  regexps: [
    "^https?://www\\.bbc\\.(com|co\\.uk)/news/?$"
    "^https?://www\\.bbc\\.(com|co\\.uk)/news/.*[^0-9]$"
  ]
  selectors: [
    "div.column--primary a[tabindex]"
    "div.vertical-promo a.bold-image-promo"
    "div#comp-digest-2 div[data-entityid^='more-from-bbc-news']"
    "div.correspondent-promo div.correspondent-promo__correspondent"
  ]
  offset: 20
  style:
    "z-index": 2000000000

console.log JSON.stringify configs, null, "  "

