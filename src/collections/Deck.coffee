class window.Deck extends Backbone.Collection
  model: Card

  initialize:(params)->
      # for i in [0...params.length]
      @addDeck()

      @on('remove',->
        if @length < 10
          @addDeck()
      , @)

  dealPlayer: ->
    player = new Hand([@pop(), @pop()], @ , false)
    player.flipCardsForPreGame();
    player

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  addDeck: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

