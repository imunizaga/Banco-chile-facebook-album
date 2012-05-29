class BancoChile.Routers.UsersRouter extends Backbone.Router
  initialize: (options) ->
    @user = new BancoChile.Models.User()

  routes:
    ""      : "index"
    "game"    : "game"

  index: ->
    @view = new BancoChile.Views.Home.IndexView(user: @user)
    $("#container").html(@view.render().el)

  game: ->
    @view = new BancoChile.Views.Game.IndexView(user: @user)
    $("#container").html(@view.render().el)

 