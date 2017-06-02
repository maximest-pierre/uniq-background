{CompositeDisposable} = require 'atom'
md5 = require('blueimp-md5').md5

module.exports =
  config:
    imageUrls:
      description: 'Array of image url.'
      type: 'array'
      default: [ "http://68.media.tumblr.com/b998d320449479ff5eb68c6d357a917f/tumblr_n1o9ig5tvP1sfso7wo1_400.gif","http://68.media.tumblr.com/1dbf5d1a52f6436e65372b8ba2bdc18c/tumblr_n9r42qoXKt1s391qwo1_500.gif", "http://68.media.tumblr.com/408ddb851f1f888d790fdfd5cd145a7f/tumblr_n3sakm7eip1txj6nyo1_400.gif", "http://68.media.tumblr.com/2d98cb004a735ede0a52eb19fe394d1d/tumblr_nka9ry5h9c1sf7ja3o1_500.gif", "http://68.media.tumblr.com/5291bcbd1b30c38a04ede87309ec1a22/tumblr_ngqebwMUAc1svxaato1_250.gif",
      "http://68.media.tumblr.com/2f9cfcb36ccd7b24714f53e465a827ca/tumblr_mwo9tfPGY21r1p6w8o1_500.gif",
      "http://68.media.tumblr.com/ca068f51441f19dea03740fa4d36fb4a/tumblr_mwhophNr3S1shvk9no1_400.gif",]
      items:
        type: 'string'

  subscriptions: null

  activate: ->
    @srcs = atom.config.get('uniq-background.imageUrls')
    @subscriptions = new CompositeDisposable
    @subscriptions.add(atom.workspace.observeTextEditors((item) =>
      @addUniqBackground(item)
    ))

  addUniqBackground: (item) ->
    return unless item

    view = atom.views.getView(item)

    src = @srcForPath(item.getPath())
    image = document.createElement('img')
    image.className = 'uniq-image'
    image.src = src
    view.appendChild(image)

  srcForPath: (path)->
    number = parseInt(md5(path), 16)
    idx = number % @srcs.length
    @srcs[idx]
