{CompositeDisposable} = require 'event-kit'

module.exports =
  active: false
  views: {}

  isActive: -> @active

  activate: (state) ->
    atom.packages.activatePackage('minimap').then (minimapPackage) =>
      @minimap = minimapPackage.mainModule
      return @deactivate() unless @minimap.versionMatch('>= 3.5.0')

      @subscriptions = new CompositeDisposable
      @minimap.registerPlugin 'vim-sneak', this

  deactivate: ->
    @minimap.unregisterPlugin 'vim-sneak'
    @minimap = null

  activatePlugin: ->
    return if @active

    @active = true

    @subscription = @minimap.observeMinimaps (minimap) =>
      minimapElement = atom.views.getView(minimap)

      # ...

  deactivatePlugin: ->
    return unless @active

    @active = false
    @subscription.dispose()
    @subscriptions.dispose()
