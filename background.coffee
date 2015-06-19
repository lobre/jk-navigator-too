
logEvent = (event, url) ->
  event.error ?= false
  event.url ?= url if url

  chrome.storage.local.get "log", (items) ->
    items.log ?= []
    items.log = items.log.reverse()[..100].reverse()
    items.log.push event
    chrome.storage.local.set items

do ->
  forceConfigUpdate = true

  chrome.storage.local.get "configs", (items) =>
    unless chrome.runtime.lastError
      if forceConfigUpdate or not items.configs
        obj = {}; obj.configs = Common.defaults
        chrome.storage.local.set obj

do ->
  updateIcon = (request, sender) ->
    console.log request
    console.log sender
    if request.show
      chrome.pageAction.show sender.tab.id
    else
      # chrome.pageAction.hide sender.tab.id
    false # We will not be calling sendResponse.

  handlers =
    icon: updateIcon

  chrome.runtime.onMessage.addListener (request, sender, sendResponse) ->
    if handlers[request.name]?
      handlers[request.name]? request, sender, sendResponse
    else
      false

do ->
  urls = [ "http://smblott.org/jk-navigator-too.txt" ]

  success = (xhr, url) ->
    text = xhr.responseText
    try
      json = JSON.parse text
    catch
      console.error "JSON parse error", url
      return
    obj = {}; obj.custom = json
    chrome.storage.local.set obj, ->
      if chrome.runtime.lastError
        console.error "storage error", url
      else
        console.log "ok", url, "\n"
        for config in json
          console.log "#{config.name}: #{config.regexps}"
          if config.selectors
            for selector in Common.stringToArray config.selectors
              console.log "  #{selector}"
        console.log xhr

  failure = (xhr, url) ->
    console.error "fetch error", url

  for url in urls
    do (url) ->
      date = new Date
      url = "#{url}?date=#{date.getTime()}"
      xhr = new XMLHttpRequest()
      xhr.open "GET", url, true
      xhr.timeout = 5000
      xhr.ontimeout = xhr.onerror = (xhr) -> failure xhr, url

      xhr.onreadystatechange = ->
        if xhr.readyState == 4
          (if xhr.status == 200 then success else failure) xhr, url

      xhr.send()

