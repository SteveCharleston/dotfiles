// search for selected text
vimfx.listen('getSelection', (data, callback) => {
  let selection = content.getSelection().toString()
  callback(selection)
})
