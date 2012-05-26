BancoChile.Views.UserCards ||= {}

class BancoChile.Views.UserCards.IndexView extends Backbone.View
  template: JST["backbone/templates/user_cards/index"]

  initialize: () ->
    @options.userCards.bind('reset', @addAll)

  addAll: () =>
    @options.userCards.each(@addOne)

  addOne: (userCard) =>
    view = new BancoChile.Views.UserCards.UserCardView({model : userCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(userCards: @options.userCards.toJSON() ))
    @addAll()

    return this
