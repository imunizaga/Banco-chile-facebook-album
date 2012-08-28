BancoChile.Views.Users ||= {}

class BancoChile.Views.Users.RankingItemView extends Backbone.View
  template: JST["backbone/templates/users/ranking_item"]
  tagName: "li"

  initialize: () ->
    @user = @options.user
    @className = @options.class

  render: =>
    $el = $(@el)
    $el.html(@template(user: @user.toJSON()))
    $el.addClass(@className)
    $el.find(".js-user-image").tipTip()
    return this
