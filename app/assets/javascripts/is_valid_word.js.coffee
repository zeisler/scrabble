window.is_valid_word = (word, callback) ->
  window.response  = null
  $.getJSON "/word/#{word}.json", (data) ->
    callback()

# do_when_done = ->
#   console.log "done"
# console.log window.is_valid_word('apple', do_when_done)
