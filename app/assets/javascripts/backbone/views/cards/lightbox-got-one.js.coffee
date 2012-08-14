BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxGotOneView extends BancoChile.Views.Cards.LightboxContent
  template: JST["backbone/templates/cards/lightbox-got-one"]

  render: ->
    @friends = @user.friendsWithoutCard(@card)
    return super()
