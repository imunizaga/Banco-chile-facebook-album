class BancoChile.Views.Users.RankingItemView extends Backbone.View
  template: JST["backbone/templates/users/ranking_item"]

  initialize: () ->
    @user = @options.user

  render: =>
    $(@el).html(@template(user: @user.toJSON()))
    return this
