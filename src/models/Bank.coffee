class window.Bank extends Backbone.Model
  initialize: (value) ->
    @set 'value' , value
    @set 'currentBet' , 0

  bet:(amount)->
    @set 'currentBet' , amount
    @set('value',@get('value') - amount)

  payOut: (win , blackJack) ->
    if blackJack
      @set('value',@get('value') + @get('currentBet') * 2.5)
    else if win
      @set('value',@get('value') + @get('currentBet') * 2)
    @set('currentBet',0)
