# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'bank' , new Bank(100)
    @set 'winner' , null
    @set 'outcome' , null

  redeal: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

  findWinner:->
    if @get('playerHand').bestScore() > @get('dealerHand').bestScore()
       @setWinner('player')
    else
      @setWinner('dealer')

  setWinner: (winner) ->
      @set 'winner' , winner
      if winner is 'player'
        if outcome is 'Black Jack!!'
          @get('bank').payOut(true,true)
        else
          @get('bank').payOut(true,false)
      else
        @get('bank').payOut(false,false)



