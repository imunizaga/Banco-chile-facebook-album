class BancoChile.Routers.ChallengesRouter extends Backbone.Router
  initialize: (options) ->
    @challenges = new BancoChile.Collections.ChallengesCollection()
    @challenges.reset options.challenges

  routes:
    "new"      : "newChallenge"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newChallenge: ->
    @view = new BancoChile.Views.Challenges.NewView(collection: @challenges)
    $("#challenges").html(@view.render().el)

  index: ->
    @view = new BancoChile.Views.Challenges.IndexView(challenges: @challenges)
    $("#challenges").html(@view.render().el)

  show: (id) ->
    challenge = @challenges.get(id)

    @view = new BancoChile.Views.Challenges.ShowView(model: challenge)
    $("#challenges").html(@view.render().el)

  edit: (id) ->
    challenge = @challenges.get(id)

    @view = new BancoChile.Views.Challenges.EditView(model: challenge)
    $("#challenges").html(@view.render().el)
