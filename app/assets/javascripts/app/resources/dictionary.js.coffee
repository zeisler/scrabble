@Dictionary  = class Dictionary
  @word: (word) ->
    response = jQuery.ajax(
      async: false
      method: "GET"
      url: "/word/#{word}.json"
    ).success((data, status, headers, config) ->
      if data.word == word
        # success()
        console.log "Word: #{word} is a valid word."
    ).error (data, status, headers, config) ->
        # error()
        console.log "Word: #{word} is not a valid word."
    if response.status != 404 && JSON.parse(response.responseText).word == word
      return true
    else
      return false
