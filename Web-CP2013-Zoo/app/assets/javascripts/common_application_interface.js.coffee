# Common Application Interface
#
# Acts as a template (in regards to the template pattern) for all application types.
#
# Also is an example of a command type interface.
window.CommonApplicationInterface = {
  run: ->
    @defineViews()
    @defineCollections()
    @updateCollections()
    @render()
}
